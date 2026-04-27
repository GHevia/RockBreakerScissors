import CoreGraphics
import Foundation

struct InitialObjectDefinition {
    let type: ObjectType
    let position: CGPoint
    let velocity: CGVector
    let radius: CGFloat

    init(
        type: ObjectType,
        x: CGFloat,
        y: CGFloat,
        directionDX: CGFloat,
        directionDY: CGFloat,
        speed: CGFloat,
        radius: CGFloat
    ) {
        self.type = type
        self.position = CGPoint(x: x, y: y)
        self.velocity = .direction(dx: directionDX, dy: directionDY, speed: speed)
        self.radius = radius
    }

    init(
        type: ObjectType,
        x: CGFloat,
        y: CGFloat,
        angleDegrees: CGFloat,
        speed: CGFloat,
        radius: CGFloat
    ) {
        self.type = type
        self.position = CGPoint(x: x, y: y)
        self.velocity = .fromDegrees(angleDegrees, speed: speed)
        self.radius = radius
    }
}

struct LevelDefinition {
    let levelNumber: Int
    let startingAmmo: Int
    let launchSpeed: CGFloat
    let initialObjects: [InitialObjectDefinition]
}

extension CGVector {
    var length: CGFloat {
        sqrt(dx * dx + dy * dy)
    }

    var normalized: CGVector {
        let len = length
        guard len > 0 else { return .zero }
        return CGVector(dx: dx / len, dy: dy / len)
    }

    func scaled(by scalar: CGFloat) -> CGVector {
        CGVector(dx: dx * scalar, dy: dy * scalar)
    }

    static func direction(dx: CGFloat, dy: CGFloat, speed: CGFloat) -> CGVector {
        CGVector(dx: dx, dy: dy).normalized.scaled(by: speed)
    }

    static func fromAngle(_ radians: CGFloat, speed: CGFloat) -> CGVector {
        CGVector(dx: cos(radians) * speed, dy: sin(radians) * speed)
    }

    static func fromDegrees(_ degrees: CGFloat, speed: CGFloat) -> CGVector {
        let radians = degrees * .pi / 180.0
        return .fromAngle(radians, speed: speed)
    }
}

enum LevelLibrary {
    static let level1 = LevelDefinition(
        levelNumber: 1,
        startingAmmo: 8,
        launchSpeed: 200,
        initialObjects: [
            InitialObjectDefinition(
                type: .paper,
                x: 90,
                y: 500,
                directionDX: 3,
                directionDY: -2,
                speed: 200,
                radius: 20
            ),
            InitialObjectDefinition(
                type: .scissors,
                x: 300,
                y: 250,
                directionDX: -2,
                directionDY: 2,
                speed: 200,
                radius: 20
            )
        ]
    )

    static let level2 = LevelDefinition(
        levelNumber: 2,
        startingAmmo: 7,
        launchSpeed: 200,
        initialObjects: [
            InitialObjectDefinition(
                type: .paper,
                x: 90,
                y: 520,
                angleDegrees: -25,
                speed: 200,
                radius: 20
            ),
            InitialObjectDefinition(
                type: .paper,
                x: 260,
                y: 420,
                angleDegrees: 160,
                speed: 200,
                radius: 20
            ),
            InitialObjectDefinition(
                type: .scissors,
                x: 300,
                y: 220,
                angleDegrees: 120,
                speed: 200,
                radius: 20
            )
        ]
    )

    static let level3 = LevelDefinition(
        levelNumber: 3,
        startingAmmo: 6,
        launchSpeed: 200,
        initialObjects: [
            InitialObjectDefinition(
                type: .paper,
                x: 80,
                y: 520,
                angleDegrees: 30,
                speed: 200,
                radius: 20
            ),
            InitialObjectDefinition(
                type: .paper,
                x: 300,
                y: 520,
                angleDegrees: 210,
                speed: 200,
                radius: 20
            ),
            InitialObjectDefinition(
                type: .scissors,
                x: 120,
                y: 260,
                angleDegrees: 40,
                speed: 200,
                radius: 20
            ),
            InitialObjectDefinition(
                type: .scissors,
                x: 280,
                y: 240,
                angleDegrees: 200,
                speed: 200,
                radius: 20
            )
        ]
    )
    
    static let level4 = LevelDefinition(
        levelNumber: 4,
        startingAmmo: 6,
        launchSpeed: 200,
        initialObjects: [
            InitialObjectDefinition(
                type: .scissors,
                x: 300,
                y: 50,
                directionDX: 0,
                directionDY: 1,
                speed: 200,
                radius: 20
            ),
            InitialObjectDefinition(
                type: .scissors,
                x: 350,
                y: 520,
                directionDX: 0,
                directionDY: -1,
                speed: 200,
                radius: 20
            ),
            InitialObjectDefinition(
                type: .paper,
                x: 50,
                y: 50,
                directionDX: 0,
                directionDY: 1,
                speed: 200,
                radius: 20
            ),
            InitialObjectDefinition(
                type: .paper,
                x: 100,
                y: 520,
                directionDX: 0,
                directionDY: -1,
                speed: 200,
                radius: 20
            ),
        ]
    )
    
    static let level5 = LevelDefinition(
        levelNumber: 5,
        startingAmmo: 4,
        launchSpeed: 200,
        initialObjects: [
            InitialObjectDefinition(
                type: .scissors,
                x: 50,
                y: 50,
                directionDX: 1,
                directionDY: 0,
                speed: 200,
                radius: 20
            ),
            InitialObjectDefinition(
                type: .scissors,
                x: 100,
                y: 100,
                directionDX: 1,
                directionDY: 0,
                speed: 200,
                radius: 20
            ),
            InitialObjectDefinition(
                type: .scissors,
                x: 150,
                y: 150,
                directionDX: 1,
                directionDY: 0,
                speed: 200,
                radius: 20
            ),
            InitialObjectDefinition(
                type: .paper,
                x: 500,
                y: 500,
                directionDX: -1,
                directionDY: 0,
                speed: 200,
                radius: 20
            ),
            InitialObjectDefinition(
                type: .paper,
                x: 450,
                y: 450,
                directionDX: -1,
                directionDY: 0,
                speed: 200,
                radius: 20
            ),
            InitialObjectDefinition(
                type: .paper,
                x: 400,
                y: 400,
                directionDX: -1,
                directionDY: 0,
                speed: 200,
                radius: 20
            ),
        ]
    )
}
