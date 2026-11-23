import SwiftUI

struct MainMenuView: View {
    @EnvironmentObject var viewModel: GameViewModel
    @State private var showingRockOptions = false
    @AppStorage("useDarkMode") private var useDarkMode: Bool = true

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.accentColor.opacity(0.18),
                        Color.clear
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 24) {
                        headerSection
                        actionSection
                        settingsSection
                    }
                    .padding(20)
                }
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    private var headerSection: some View {
        VStack(spacing: 10) {
            Image("rock")
                .resizable()
                .scaledToFit()
                .frame(width: 84, height: 84)

            Text("Rock Breaker Scissors")
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .multilineTextAlignment(.center)

            Text(showingRockOptions ? "Turn everything into rock." : "Choose how to play.")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .overlay(alignment: .topTrailing) { Text("1.1").font(.caption).foregroundColor(.secondary) }
        .padding(.top, 24)
    }

    private var actionSection: some View {
        VStack(spacing: 14) {
            if showingRockOptions {
                Button("All Modes") { showingRockOptions = false }
                Text("Rock Mode").font(.title2.bold())
                rockActions
            } else {
                modeButton("Rock Mode", detail: "Campaign, level select, and random challenges") { showingRockOptions = true }
                modeButton("Balance", detail: "Keep paper and scissors alive · Best: \(GameViewModel.timeLabel(viewModel.balanceBestTime))") {
                    viewModel.startBalanceGame()
                }
                modeButton("Bet", detail: "Read the board. Pick the last type standing.") { viewModel.startBetGame() }
            }
        }
    }

    private func modeButton(_ title: String, detail: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            VStack(spacing: 6) {
                Text(title).font(.title2.bold())
                Text(detail).font(.subheadline).foregroundColor(.secondary).multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity)
            .padding(18)
            .background(Color.accentColor.opacity(0.16))
            .cornerRadius(18)
        }
        .buttonStyle(PlainButtonStyle())
        .accessibilityLabel(title)
    }

    private var rockActions: some View {
        VStack(spacing: 14) {
            MenuButton(title: "Continue") {
                viewModel.startGame(at: viewModel.continueLevelIndex)
            }

            NavigationLink(destination: LevelSelectView()) {
                MenuButtonLabel(title: "Select Level")
            }
            .buttonStyle(PlainButtonStyle())

            MenuButton(title: "Random Levels") {
                viewModel.startRandomGame()
            }

            if viewModel.campaignCompleted {
                Text("Campaign complete! Try a new random challenge.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            MenuButton(title: "Start Over") {
                viewModel.startGame(at: 0, replayInstructions: true)
            }
        }
    }

    private var settingsSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Settings")
                .font(.headline)

            Toggle("Dark Mode", isOn: $useDarkMode)

            Button(role: .destructive) {
                viewModel.resetProgress()
            } label: {
                Text("Reset Rock Progress")
                    .frame(maxWidth: .infinity)
            }
            .padding(.top, 4)
        }
        .padding(18)
        .background(.thinMaterial)
        .cornerRadius(22)
    }
}

struct MenuButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            MenuButtonLabel(title: title)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct MenuButtonLabel: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.headline)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color.accentColor.opacity(0.22))
            )
    }
}

struct LevelSelectView: View {
    @EnvironmentObject var viewModel: GameViewModel

    private let columns = [GridItem(.adaptive(minimum: 68), spacing: 12)]

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.accentColor.opacity(0.18),
                    Color.clear
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            ScrollView {
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(Array(viewModel.levels.indices), id: \.self) { index in
                        levelButton(for: index)
                    }
                }
                .padding(20)
            }
        }
        .navigationTitle("Select Level")
    }

    private func levelButton(for index: Int) -> some View {
        let unlocked = index < viewModel.highestUnlockedLevel

        return Button {
            if unlocked {
                viewModel.selectLevel(index)
            }
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(unlocked ? Color.accentColor.opacity(0.20) : Color.gray.opacity(0.16))
                    .frame(height: 62)

                if unlocked {
                    Text(index < 10 ? "Lesson \(index + 1)" : "\(index + 1)")
                        .minimumScaleFactor(0.7)
                        .font(.headline)
                } else {
                    Image(systemName: "lock.fill")
                        .foregroundColor(.secondary)
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
        .disabled(!unlocked)
    }
}

