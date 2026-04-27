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

    @AppStorage("highestUnlockedLevel") var highestUnlockedLevel: Int = 1

    let levels: [LevelDefinition] = [
        LevelLibrary.level1,
        LevelLibrary.level2,
        LevelLibrary.level3,
        LevelLibrary.level4,
        LevelLibrary.level5
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

    func startGame(at levelIndex: Int? = nil) {
        if let levelIndex = levelIndex {
            let clamped = max(0, min(levelIndex, levels.count - 1))
            let allowed = min(clamped, highestUnlockedLevel - 1)
            currentLevelIndex = allowed
        }

        ammoRemaining = currentLevel.startingAmmo
        reloadTrigger += 1
        phase = .playing
    }

    func restartLevel() {
        ammoRemaining = currentLevel.startingAmmo
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

    func completeLevel() {
        let newlyUnlocked = currentLevelIndex + 2
        if newlyUnlocked > highestUnlockedLevel {
            highestUnlockedLevel = min(newlyUnlocked, levels.count)
        }
        phase = .won
    }

    func failLevel() {
        phase = .lost
    }

    func goToNextLevel() {
        guard hasNextLevel else {
            goToMenu()
            return
        }

        currentLevelIndex += 1
        ammoRemaining = currentLevel.startingAmmo
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
        phase = .menu
    }
}
