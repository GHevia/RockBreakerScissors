//
//  GameObject.swift
//  RockBreakerScissors
//
//  Created by Grant Hevia on 4/14/26.
//
import CoreGraphics
import Foundation
import SpriteKit

enum ObjectType: Hashable {
    case rock
    case paper
    case scissors

    var displayName: String {
        switch self {
        case .rock:
            return "rock"
        case .paper:
            return "paper"
        case .scissors:
            return "scissors"
        }
    }

    var assetName: String {
        displayName
    }
}

final class GameObject {
    let id = UUID()
    var type: ObjectType
    let node: SKSpriteNode
    let radius: CGFloat

    init(type: ObjectType, node: SKSpriteNode, radius: CGFloat) {
        self.type = type
        self.node = node
        self.radius = radius
    }
}
