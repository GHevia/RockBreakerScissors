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
    let onSkip: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Tutorial Level")
                .font(.caption.bold())
                .textCase(.uppercase)
                .foregroundColor(.white.opacity(0.72))

            Text(message)
                .font(.subheadline.bold())
                .fixedSize(horizontal: false, vertical: true)

            HStack {
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

struct LevelHintOverlay: View {
    let message: String

    var body: some View {
        Text(message)
            .font(.subheadline.bold())
            .multilineTextAlignment(.center)
            .fixedSize(horizontal: false, vertical: true)
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .frame(maxWidth: 320)
            .background(Color.black.opacity(0.78))
            .foregroundColor(.white)
            .cornerRadius(14)
            .padding(.horizontal, 16)
            .padding(.top, 16)
        }
}
