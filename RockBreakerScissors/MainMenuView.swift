import SwiftUI

struct MainMenuView: View {
    @EnvironmentObject var viewModel: GameViewModel
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

            Text("Turn everything into rock.")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.top, 24)
    }

    private var actionSection: some View {
        VStack(spacing: 14) {
            MenuButton(title: "Continue") {
                viewModel.startGame(at: viewModel.continueLevelIndex)
            }

            NavigationLink(destination: LevelSelectView()) {
                MenuButtonLabel(title: "Select Level")
            }
            .buttonStyle(PlainButtonStyle())

            MenuButton(title: "Start Over") {
                viewModel.startGame(at: 0)
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
                Text("Reset Progress")
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
                    Text("\(index + 1)")
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

