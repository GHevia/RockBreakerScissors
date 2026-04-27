//
//  GameObject.swift
//  RockBreakerScissors
//
//  Created by Grant Hevia on 4/14/26.
//
import CoreGraphics
import Foundation
import SpriteKit

enum ObjectType {
    case rock
    case paper
    case scissors
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
