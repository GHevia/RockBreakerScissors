//
//  RockBreakerScissorsApp.swift
//  RockBreakerScissors
//
//  Created by Grant Hevia on 4/14/26.
//

import SwiftUI

@main
struct RockBreakerScissorsApp: App {
    @StateObject private var viewModel = GameViewModel()
    @AppStorage("useDarkMode") private var useDarkMode: Bool = true

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
                .preferredColorScheme(useDarkMode ? .dark : .light)
        }
    }
}
