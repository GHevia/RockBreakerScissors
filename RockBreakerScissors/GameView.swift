import SwiftUI
import SpriteKit

struct GameView: View {
    @EnvironmentObject var viewModel: GameViewModel
    @Environment(\.colorScheme) private var colorScheme

    @State private var scene = GameScene()

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
                    
                    if viewModel.showTutorial {
                        TutorialOverlay(
                            message: currentTutorialMessage,
                            onNext: {
                                viewModel.nextTutorialStep()
                            },
                            onSkip: {
                                viewModel.skipTutorial()
                            }
                        )
                    }
                    
                }
                .onAppear {
                    configureScene(size: arenaGeo.size)

                    DispatchQueue.main.async {
                        scene.size = arenaGeo.size
                        loadCurrentLevel()
                        viewModel.startTutorialIfNeeded()
                    }
                }
                .onChange(of: arenaGeo.size) { newSize in
                    scene.size = newSize

                    DispatchQueue.main.async {
                        loadCurrentLevel()
                    }
                }
                .onChange(of: viewModel.currentLevelIndex) { _ in
                    loadCurrentLevel()
                    viewModel.startTutorialIfNeeded()
                }
                .onChange(of: viewModel.reloadTrigger) { _ in
                    loadCurrentLevel()
                    viewModel.startTutorialIfNeeded()
                }
                .onChange(of: viewModel.phase) { newPhase in
                    if newPhase == .playing {
                        loadCurrentLevel()
                        viewModel.startTutorialIfNeeded()
                    }
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
        
    private var currentTutorialMessage: String {
        guard viewModel.tutorialStep >= 0,
              viewModel.tutorialStep < viewModel.tutorialMessages.count else {
            return ""
        }

        return viewModel.tutorialMessages[viewModel.tutorialStep]
    }

    private var topBar: some View {
        HStack(spacing: 12) {
            smallButton(title: "Menu") {
                viewModel.goToMenu()
            }

            Spacer()

            levelChip(number: viewModel.levelNumber)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .background(.thinMaterial)
    }

    private var bottomBar: some View {
        HStack(spacing: 12) {
            ammoChip(count: viewModel.ammoRemaining)

            Spacer()

            smallButton(title: "Restart") {
                viewModel.restartLevel()
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .background(.thinMaterial)
    }

    private var resultOverlay: some View {
        VStack(spacing: 16) {
            Text(viewModel.resultTitle)
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .multilineTextAlignment(.center)

            if viewModel.phase == .won && viewModel.hasNextLevel {
                largeButton(title: "Next Level") {
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
            viewModel.failLevel(finalObjectType: finalObjectType)
        }

        scene.canLaunchRock = {
            viewModel.phase == .playing && viewModel.ammoRemaining > 0
        }

        scene.didUseAmmo = {
            viewModel.useAmmo()
        }
    }

    private func loadCurrentLevel() {
        scene.backgroundColor = colorScheme == .dark ? .black : .white
        scene.applyTheme(isDarkMode: colorScheme == .dark)
        scene.load(level: viewModel.currentLevel)
    }

    private func levelChip(number: Int) -> some View {
        HStack(spacing: 6) {
            Image(systemName: "flag.fill")
            Text("Level \(number)")
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
        HStack(spacing: 8) {
            Image("rock")
                .resizable()
                .scaledToFit()
                .frame(width: 18, height: 18)

            Text("\(count)")
                .font(.subheadline.bold())
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(.thinMaterial)
        .cornerRadius(20)
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

    private func largeButton(title: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.accentColor.opacity(0.22))
                )
        }
        .buttonStyle(PlainButtonStyle())
    }
}
