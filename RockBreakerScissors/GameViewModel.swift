import Foundation
import SwiftUI

final class GameViewModel: ObservableObject {
    enum Phase { case menu, playing, won, lost }

    @Published var phase: Phase = .menu
    @Published var ammoRemaining = 0
    @Published var currentLevelIndex = 0
    @Published var reloadTrigger = 0
    @Published var resultObjectType: ObjectType?
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
            return ["These scissors move. Aim a little ahead of them, or let your rocks bounce until they meet."]
        case 4:
            return ["Paper turns rocks into paper. Scissors turn paper into scissors. In this lesson, let scissors clear the paper before firing rocks."]
        case 5:
            return [
                "Your shots keep moving when they change type. A rock can become moving paper, then moving scissors.",
                "Use that chain to reach the paper in the lower lane, then finish with rocks."
            ]
        case 6:
            return [
                "From now on, all scissors counts as a loss—even before you fire. You cannot just wait for scissors to eat all the paper: that would be too easy! You may need to fire quickly.",
                "Keep a rock in play as the last paper disappears. Only lessons 1–5 let you wait safely before firing."
            ]
        case 7:
            return ["Try hitting the lower scissors first. That gives you a rock in play while the upper scissors clear the paper."]
        case 8:
            return ["If only rocks and paper remain, you are bound to lose. Keep the scissors population alive until all paper is gone!"]
        case 9:
            return ["For stationary targets, send a rock into paper so it carries paper to scissors. Fire another rock off to the side to finish after the paper is gone."]
        case 10:
            return ["Put it together: fire before all scissors takes over, protect scissors while paper remains, and turn everything into rock. Restart whenever you want another try."]
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
        return currentLevel.isTutorial ? "Lesson \(levelNumber)" : "Level \(levelNumber)"
    }

    func startGame(at levelIndex: Int? = nil, replayInstructions: Bool = false) {
        randomLevel = nil
        let requested = levelIndex ?? currentLevelIndex
        currentLevelIndex = min(max(0, requested), continueLevelIndex)
        let acknowledgedLesson = currentLevel.isTutorial && completedTutorialLevels & (1 << (levelNumber - 1)) != 0
        prepareRound(showInstructions: replayInstructions || !acknowledgedLesson)
    }

    private func prepareRound(showInstructions: Bool) {
        ammoRemaining = currentLevel.startingAmmo
        resultObjectType = nil
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
        if showTutorial && !isRandomMode && currentLevel.isTutorial {
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
        showTutorial = false
        if !isRandomMode {
            highestUnlockedLevel = min(levels.count, max(highestUnlockedLevel, currentLevelIndex + 2))
            if currentLevelIndex == levels.count - 1 { campaignCompleted = true }
        }
        phase = .won
    }

    func failLevel(finalObjectType: ObjectType) {
        guard phase == .playing else { return }
        resultObjectType = finalObjectType
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
        goToMenu()
    }

    func warnNoAmmoIfNeeded() {
        guard phase == .playing, ammoRemaining == 0 else { return }
        ammoWarningID = UUID()
    }
}
