//
//  ContentView.swift
//  RockBreakerScissors
//
//  Created by Grant Hevia on 4/14/26.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: GameViewModel

    var body: some View {
        Group {
            switch viewModel.phase {
            case .menu:
                MainMenuView()

            case .betting, .countdown, .playing, .won, .lost:
                GameView()
            }
        }
    }
}
