import SwiftUI
import SpriteKit

struct GameView: View {
    @EnvironmentObject var viewModel: GameViewModel
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

                    if viewModel.phase == .won || viewModel.phase == .lost {
                        resultOverlay
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
                }
                .onChange(of: viewModel.reloadTrigger) { _ in
                    loadCurrentLevel()
                }
                .onChange(of: viewModel.showTutorial) { isShowing in
                    scene.isGameplayPaused = isShowing
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

            bottomBar
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

            levelChip(title: viewModel.levelTitle)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .background(.thinMaterial)
    }

    private var bottomBar: some View {
        HStack(spacing: 12) {
            ammoChip(count: viewModel.ammoRemaining)

            Spacer()

            if viewModel.isRandomMode {
                smallButton(title: "Skip") { viewModel.skipRandomLevel() }
            } else if viewModel.hasInstructions {
                smallButton(title: "Help") { viewModel.showInstructions() }
            }

            smallButton(title: "Restart") {
                viewModel.restartLevel()
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .background(.thinMaterial)
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
                Text(viewModel.isCampaignVictory ? "You win!" : didWin ? "LEVEL COMPLETE!" : "TRY AGAIN")
                    .font(.system(size: 28, weight: .heavy, design: .rounded))
                    .foregroundColor(didWin ? .green : .red)

                if viewModel.isCampaignVictory {
                    Text("You completed all \(viewModel.levels.count) campaign levels!")
                        .font(.subheadline.bold())
                        .multilineTextAlignment(.center)
                } else if let resultObjectType = viewModel.resultObjectType {
                    Text(viewModel.resultMessage ?? "All objects are \(resultObjectType.displayName).")
                        .font(.subheadline.bold())
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                }
            }

            if viewModel.isCampaignVictory {
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

            largeButton(title: "Replay Level") {
                viewModel.restartLevel()
            }

            largeButton(title: "Main Menu") {
                viewModel.goToMenu()
            }
        }
        .padding(24)
        .frame(maxWidth: 320)
        .background(.ultraThinMaterial)
        .cornerRadius(24)
        .shadow(radius: 10)
    }

    private func configureScene(size: CGSize) {
        scene.scaleMode = .resizeFill
        scene.size = size
        scene.backgroundColor = colorScheme == .dark ? .black : .white
        scene.applyTheme(isDarkMode: colorScheme == .dark)

        scene.onWin = { finalObjectType in
            viewModel.completeLevel(finalObjectType: finalObjectType)
        }

        scene.onLose = { finalObjectType in
            viewModel.failLevel(finalObjectType: finalObjectType, message: scene.lossMessage)
        }

        scene.canLaunchRock = {
            viewModel.phase == .playing && viewModel.ammoRemaining > 0
        }

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
        scene.isGameplayPaused = viewModel.showTutorial
        scene.load(level: viewModel.currentLevel)
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
