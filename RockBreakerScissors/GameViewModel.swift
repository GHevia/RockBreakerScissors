import Foundation
import SwiftUI

final class GameViewModel: ObservableObject {
    enum Phase { case menu, playing, won, lost }

    @Published var phase: Phase = .menu
    @Published var ammoRemaining = 0
    @Published var currentLevelIndex = 0
    @Published var reloadTrigger = 0
    @Published var resultObjectType: ObjectType?
    @Published var resultMessage: String?
    @Published var showTutorial = false
    @Published var tutorialStep = 0
    @Published var ammoWarningID = UUID()
    @Published private(set) var randomLevel: LevelDefinition?
    @Published private(set) var randomRound = 0

    @AppStorage("highestUnlockedLevel") var highestUnlockedLevel = 1
    @AppStorage("campaignCompleted") var campaignCompleted = false
    @AppStorage("completedTutorialLevels") private var completedTutorialLevels = 0

    let levels = LevelLibrary.allLevels

    init(defaults: UserDefaults = .standard) {
        _highestUnlockedLevel = AppStorage(wrappedValue: 1, "highestUnlockedLevel", store: defaults)
        _campaignCompleted = AppStorage(wrappedValue: false, "campaignCompleted", store: defaults)
        _completedTutorialLevels = AppStorage(wrappedValue: 0, "completedTutorialLevels", store: defaults)
    }

    var tutorialMessages: [String] {
        guard !isRandomMode else { return [] }
        switch levelNumber {
        case 1:
            return [
                "Your goal is to turn every object into rock. Rock turns scissors into rock when they touch.",
                "Tap a target to fire toward it. To aim more carefully, touch and drag anywhere in the arena, then release. Try hitting the scissors."
            ]
        case 2:
            return ["Now try two targets. Your rocks keep bouncing and can turn more scissors into rock. Take your time: there is no time limit."]
        case 3:
            return [
                "These scissors move. Aim a little ahead of them, or use a bounce.",
                "Be careful! After your first shot, you lose if the objects become all paper or all scissors. Until you fire, a scissors-only setup is safe."
            ]
        case 4:
            return [
                "Paper turns rocks into paper. Scissors turn paper into scissors. Wait for the scissors to clear the paper, then fire rocks.",
                "If only rocks and paper remain, you are bound to lose. Keep the scissors population alive until all the paper is gone!"
            ]
        case 5:
            return [
                "Practice the chain: let scissors clear both pieces of paper, then turn the scissors into rock. Firing too early can remove the scissors you need.",
                "A rock that touches paper becomes moving paper. If it then touches scissors, it becomes moving scissors. You can use this chain to solve stationary puzzles later."
            ]
        default:
            return currentLevel.introMessage.map { [$0] } ?? []
        }
    }

    var isRandomMode: Bool { randomLevel != nil }
    var currentLevel: LevelDefinition { randomLevel ?? levels[currentLevelIndex] }
    var levelNumber: Int { currentLevel.levelNumber }
    var hasNextLevel: Bool { !isRandomMode && currentLevelIndex < levels.count - 1 }
    var isCampaignVictory: Bool { phase == .won && !isRandomMode && currentLevelIndex == levels.count - 1 }
    var continueLevelIndex: Int { min(max(highestUnlockedLevel - 1, 0), levels.count - 1) }
    var isLastTutorialStep: Bool { tutorialStep == tutorialMessages.count - 1 }
    var hasInstructions: Bool { !tutorialMessages.isEmpty }
    var currentTutorialMessage: String? {
        guard showTutorial, tutorialMessages.indices.contains(tutorialStep) else { return nil }
        return tutorialMessages[tutorialStep]
    }
    var levelTitle: String {
        if isRandomMode { return "Random \(randomRound)" }
        return levelNumber <= 5 ? "Lesson \(levelNumber)" : "Level \(levelNumber)"
    }

    func startGame(at levelIndex: Int? = nil, replayInstructions: Bool = false) {
        randomLevel = nil
        let requested = levelIndex ?? currentLevelIndex
        currentLevelIndex = min(max(0, requested), continueLevelIndex)
        let acknowledgedLesson = levelNumber <= 5 && completedTutorialLevels & (1 << (levelNumber - 1)) != 0
        prepareRound(showInstructions: replayInstructions || !acknowledgedLesson)
    }

    private func prepareRound(showInstructions: Bool) {
        ammoRemaining = currentLevel.startingAmmo
        resultObjectType = nil
        resultMessage = nil
        tutorialStep = 0
        showTutorial = showInstructions && hasInstructions
        phase = .playing
        reloadTrigger += 1
    }

    func restartLevel() {
        // Replays preserve the puzzle, including a generated random layout.
        prepareRound(showInstructions: false)
    }

    func showInstructions() {
        guard phase == .playing, hasInstructions else { return }
        tutorialStep = 0
        showTutorial = true
    }

    func advanceTutorial() {
        guard showTutorial else { return }
        if isLastTutorialStep { skipTutorial() } else { tutorialStep += 1 }
    }

    func skipTutorial() {
        if showTutorial && !isRandomMode && levelNumber <= 5 {
            completedTutorialLevels |= 1 << (levelNumber - 1)
        }
        showTutorial = false
    }

    func goToMenu() {
        showTutorial = false
        phase = .menu
        randomLevel = nil
    }

    func useAmmo() {
        if ammoRemaining > 0 { ammoRemaining -= 1 }
    }

    func completeLevel(finalObjectType: ObjectType) {
        guard phase == .playing else { return }
        resultObjectType = finalObjectType
        resultMessage = nil
        showTutorial = false
        if !isRandomMode {
            highestUnlockedLevel = min(levels.count, max(highestUnlockedLevel, currentLevelIndex + 2))
            if currentLevelIndex == levels.count - 1 { campaignCompleted = true }
        }
        phase = .won
    }

    func failLevel(finalObjectType: ObjectType, message: String? = nil) {
        guard phase == .playing else { return }
        resultObjectType = finalObjectType
        resultMessage = message
        showTutorial = false
        phase = .lost
    }

    func goToNextLevel() {
        if isRandomMode { skipRandomLevel(); return }
        guard hasNextLevel else { goToMenu(); return }
        currentLevelIndex += 1
        prepareRound(showInstructions: true)
    }

    func selectLevel(_ index: Int) {
        guard levels.indices.contains(index), index < highestUnlockedLevel else { return }
        startGame(at: index, replayInstructions: true)
    }

    func startRandomGame() {
        randomRound = 0
        skipRandomLevel()
    }

    func skipRandomLevel() {
        var generator = SystemRandomNumberGenerator()
        randomLevel = LevelLibrary.randomLevel(using: &generator)
        randomRound += 1
        prepareRound(showInstructions: false)
    }

    func resetProgress() {
        highestUnlockedLevel = 1
        campaignCompleted = false
        completedTutorialLevels = 0
        currentLevelIndex = 0
        ammoRemaining = 0
        resultObjectType = nil
        resultMessage = nil
        goToMenu()
    }

    func warnNoAmmoIfNeeded() {
        guard phase == .playing, ammoRemaining == 0 else { return }
        ammoWarningID = UUID()
    }
}
