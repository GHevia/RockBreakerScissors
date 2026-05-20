import SwiftUI

struct MainMenuView: View {
    @EnvironmentObject var viewModel: GameViewModel
    @State private var showSettings = false
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
                        levelSection
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

            Text("RockBreakerScissors")
                .font(.system(size: 34, weight: .bold, design: .rounded))
                .multilineTextAlignment(.center)

            Text("Turn everything into rock.")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.top, 24)
    }

    private var actionSection: some View {
        VStack(spacing: 14) {
            MenuButton(title: "Play") {
                viewModel.startGame(at: 0)
            }

            MenuButton(title: "Continue") {
                let index = min(viewModel.highestUnlockedLevel - 1,
                                viewModel.levels.count - 1)
                viewModel.startGame(at: index)
            }
        }
    }

    private var levelSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Levels")
                .font(.headline)

            LazyVGrid(
                columns: [GridItem(.adaptive(minimum: 68), spacing: 12)],
                spacing: 12
            ) {
                ForEach(Array(viewModel.levels.indices), id: \.self) { index in
                    let unlocked = index < viewModel.highestUnlockedLevel

                    Button(action: {
                        if unlocked {
                            viewModel.selectLevel(index)
                        }
                    }) {
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
        }
        .padding(18)
        .background(.thinMaterial)
        .cornerRadius(22)
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
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(
                    RoundedRectangle(cornerRadius: 18)
                        .fill(Color.accentColor.opacity(0.22))
                )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

