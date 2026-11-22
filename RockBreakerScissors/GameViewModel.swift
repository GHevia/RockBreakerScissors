import Foundation
import SwiftUI

final class GameViewModel: ObservableObject {
    enum Phase {
        case menu
        case playing
        case won
        case lost
    }

    @Published var phase: Phase = .menu
    @Published var ammoRemaining: Int = 0
    @Published var currentLevelIndex: Int = 0
    @Published var reloadTrigger: Int = 0
    @Published var resultObjectType: ObjectType?

    @Published var showTutorial = false
    @Published var tutorialStep = 0
    @Published var levelHintMessage: String?
    @Published var levelHintID = UUID()
    @Published var ammoWarningID = UUID()

    @AppStorage("highestUnlockedLevel") var highestUnlockedLevel: Int = 1

    let levels = LevelLibrary.allLevels

    @AppStorage("completedTutorialLevels") var completedTutorialLevels: Int = 0

    init(defaults: UserDefaults = .standard) {
        _highestUnlockedLevel = AppStorage(wrappedValue: 1, "highestUnlockedLevel", store: defaults)
        _completedTutorialLevels = AppStorage(wrappedValue: 0, "completedTutorialLevels", store: defaults)
    }

    private var tutorialMessages: [String] {
        switch levelNumber {
        case 1:
            return [
                "Your goal is to turn every object into rock. Rock turns scissors into rock when they touch.",
                "Tap a target to fire a rock toward it. To aim more carefully, touch and drag anywhere in the arena, then release to fire. Try hitting the scissors."
            ]
        case 2:
            return ["Now try two targets. Your rocks keep bouncing and can convert more scissors. You have plenty of shots, so take your time."]
        case 3:
            return ["These scissors move. Aim a little ahead of them, or let your rocks bounce until they meet. There is no time limit."]
        case 4:
            return [
                "Here comes paper. Paper turns rocks into paper, but scissors turn paper into scissors.",
                "Wait for the moving scissors to touch the paper. Once the paper is gone, fire rocks at the scissors to win."
            ]
        case 5:
            return ["Practice the whole chain: let scissors clear both pieces of paper first, then turn the scissors into rock. Firing too early can remove the scissors you need. Restart if you need another try."]
        default:
            return []
        }
    }

    var isLastTutorialStep: Bool {
        tutorialStep == tutorialMessages.count - 1
    }

    var currentLevel: LevelDefinition {
        levels[currentLevelIndex]
    }

    var levelNumber: Int {
        currentLevel.levelNumber
    }

    var hasNextLevel: Bool {
        currentLevelIndex < levels.count - 1
    }

    var continueLevelIndex: Int {
        min(max(highestUnlockedLevel - 1, 0), levels.count - 1)
    }

    var currentTutorialMessage: String? {
        guard showTutorial else { return nil }
        guard tutorialStep >= 0 && tutorialStep < tutorialMessages.count else { return nil }
        return tutorialMessages[tutorialStep]
    }

    var levelTitle: String {
        levelNumber <= 5 ? "Lesson \(levelNumber)" : "Level \(levelNumber)"
    }

    func startGame(at levelIndex: Int? = nil) {
        if let levelIndex = levelIndex {
            let clamped = max(0, min(levelIndex, levels.count - 1))
            let allowed = min(clamped, highestUnlockedLevel - 1)
            currentLevelIndex = allowed
        }

        ammoRemaining = currentLevel.startingAmmo
        resultObjectType = nil
        dismissLevelHint()
        phase = .playing
        showTutorial = false
        startTutorialIfNeeded()
        reloadTrigger += 1
    }

    func restartLevel() {
        ammoRemaining = currentLevel.startingAmmo
        resultObjectType = nil
        dismissLevelHint()
        phase = .playing
        showTutorial = false
        startTutorialIfNeeded()
        reloadTrigger += 1
    }

    func goToMenu() {
        dismissLevelHint()
        showTutorial = false
        phase = .menu
    }

    func useAmmo() {
        if ammoRemaining > 0 {
            ammoRemaining -= 1
        }
    }

    func completeLevel(finalObjectType: ObjectType) {
        resultObjectType = finalObjectType
        dismissLevelHint()
        showTutorial = false
        let newlyUnlocked = currentLevelIndex + 2
        if newlyUnlocked > highestUnlockedLevel {
            highestUnlockedLevel = min(newlyUnlocked, levels.count)
        }
        phase = .won
    }

    func failLevel(finalObjectType: ObjectType) {
        resultObjectType = finalObjectType
        dismissLevelHint()
        showTutorial = false
        phase = .lost
    }

    func goToNextLevel() {
        guard hasNextLevel else {
            goToMenu()
            return
        }

        currentLevelIndex += 1
        ammoRemaining = currentLevel.startingAmmo
        resultObjectType = nil
        dismissLevelHint()
        phase = .playing
        showTutorial = false
        startTutorialIfNeeded()
        reloadTrigger += 1
    }

    func selectLevel(_ index: Int) {
        guard index >= 0 else { return }
        guard index < levels.count else { return }
        guard index < highestUnlockedLevel else { return }

        currentLevelIndex = index
        startGame()
    }

    func resetProgress() {
        highestUnlockedLevel = 1
        completedTutorialLevels = 0
        currentLevelIndex = 0
        ammoRemaining = 0
        resultObjectType = nil
        dismissLevelHint()
        showTutorial = false
        phase = .menu
    }

    func startTutorialIfNeeded() {
        guard phase == .playing, !showTutorial else { return }
        // Existing progress also counts as completion for players upgrading the app.
        guard levelNumber <= 5, levelNumber >= highestUnlockedLevel,
              completedTutorialLevels & (1 << (levelNumber - 1)) == 0 else { return }
        tutorialStep = 0
        showTutorial = true
    }

    func advanceTutorial() {
        guard showTutorial else { return }
        if isLastTutorialStep {
            skipTutorial()
        } else {
            tutorialStep += 1
        }
    }

    func skipTutorial() {
        guard showTutorial else { return }
        completedTutorialLevels |= 1 << (levelNumber - 1)
        showTutorial = false
    }

    func showLevelHintIfNeeded() {
        guard phase == .playing else { return }
        guard levelNumber > 5 else { return }
        guard let message = currentLevel.introMessage else { return }

        levelHintMessage = message
        levelHintID = UUID()
    }

    func dismissLevelHint() {
        levelHintMessage = nil
    }

    func warnNoAmmoIfNeeded() {
        guard phase == .playing else { return }
        guard ammoRemaining == 0 else { return }
        ammoWarningID = UUID()
    }
}


