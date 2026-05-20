//
//  TutorialOverlay.swift
//  RockBreakerScissors
//
//  Created by Grant Hevia on 4/28/26.
//

import Foundation
import SwiftUI

struct TutorialOverlay: View {
    let message: String
    let onNext: () -> Void
    let onSkip: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            Text(message)
                .font(.headline)
                .multilineTextAlignment(.center)

            HStack {
                Button("Skip") {
                    onSkip()
                }

                Button("Next") {
                    onNext()
                }
            }
        }
        .padding()
        .background(Color.black.opacity(0.75))
        .foregroundColor(.white)
        .cornerRadius(16)
        .padding()
    }
}
