//
//  TutorialOverlay.swift
//  RockBreakerScissors
//
//  Created by Grant Hevia on 4/28/26.
//

import Foundation
import SwiftUI

struct TutorialOverlay: View {
    let title: String
    let message: String
    let isLastStep: Bool
    let onNext: () -> Void
    let onSkip: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.caption.bold())
                .textCase(.uppercase)
                .foregroundColor(.white.opacity(0.72))

            Text(message)
                .font(.subheadline.bold())
                .fixedSize(horizontal: false, vertical: true)

            HStack {
                Button(isLastStep ? "Play" : "Next", action: onNext)
                    .font(.headline.bold())
                    .padding(.vertical, 8)

                Spacer()

                Button("Skip") {
                    onSkip()
                }
                .font(.caption.bold())
            }
        }
        .padding(14)
        .frame(maxWidth: 320, alignment: .leading)
        .background(Color.black.opacity(0.78))
        .foregroundColor(.white)
        .cornerRadius(14)
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
    }
}
