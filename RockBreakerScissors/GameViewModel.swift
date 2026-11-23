import Foundation
import SwiftUI

enum GameMode { case rock, balance, bet }

final class GameViewModel: ObservableObject {
    enum Phase { case menu, betting, countdown, playing, won, lost }

    @Published private(set) var mode: GameMode = .rock
    @Published private(set) var balanceMissingTypes: [ObjectType] = []
    @Published var balanceTime: TimeInterval = 0
    @Published private(set) var betChoice: ObjectType?
    @Published private(set) var countdown = 3
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

    @AppStorage("balanceBestTime") var balanceBestTime: Double = 0

    @AppStorage("betWins") private(set) var betWins = 0
    @AppStorage("betRounds") private(set) var betRounds = 0

    let levels = LevelLibrary.allLevels

    init(defaults: UserDefaults = .standard) {
        _betWins = AppStorage(wrappedValue: 0, "betWins", store: defaults)
        _betRounds = AppStorage(wrappedValue: 0, "betRounds", store: defaults)
        _balanceBestTime = AppStorage(wrappedValue: 0, "balanceBestTime", store: defaults)
        _highestUnlockedLevel = AppStorage(wrappedValue: 1, "highestUnlockedLevel", store: defaults)
        _campaignCompleted = AppStorage(wrappedValue: false, "campaignCompleted", store: defaults)
        _completedTutorialLevels = AppStorage(wrappedValue: 0, "completedTutorialLevels", store: defaults)
    }

    var tutorialMessages: [String] {
        if mode == .balance {
            return ["Keep at least one paper and one scissors alive for as long as possible. Fire unlimited rocks to control the population. The timer starts when you press Play; losing either paper or scissors ends the round."]
        }
        guard mode == .rock, !isRandomMode else { return [] }
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

    var isRandomMode: Bool { mode == .rock && randomLevel != nil }
    var currentLevel: LevelDefinition { randomLevel ?? levels[currentLevelIndex] }
    var levelNumber: Int { currentLevel.levelNumber }
    var hasNextLevel: Bool { mode == .rock && !isRandomMode && currentLevelIndex < levels.count - 1 }
    var isCampaignVictory: Bool { phase == .won && mode == .rock && !isRandomMode && currentLevelIndex == levels.count - 1 }
    var continueLevelIndex: Int { min(max(highestUnlockedLevel - 1, 0), levels.count - 1) }
    var isLastTutorialStep: Bool { tutorialStep == tutorialMessages.count - 1 }
    var hasInstructions: Bool { !tutorialMessages.isEmpty }
    var currentTutorialMessage: String? {
        guard showTutorial, tutorialMessages.indices.contains(tutorialStep) else { return nil }
        return tutorialMessages[tutorialStep]
    }
    var levelTitle: String {
        if mode == .balance { return "Balance" }
        if mode == .bet { return "Bet" }
        if isRandomMode { return "Random \(randomRound)" }
        return currentLevel.isTutorial ? "Lesson \(levelNumber)" : "Level \(levelNumber)"
    }

    func startGame(at levelIndex: Int? = nil, replayInstructions: Bool = false) {
        mode = .rock
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
        if mode == .balance { startBalanceGame(showInstructions: false); return }
        if mode == .bet { startBetGame(); return }
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
        if mode == .rock && ammoRemaining > 0 { ammoRemaining -= 1 }
    }

    func completeLevel(finalObjectType: ObjectType) {
        guard mode == .rock, phase == .playing else { return }
        resultObjectType = finalObjectType
        showTutorial = false
        if mode == .rock && !isRandomMode {
            highestUnlockedLevel = min(levels.count, max(highestUnlockedLevel, currentLevelIndex + 2))
            if currentLevelIndex == levels.count - 1 { campaignCompleted = true }
        }
        phase = .won
    }

    func failLevel(finalObjectType: ObjectType) {
        guard mode == .rock, phase == .playing else { return }
        resultObjectType = finalObjectType
        showTutorial = false
        phase = .lost
    }

    func goToNextLevel() {
        guard mode == .rock else { restartLevel(); return }
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
        mode = .rock
        var generator = SystemRandomNumberGenerator()
        randomLevel = LevelLibrary.randomLevel(using: &generator)
        randomRound += 1
        prepareRound(showInstructions: false)
    }

    var canFire: Bool {
        phase == .playing && !showTutorial && (mode == .balance || (mode == .rock && ammoRemaining > 0))
    }

    static func timeLabel(_ time: TimeInterval) -> String {
        String(format: "%.1f s", time)
    }

    func startBalanceGame(showInstructions: Bool = true) {
        mode = .balance
        balanceTime = 0
        balanceMissingTypes = []
        betChoice = nil
        var generator = SystemRandomNumberGenerator()
        randomLevel = LevelLibrary.modeLevel(for: .balance, using: &generator)
        prepareRound(showInstructions: showInstructions)
    }

    func finishBalance(at time: TimeInterval, missing: [ObjectType]) {
        guard mode == .balance, phase == .playing, !showTutorial else { return }
        balanceTime = time
        balanceMissingTypes = missing
        balanceBestTime = max(balanceBestTime, time)
        phase = .lost
    }

    var balanceLossMessage: String {
        if balanceMissingTypes.contains(.paper) && balanceMissingTypes.contains(.scissors) {
            return "Paper and scissors ran out."
        }
        if balanceMissingTypes.contains(.paper) { return "Paper ran out." }
        return "Scissors ran out."
    }

    var betRecordLabel: String {
        let percentage = betRounds == 0 ? 0 : Int((Double(betWins) / Double(betRounds) * 100).rounded())
        return "\(betWins)/\(betRounds) · \(percentage)%"
    }

    func resetBettingRecord() {
        betWins = 0
        betRounds = 0
    }

    func startBetGame() {
        mode = .bet
        betChoice = nil
        countdown = 3
        var generator = SystemRandomNumberGenerator()
        randomLevel = LevelLibrary.modeLevel(for: .bet, using: &generator)
        prepareRound(showInstructions: false)
        phase = .betting
    }

    func chooseBet(_ choice: ObjectType) {
        guard mode == .bet, phase == .betting else { return }
        betChoice = choice
        countdown = 3
        phase = .countdown
    }

    func advanceCountdown() {
        guard mode == .bet, phase == .countdown else { return }
        if countdown > 1 { countdown -= 1 } else { phase = .playing }
    }

    func resolveBet(winner: ObjectType) {
        guard mode == .bet, phase == .playing else { return }
        resultObjectType = winner
        betRounds += 1
        if winner == betChoice { betWins += 1 }
        phase = winner == betChoice ? .won : .lost
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
