import SwiftUI
import SpriteKit

struct GameView: View {
    @EnvironmentObject var viewModel: GameViewModel
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.colorScheme) private var colorScheme

    @State private var scene = GameScene()
    @State private var ammoWarningFlash = false

    var body: some View {
        VStack(spacing: 0) {
            topBar

            GeometryReader { arenaGeo in
                ZStack {
                    backgroundColor
                        .ignoresSafeArea()
                    
                    SpriteView(scene: scene)
                        .ignoresSafeArea()

                    if viewModel.mode == .bet {
                        VStack { betBar; Spacer() }
                    }
                    if viewModel.phase == .won || viewModel.phase == .lost {
                        ScrollView { resultOverlay.padding(.vertical, 16) }
                    }
                    
                    if viewModel.phase == .countdown {
                        Text("\(viewModel.countdown)")
                            .font(.system(size: 80, weight: .heavy, design: .rounded))
                            .padding(30)
                            .background(.ultraThinMaterial)
                            .clipShape(Circle())
                            .accessibilityLabel("Starting in \(viewModel.countdown)")
                    }
                    if let message = viewModel.currentTutorialMessage,
                       viewModel.phase == .playing {
                        Color.black.opacity(0.25)
                            .contentShape(Rectangle())
                            .onTapGesture { }
                        ScrollView {
                            TutorialOverlay(
                                title: viewModel.levelTitle,
                                message: message,
                                isLastStep: viewModel.isLastTutorialStep,
                                onNext: { viewModel.advanceTutorial() },
                                onSkip: { viewModel.skipTutorial() }
                            )
                            .padding(.top, 16)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    }
                }
                .onAppear {
                    configureScene(size: arenaGeo.size)

                    loadCurrentLevel()
                }
                .onChange(of: arenaGeo.size) { newSize in
                    // Resize the live arena without resetting its objects or ammunition.
                    scene.size = newSize
                    if viewModel.mode == .bet && (viewModel.phase == .betting || viewModel.phase == .countdown) {
                        loadCurrentLevel()
                    }
                }
                .onChange(of: viewModel.reloadTrigger) { _ in
                    loadCurrentLevel()
                }
                .onChange(of: viewModel.showTutorial) { _ in
                    refreshPause()
                }
                .onChange(of: viewModel.phase) { _ in refreshPause() }
                .onChange(of: scenePhase) { _ in refreshPause() }
                .task(id: "\(viewModel.reloadTrigger)-\(viewModel.phase)-\(scenePhase)") {
                    guard viewModel.phase == .countdown, scenePhase == .active else { return }
                    while viewModel.phase == .countdown {
                        do { try await Task.sleep(nanoseconds: 1_000_000_000) } catch { return }
                        guard !Task.isCancelled else { return }
                        viewModel.advanceCountdown()
                    }
                }
                .onChange(of: viewModel.ammoWarningID) { _ in
                    flashAmmoCounter()
                }
                .onChange(of: colorScheme) { newScheme in
                    let isDark = newScheme == .dark
                    scene.backgroundColor = isDark ? .black : .white
                    scene.applyTheme(isDarkMode: isDark)
                }
            }

            if viewModel.mode != .bet { bottomBar }
        }
        .background(backgroundColor.ignoresSafeArea())
    }

    private var backgroundColor: Color {
        colorScheme == .dark ? .black : .white
    }
    private var topBar: some View {
        HStack(spacing: 12) {
            smallButton(title: "Menu") {
                viewModel.goToMenu()
            }

            Spacer()

            if viewModel.mode == .bet {
                VStack(spacing: 2) {
                    Text("Bet").font(.headline)
                    Text(viewModel.betRecordLabel).font(.subheadline).monospacedDigit()
                }
                Spacer()
                smallButton(title: "New Round") { viewModel.restartLevel() }
            } else {
                levelChip(title: viewModel.levelTitle)
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .background(.thinMaterial)
    }

    private var bottomBar: some View {
        HStack(spacing: 12) {
            if viewModel.mode == .balance {
                VStack(alignment: .leading) {
                    Text(GameViewModel.timeLabel(viewModel.balanceTime)).font(.headline).monospacedDigit()
                    Text("Best: \(GameViewModel.timeLabel(viewModel.balanceBestTime))").font(.subheadline)
                }
            } else if viewModel.mode == .rock {
                ammoChip(count: viewModel.ammoRemaining)
            }

            Spacer()

            if viewModel.mode == .bet {
                Text("Watch the arena").font(.subheadline).foregroundColor(.secondary)
            } else if viewModel.mode == .balance {
                Text("Unlimited rocks").font(.subheadline).foregroundColor(.secondary)
            } else if viewModel.isRandomMode {
                smallButton(title: "Skip") { viewModel.skipRandomLevel() }
            } else if viewModel.hasInstructions {
                smallButton(title: "Help") { viewModel.showInstructions() }
            }

            smallButton(title: viewModel.mode == .rock ? "Restart" : "New Round") {
                viewModel.restartLevel()
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .background(.thinMaterial)
    }

    private var betBar: some View {
        VStack(spacing: 8) {
            if viewModel.phase == .betting {
                Text("Who will be last? Choose before they move.").font(.subheadline.bold())
                HStack {
                    ForEach([ObjectType.rock, .paper, .scissors], id: \.self) { type in
                        Button { viewModel.chooseBet(type) } label: {
                            VStack(spacing: 4) {
                                Image(type.assetName).resizable().scaledToFit().frame(width: 24, height: 24)
                                Text(type.displayName.capitalized).font(.subheadline)
                            }
                            .frame(maxWidth: .infinity).padding(.vertical, 8)
                            .background(.thinMaterial).cornerRadius(12)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            } else if let choice = viewModel.betChoice {
                Text("Your pick: \(choice.displayName.capitalized)").font(.subheadline.bold())
            }
        }
        .padding(8)
        .background(.ultraThinMaterial)
        .cornerRadius(12)
        .padding(.horizontal, 12)
        .padding(.top, 8)
    }

    private var resultTitle: String {
        if viewModel.mode == .balance { return "Time’s up!" }
        if viewModel.mode == .bet { return viewModel.phase == .won ? "You won!" : "Try again!" }
        return viewModel.isCampaignVictory ? "You win!" : viewModel.phase == .won ? "LEVEL COMPLETE!" : "TRY AGAIN"
    }

    private var resultOverlay: some View {
        let didWin = viewModel.phase == .won

        return VStack(spacing: 16) {
            if let resultObjectType = viewModel.resultObjectType {
                Image(resultObjectType.assetName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 64, height: 64)
            }

            VStack(spacing: 6) {
                Text(resultTitle)
                    .font(.system(size: 28, weight: .heavy, design: .rounded))
                    .foregroundColor(didWin ? .green : .red)

                if viewModel.mode == .balance {
                    Text("Survived \(GameViewModel.timeLabel(viewModel.balanceTime))")
                    Text("Best: \(GameViewModel.timeLabel(viewModel.balanceBestTime))")
                    Text(viewModel.balanceLossMessage).font(.subheadline).foregroundColor(.secondary)
                } else if viewModel.mode == .bet, let winner = viewModel.resultObjectType {
                    Text("\(winner.displayName.capitalized) won.").font(.subheadline.bold())
                    Text(viewModel.betRecordLabel).monospacedDigit()
                } else if viewModel.isCampaignVictory {
                    Text("You completed all \(viewModel.levels.count) campaign levels!")
                        .font(.subheadline.bold())
                        .multilineTextAlignment(.center)
                } else if let resultObjectType = viewModel.resultObjectType {
                    Text("All objects are \(resultObjectType.displayName).")
                        .font(.subheadline.bold())
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                }
            }

            if viewModel.mode != .rock {
                largeButton(title: "New Round", fill: .green) { viewModel.restartLevel() }
            } else if viewModel.isCampaignVictory {
                largeButton(title: "Play Random Levels", fill: .green) {
                    viewModel.startRandomGame()
                }
            } else if viewModel.isRandomMode {
                largeButton(title: "Next Random Level", fill: .green) {
                    viewModel.skipRandomLevel()
                }
            } else if viewModel.phase == .won && viewModel.hasNextLevel {
                largeButton(title: "Next Level", fill: .green) {
                    viewModel.goToNextLevel()
                }
            }

            if viewModel.mode == .rock {
                largeButton(title: "Replay Level") { viewModel.restartLevel() }
            }

            largeButton(title: "Main Menu") {
                viewModel.goToMenu()
            }
        }
        .padding(24)
        .frame(maxWidth: 320)
        .background(backgroundColor.opacity(0.60))
        .overlay(RoundedRectangle(cornerRadius: 24).stroke(Color.primary.opacity(0.18)))
        .cornerRadius(24)
        .shadow(radius: 10)
    }

    private func configureScene(size: CGSize) {
        scene.scaleMode = .resizeFill
        scene.size = size
        scene.backgroundColor = colorScheme == .dark ? .black : .white
        scene.applyTheme(isDarkMode: colorScheme == .dark)

        scene.onWin = { finalObjectType in
            if viewModel.mode == .bet { viewModel.resolveBet(winner: finalObjectType) }
            else { viewModel.completeLevel(finalObjectType: finalObjectType) }
        }

        scene.onLose = { finalObjectType in
            viewModel.failLevel(finalObjectType: finalObjectType)
        }

        scene.canLaunchRock = { viewModel.canFire }
        scene.onBalanceTick = { viewModel.balanceTime = $0 }
        scene.onBalanceEnd = { time, missing in viewModel.finishBalance(at: time, missing: missing) }

        scene.didUseAmmo = {
            viewModel.useAmmo()
        }

        scene.didTryLaunchWithoutAmmo = {
            viewModel.warnNoAmmoIfNeeded()
        }
    }

    private func loadCurrentLevel() {
        scene.backgroundColor = colorScheme == .dark ? .black : .white
        scene.applyTheme(isDarkMode: colorScheme == .dark)
        scene.mode = viewModel.mode
        refreshPause()
        scene.load(level: viewModel.currentLevel)
    }

    private func refreshPause() {
        scene.isGameplayPaused = viewModel.showTutorial || viewModel.phase != .playing || scenePhase != .active
    }

    private func levelChip(title: String) -> some View {
        HStack(spacing: 6) {
            Image(systemName: "flag.fill")
            Text(title)
                .font(.subheadline.bold())
                .lineLimit(1)
                .minimumScaleFactor(0.85)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .frame(minWidth: 120)
        .background(.thinMaterial)
        .cornerRadius(20)
    }

    private func ammoChip(count: Int) -> some View {
        let isEmpty = count == 0

        return HStack(spacing: 8) {
            Image("rock")
                .resizable()
                .scaledToFit()
                .frame(width: 18, height: 18)

            Text("\(count)")
                .font(.subheadline.bold())
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(isEmpty ? Color.red.opacity(ammoWarningFlash ? 0.85 : 0.28) : Color.clear)
        .background(.thinMaterial)
        .cornerRadius(20)
        .scaleEffect(ammoWarningFlash ? 1.12 : 1.0)
        .foregroundColor(isEmpty ? .red : .primary)
    }

    private func smallButton(title: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline.bold())
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .background(.thinMaterial)
                .cornerRadius(16)
        }
        .buttonStyle(PlainButtonStyle())
    }

    private func largeButton(
        title: String,
        fill: Color = Color.accentColor.opacity(0.22),
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(fill)
                )
        }
        .buttonStyle(PlainButtonStyle())
    }

    private func flashAmmoCounter() {
        withAnimation(.easeInOut(duration: 0.12)) {
            ammoWarningFlash = true
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.24) {
            withAnimation(.easeInOut(duration: 0.12)) {
                ammoWarningFlash = false
            }
        }
    }
}
