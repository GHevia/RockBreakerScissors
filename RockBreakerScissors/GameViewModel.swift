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

    @AppStorage("highestUnlockedLevel") var highestUnlockedLevel: Int = 1

    let levels = LevelLibrary.allLevels

    let tutorialMessages: [String] = [
        "Drag from the launcher to aim.",
        "Release to fire a rock.",
        "Rock beats scissors.",
        "Scissors beats paper. Paper beats rock.",
        "Turn everything into rock to win!"
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

    func startGame(at levelIndex: Int? = nil) {
        if let levelIndex = levelIndex {
            let clamped = max(0, min(levelIndex, levels.count - 1))
            let allowed = min(clamped, highestUnlockedLevel - 1)
            currentLevelIndex = allowed
        }

        ammoRemaining = currentLevel.startingAmmo
        resultObjectType = nil
        reloadTrigger += 1
        phase = .playing
    }

    func restartLevel() {
        ammoRemaining = currentLevel.startingAmmo
        resultObjectType = nil
        reloadTrigger += 1
        phase = .playing
    }

    func goToMenu() {
        phase = .menu
    }

    func useAmmo() {
        if ammoRemaining > 0 {
            ammoRemaining -= 1
        }
    }

    func completeLevel(finalObjectType: ObjectType) {
        resultObjectType = finalObjectType
        let newlyUnlocked = currentLevelIndex + 2
        if newlyUnlocked > highestUnlockedLevel {
            highestUnlockedLevel = min(newlyUnlocked, levels.count)
        }
        phase = .won
    }

    func failLevel(finalObjectType: ObjectType) {
        resultObjectType = finalObjectType
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
        phase = .menu
    }

    func startTutorialIfNeeded() {
        if levelNumber == 1 {
            showTutorial = true
            tutorialStep = 0
        }
    }

    func nextTutorialStep() {
        if tutorialStep < tutorialMessages.count - 1 {
            tutorialStep += 1
        } else {
            showTutorial = false
        }
    }

    func skipTutorial() {
        showTutorial = false
    }
}


