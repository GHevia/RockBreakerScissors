import Foundation
import SwiftUI

final class GameViewModel: ObservableObject {
    enum TutorialEvent {
        case aimStarted
        case rockLaunched
        case objectConverted
    }

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

    @AppStorage("highestUnlockedLevel") var highestUnlockedLevel: Int = 1

    let levels = LevelLibrary.allLevels

    private let tutorialMessages: [String] = [
        "Drag from the launcher to aim.",
        "Release to fire a rock.",
        "Collisions change object types: rock beats scissors, scissors beats paper, paper beats rock.",
        "Turn everything into rock to win."
    ]

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

    var resultTitle: String {
        guard let resultObjectType else {
            return phase == .won ? "You won!" : "You lost!"
        }

        let objectName = resultObjectType.displayName
        switch phase {
        case .won:
            return "All objects are \(objectName) - You won!"
        case .lost:
            return "All objects are \(objectName) - You lost!"
        case .menu, .playing:
            return ""
        }
    }

    var currentTutorialMessage: String? {
        guard showTutorial else { return nil }
        guard tutorialStep >= 0 && tutorialStep < tutorialMessages.count else { return nil }
        return tutorialMessages[tutorialStep]
    }

    var levelTitle: String {
        levelNumber == 1 ? "Tutorial Level" : "Level \(levelNumber)"
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
        reloadTrigger += 1
        phase = .playing
    }

    func restartLevel() {
        ammoRemaining = currentLevel.startingAmmo
        resultObjectType = nil
        dismissLevelHint()
        reloadTrigger += 1
        phase = .playing
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
        reloadTrigger += 1
        phase = .playing
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
        currentLevelIndex = 0
        ammoRemaining = 0
        resultObjectType = nil
        dismissLevelHint()
        showTutorial = false
        phase = .menu
    }

    func startTutorialIfNeeded() {
        guard phase == .playing else { return }

        if levelNumber == 1 {
            if showTutorial == false {
                tutorialStep = 0
                showTutorial = true
            }
        } else {
            showTutorial = false
        }
    }

    func handleTutorialEvent(_ event: TutorialEvent) {
        guard showTutorial else { return }

        switch (tutorialStep, event) {
        case (0, .aimStarted),
             (1, .rockLaunched),
             (2, .objectConverted):
            tutorialStep += 1

        default:
            break
        }

        if tutorialStep >= tutorialMessages.count {
            showTutorial = false
        }
    }

    func skipTutorial() {
        showTutorial = false
    }

    func showLevelHintIfNeeded() {
        guard phase == .playing else { return }
        guard levelNumber != 1 else { return }
        guard let message = currentLevel.introMessage else { return }

        levelHintMessage = message
        levelHintID = UUID()
    }

    func dismissLevelHint() {
        levelHintMessage = nil
    }
}


