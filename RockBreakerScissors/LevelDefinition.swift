import CoreGraphics
import Foundation

struct InitialObjectDefinition {
    let type: ObjectType
    let xPercent: CGFloat
    let yPercent: CGFloat
    let velocity: CGVector
    let radius: CGFloat

    init(
        type: ObjectType,
        xPercent: CGFloat,
        yPercent: CGFloat,
        directionDX: CGFloat,
        directionDY: CGFloat,
        speed: CGFloat,
        radius: CGFloat
    ) {
        self.type = type
        self.xPercent = xPercent
        self.yPercent = yPercent
        self.velocity = .direction(dx: directionDX, dy: directionDY, speed: speed)
        self.radius = radius
    }

    init(
        type: ObjectType,
        xPercent: CGFloat,
        yPercent: CGFloat,
        angleDegrees: CGFloat,
        speed: CGFloat,
        radius: CGFloat
    ) {
        self.type = type
        self.xPercent = xPercent
        self.yPercent = yPercent
        self.velocity = .fromDegrees(angleDegrees, speed: speed)
        self.radius = radius
    }
}

struct LevelDefinition {
    let levelNumber: Int
    let startingAmmo: Int
    let launchSpeed: CGFloat
    let launchedRockRadius: CGFloat
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
    static let allLevels: [LevelDefinition] = [
        level1,
        level2,
        level3,
        level4,
        level5,
        level6,
        level7,
        level8,
        level9,
        level10,
        level11,
        level12,
        level13,
        level14,
        level15,
        level16,
        level17,
        level18,
        level19,
        level20
    ]

    static let level1 = LevelDefinition(
        levelNumber: 1,
        startingAmmo: 8,
        launchSpeed: 200,
        launchedRockRadius: 20,
        initialObjects: [
            InitialObjectDefinition(
                type: .paper,
                xPercent: 0.20,
                yPercent: 0.78,
                directionDX: 3,
                directionDY: -2,
                speed: 200,
                radius: 20
            ),
            InitialObjectDefinition(
                type: .scissors,
                xPercent: 0.78,
                yPercent: 0.35,
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
        launchedRockRadius: 20,
        initialObjects: [
            InitialObjectDefinition(
                type: .paper,
                xPercent: 0.20,
                yPercent: 0.78,
                angleDegrees: -25,
                speed: 200,
                radius: 20
            ),
            InitialObjectDefinition(
                type: .paper,
                xPercent: 0.65,
                yPercent: 0.62,
                angleDegrees: 160,
                speed: 200,
                radius: 20
            ),
            InitialObjectDefinition(
                type: .scissors,
                xPercent: 0.78,
                yPercent: 0.30,
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
        launchedRockRadius: 20,
        initialObjects: [
            InitialObjectDefinition(
                type: .paper,
                xPercent: 0.18,
                yPercent: 0.78,
                angleDegrees: 30,
                speed: 200,
                radius: 20
            ),
            InitialObjectDefinition(
                type: .paper,
                xPercent: 0.78,
                yPercent: 0.78,
                angleDegrees: 210,
                speed: 200,
                radius: 20
            ),
            InitialObjectDefinition(
                type: .scissors,
                xPercent: 0.30,
                yPercent: 0.35,
                angleDegrees: 40,
                speed: 200,
                radius: 20
            ),
            InitialObjectDefinition(
                type: .scissors,
                xPercent: 0.72,
                yPercent: 0.32,
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
        launchedRockRadius: 20,
        initialObjects: [
            InitialObjectDefinition(
                type: .scissors,
                xPercent: 0.2,
                yPercent: 0.2,
                directionDX: 0,
                directionDY: 1,
                speed: 200,
                radius: 20
            ),
            InitialObjectDefinition(
                type: .scissors,
                xPercent: 0.4,
                yPercent: 0.8,
                directionDX: 0,
                directionDY: -1,
                speed: 200,
                radius: 20
            ),
            InitialObjectDefinition(
                type: .paper,
                xPercent: 0.6,
                yPercent: 0.2,
                directionDX: 0,
                directionDY: 1,
                speed: 200,
                radius: 20
            ),
            InitialObjectDefinition(
                type: .paper,
                xPercent: 0.8,
                yPercent: 0.8,
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
        launchedRockRadius: 20,
        initialObjects: [
            InitialObjectDefinition(
                type: .scissors,
                xPercent: 0.2,
                yPercent: 0.2,
                directionDX: 1,
                directionDY: 0,
                speed: 200,
                radius: 20
            ),
            InitialObjectDefinition(
                type: .scissors,
                xPercent: 0.3,
                yPercent: 0.3,
                directionDX: 1,
                directionDY: 0,
                speed: 200,
                radius: 20
            ),
            InitialObjectDefinition(
                type: .scissors,
                xPercent: 0.4,
                yPercent: 0.4,
                directionDX: 1,
                directionDY: 0,
                speed: 200,
                radius: 20
            ),
            InitialObjectDefinition(
                type: .paper,
                xPercent: 0.7,
                yPercent: 0.7,
                directionDX: -1,
                directionDY: 0,
                speed: 200,
                radius: 20
            ),
            InitialObjectDefinition(
                type: .paper,
                xPercent: 0.8,
                yPercent: 0.8,
                directionDX: -1,
                directionDY: 0,
                speed: 200,
                radius: 20
            ),
            InitialObjectDefinition(
                type: .paper,
                xPercent: 0.9,
                yPercent: 0.9,
                directionDX: -1,
                directionDY: 0,
                speed: 200,
                radius: 20
            ),
        ]
    )
    static let level6 = LevelDefinition(
        levelNumber: 6,
        startingAmmo: 5,
        launchSpeed: 210,
        launchedRockRadius: 20,
        initialObjects: [
            // Theme: vertical lanes, staggered so they do not meet immediately
            InitialObjectDefinition(type: .paper, xPercent: 0.18, yPercent: 0.22, directionDX: 0, directionDY: 1, speed: 210, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.38, yPercent: 0.72, directionDX: 0, directionDY: -1, speed: 210, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.62, yPercent: 0.30, directionDX: 0, directionDY: 1, speed: 210, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.82, yPercent: 0.78, directionDX: 0, directionDY: -1, speed: 210, radius: 20)
        ]
    )

    static let level7 = LevelDefinition(
        levelNumber: 7,
        startingAmmo: 5,
        launchSpeed: 210,
        launchedRockRadius: 20,
        initialObjects: [
            // Theme: horizontal lanes, separated vertically
            InitialObjectDefinition(type: .paper, xPercent: 0.18, yPercent: 0.22, directionDX: 1, directionDY: 0, speed: 210, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.82, yPercent: 0.38, directionDX: -1, directionDY: 0, speed: 210, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.24, yPercent: 0.58, directionDX: 1, directionDY: 0, speed: 210, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.76, yPercent: 0.78, directionDX: -1, directionDY: 0, speed: 210, radius: 20)
        ]
    )

    static let level8 = LevelDefinition(
        levelNumber: 8,
        startingAmmo: 5,
        launchSpeed: 215,
        launchedRockRadius: 20,
        initialObjects: [
            InitialObjectDefinition(type: .paper, xPercent: 0.18, yPercent: 0.24, angleDegrees: 22, speed: 205, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.80, yPercent: 0.30, angleDegrees: 146, speed: 205, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.28, yPercent: 0.70, angleDegrees: 320, speed: 205, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.78, yPercent: 0.78, angleDegrees: 212, speed: 205, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.52, yPercent: 0.50, angleDegrees: 88, speed: 190, radius: 20)
        ]
    )

    static let level9 = LevelDefinition(
        levelNumber: 9,
        startingAmmo: 4,
        launchSpeed: 220,
        launchedRockRadius: 20,
        initialObjects: [
            // Theme: offset horizontal groups, not same-lane head-on
            InitialObjectDefinition(type: .scissors, xPercent: 0.18, yPercent: 0.24, directionDX: 1, directionDY: 0, speed: 220, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.24, yPercent: 0.44, directionDX: 1, directionDY: 0, speed: 220, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.18, yPercent: 0.68, directionDX: 1, directionDY: 0, speed: 220, radius: 20),

            InitialObjectDefinition(type: .paper, xPercent: 0.82, yPercent: 0.34, directionDX: -1, directionDY: 0, speed: 220, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.76, yPercent: 0.56, directionDX: -1, directionDY: 0, speed: 220, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.82, yPercent: 0.80, directionDX: -1, directionDY: 0, speed: 220, radius: 20)
        ]
    )

    static let level10 = LevelDefinition(
        levelNumber: 10,
        startingAmmo: 4,
        launchSpeed: 220,
        launchedRockRadius: 20,
        initialObjects: [
            // Theme: center traffic, with separated lanes to prevent instant collapse
            InitialObjectDefinition(type: .paper, xPercent: 0.18, yPercent: 0.36, angleDegrees: 6, speed: 210, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.82, yPercent: 0.66, angleDegrees: 186, speed: 210, radius: 20),

            InitialObjectDefinition(type: .scissors, xPercent: 0.38, yPercent: 0.18, angleDegrees: 82, speed: 210, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.68, yPercent: 0.82, angleDegrees: 262, speed: 210, radius: 20),

            InitialObjectDefinition(type: .paper, xPercent: 0.28, yPercent: 0.80, angleDegrees: 338, speed: 205, radius: 20)
        ]
    )

    static let level11 = LevelDefinition(
        levelNumber: 11,
        startingAmmo: 4,
        launchSpeed: 220,
        launchedRockRadius: 20,
        initialObjects: [
            // Theme: diagonal dispersion with offsets between opposing types
            InitialObjectDefinition(type: .paper, xPercent: 0.16, yPercent: 0.26, angleDegrees: 34, speed: 205, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.82, yPercent: 0.22, angleDegrees: 132, speed: 205, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.26, yPercent: 0.56, angleDegrees: 304, speed: 205, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.74, yPercent: 0.62, angleDegrees: 206, speed: 205, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.48, yPercent: 0.84, angleDegrees: 252, speed: 195, radius: 20)
        ]
    )

    static let level12 = LevelDefinition(
        levelNumber: 12,
        startingAmmo: 4,
        launchSpeed: 240,
        launchedRockRadius: 20,
        initialObjects: [
            // Theme: alternating columns, no shared vertical lane for opposite types
            InitialObjectDefinition(type: .paper, xPercent: 0.16, yPercent: 0.22, directionDX: 0, directionDY: 1, speed: 240, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.34, yPercent: 0.76, directionDX: 0, directionDY: -1, speed: 240, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.52, yPercent: 0.28, directionDX: 0, directionDY: 1, speed: 240, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.70, yPercent: 0.82, directionDX: 0, directionDY: -1, speed: 240, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.86, yPercent: 0.36, directionDX: 0, directionDY: 1, speed: 240, radius: 20)
        ]
    )

    static let level13 = LevelDefinition(
        levelNumber: 13,
        startingAmmo: 3,
        launchSpeed: 240,
        launchedRockRadius: 18,
        initialObjects: [
            // Theme: first friendly rock, random field
            InitialObjectDefinition(type: .rock,
                                    xPercent: 0.50, yPercent: 0.50,
                                    angleDegrees: -50, speed: 240,
                                    radius: 18),

            InitialObjectDefinition(type: .paper,
                                    xPercent: 0.18, yPercent: 0.28,
                                    angleDegrees: 58, speed: 240,
                                    radius: 18),
            InitialObjectDefinition(type: .scissors,
                                    xPercent: 0.82, yPercent: 0.30,
                                    angleDegrees: -38, speed: 240,
                                    radius: 18),
            
            InitialObjectDefinition(type: .paper,
                                    xPercent: 0.24, yPercent: 0.76,
                                    angleDegrees: -312, speed: 240,
                                    radius: 18),
            InitialObjectDefinition(type: .scissors,
                                    xPercent: 0.76, yPercent: 0.78,
                                    angleDegrees: -228, speed: 240,
                                    radius: 18)
        ]
    )

    static let level14 = LevelDefinition(
        levelNumber: 14,
        startingAmmo: 3,
        launchSpeed: 240,
        launchedRockRadius: 20,
        initialObjects: [
            // Theme: corner motion with center rock
            InitialObjectDefinition(type: .paper, xPercent: 0.50, yPercent: 0.50, directionDX: 0, directionDY: 1, speed: 240, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.25, yPercent: 0.75, angleDegrees: -60, speed: 240, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.75, yPercent: 0.75, angleDegrees: 240, speed: 240, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.2, yPercent: 0.50, angleDegrees: 90, speed: 240, radius: 20),
            InitialObjectDefinition(type: .rock, xPercent: 0.8, yPercent: 0.50, angleDegrees: 90, speed: 240, radius: 20),
        ]
    )

    static let level15 = LevelDefinition(
        levelNumber: 15,
        startingAmmo: 3,
        launchSpeed: 240,
        launchedRockRadius: 20,
        initialObjects: [
            // Theme: faster chaotic dispersion with one rock
            InitialObjectDefinition(type: .rock, xPercent: 0.52, yPercent: 0.36,
                                    angleDegrees: 80, speed: 240, radius: 20),

            InitialObjectDefinition(type: .paper, xPercent: 0.16, yPercent: 0.24,
                                    angleDegrees: 30, speed: 240, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.84, yPercent: 0.28,
                                    angleDegrees: 165, speed: 240, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.28, yPercent: 0.62,
                                    angleDegrees: -60, speed: 240, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.74, yPercent: 0.66,
                                    angleDegrees: 225, speed: 240, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.46, yPercent: 0.84,
                                    angleDegrees: 275, speed: 240, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.1, yPercent: 0.1,
                                    angleDegrees: 45, speed: 240, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.9, yPercent: 0.8,
                                    angleDegrees: 45, speed: 240, radius: 20)
        ]
    )
    static let level16 = LevelDefinition(
        levelNumber: 16,
        startingAmmo: 3,
        launchSpeed: 240,
        launchedRockRadius: 20,
        initialObjects: [
            // Theme: two going side to side, one going up/down, in groups
            InitialObjectDefinition(type: .rock,
                                    xPercent: 0.1, yPercent: 0.2,
                                    angleDegrees: 0, speed: 240,
                                    radius: 20),
            InitialObjectDefinition(type: .paper,
                                    xPercent: 0.1, yPercent: 0.4,
                                    angleDegrees: 0, speed: 240,
                                    radius: 20),
            InitialObjectDefinition(type: .rock,
                                    xPercent: 0.3, yPercent: 0.2,
                                    angleDegrees: 0, speed: 240,
                                    radius: 20),
            InitialObjectDefinition(type: .paper,
                                    xPercent: 0.3, yPercent: 0.4,
                                    angleDegrees: 0, speed: 240,
                                    radius: 20),
            InitialObjectDefinition(type: .scissors,
                                    xPercent: 0.5, yPercent: 0.6,
                                    angleDegrees: 0, speed: 240,
                                    radius: 20),
            InitialObjectDefinition(type: .paper,
                                    xPercent: 0.5, yPercent: 0.8,
                                    angleDegrees: 0, speed: 240,
                                    radius: 20),
            InitialObjectDefinition(type: .scissors,
                                    xPercent: 0.7, yPercent: 0.6,
                                    angleDegrees: 0, speed: 240,
                                    radius: 20),
            InitialObjectDefinition(type: .paper,
                                    xPercent: 0.7, yPercent: 0.8,
                                    angleDegrees: 0, speed: 240,
                                    radius: 20),
            InitialObjectDefinition(type: .scissors,
                                    xPercent: 0.1, yPercent: 0.95,
                                    angleDegrees: 90, speed: 240,
                                    radius: 20),
            InitialObjectDefinition(type: .scissors,
                                    xPercent: 0.3, yPercent: 0.95,
                                    angleDegrees: 90, speed: 240,
                                    radius: 20),
            InitialObjectDefinition(type: .scissors,
                                    xPercent: 0.1, yPercent: 0.75,
                                    angleDegrees: -90, speed: 240,
                                    radius: 20),
            InitialObjectDefinition(type: .scissors,
                                    xPercent: 0.3, yPercent: 0.75,
                                    angleDegrees: -90, speed: 240,
                                    radius: 20)
        ]
    )

    static let level17 = LevelDefinition(
        levelNumber: 17,
        startingAmmo: 3,
        launchSpeed: 245,
        launchedRockRadius: 20,
        initialObjects: [
            InitialObjectDefinition(type: .rock, xPercent: 0.50, yPercent: 0.18, angleDegrees: 90, speed: 220, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.18, yPercent: 0.34, angleDegrees: 16, speed: 220, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.82, yPercent: 0.44, angleDegrees: 188, speed: 220, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.28, yPercent: 0.74, angleDegrees: 332, speed: 220, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.76, yPercent: 0.82, angleDegrees: 214, speed: 220, radius: 20)
        ]
    )

    static let level18 = LevelDefinition(
        levelNumber: 18,
        startingAmmo: 3,
        launchSpeed: 245,
        launchedRockRadius: 20,
        initialObjects: [
            InitialObjectDefinition(type: .paper, xPercent: 0.14, yPercent: 0.22, angleDegrees: 36, speed: 225, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.84, yPercent: 0.24, angleDegrees: 144, speed: 225, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.20, yPercent: 0.56, angleDegrees: 342, speed: 225, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.78, yPercent: 0.62, angleDegrees: 198, speed: 225, radius: 20),
            InitialObjectDefinition(type: .rock, xPercent: 0.50, yPercent: 0.82, angleDegrees: 270, speed: 215, radius: 20)
        ]
    )

    static let level19 = LevelDefinition(
        levelNumber: 19,
        startingAmmo: 2,
        launchSpeed: 250,
        launchedRockRadius: 20,
        initialObjects: [
            InitialObjectDefinition(type: .scissors, xPercent: 0.16, yPercent: 0.30, angleDegrees: 8, speed: 230, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.38, yPercent: 0.18, angleDegrees: 76, speed: 230, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.64, yPercent: 0.82, angleDegrees: 258, speed: 230, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.84, yPercent: 0.68, angleDegrees: 188, speed: 230, radius: 20),
            InitialObjectDefinition(type: .rock, xPercent: 0.50, yPercent: 0.50, angleDegrees: 24, speed: 220, radius: 20)
        ]
    )

    static let level20 = LevelDefinition(
        levelNumber: 20,
        startingAmmo: 2,
        launchSpeed: 255,
        launchedRockRadius: 20,
        initialObjects: [
            InitialObjectDefinition(type: .rock, xPercent: 0.18, yPercent: 0.18, angleDegrees: 42, speed: 230, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.82, yPercent: 0.22, angleDegrees: 156, speed: 230, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.22, yPercent: 0.48, angleDegrees: 348, speed: 230, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.78, yPercent: 0.58, angleDegrees: 204, speed: 230, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.34, yPercent: 0.82, angleDegrees: 294, speed: 230, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.66, yPercent: 0.84, angleDegrees: 246, speed: 230, radius: 20)
        ]
    )
}
