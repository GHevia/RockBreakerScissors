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

struct ArenaWallDefinition {
    let xPercent: CGFloat
    let yPercent: CGFloat
    let widthPercent: CGFloat
    let heightPercent: CGFloat
}

struct LevelDefinition {
    let levelNumber: Int
    let startingAmmo: Int
    let launchSpeed: CGFloat
    let launchedRockRadius: CGFloat
    let initialObjects: [InitialObjectDefinition]
    let walls: [ArenaWallDefinition]
    let introMessage: String?

    init(
        levelNumber: Int,
        startingAmmo: Int,
        launchSpeed: CGFloat,
        launchedRockRadius: CGFloat,
        initialObjects: [InitialObjectDefinition],
        walls: [ArenaWallDefinition] = [],
        introMessage: String? = nil
    ) {
        self.levelNumber = levelNumber
        self.startingAmmo = startingAmmo
        self.launchSpeed = launchSpeed
        self.launchedRockRadius = launchedRockRadius
        self.initialObjects = initialObjects
        self.walls = walls
        self.introMessage = introMessage
    }
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
        level20,
        level21,
        level22,
        level23,
        level24,
        level25,
        level26,
        level27,
        level28,
        level29,
        level30,
        level31,
        level32,
        level33,
        level34,
        level35,
        level36,
        level37,
        level38,
        level39,
        level40,
        level41,
        level42,
        level43,
        level44,
        level45,
        level46,
        level47,
        level48,
        level49,
        level50,
        level51,
        level52,
        level53,
        level54,
        level55,
        level56,
        level57,
        level58,
        level59,
        level60,
        level61,
        level62,
        level63,
        level64,
        level65,
        level66,
        level67,
        level68,
        level69,
        level70,
        level71,
        level72,
        level73
    ]

    static let level1 = LevelDefinition(
        levelNumber: 1,
        startingAmmo: 8,
        launchSpeed: 150,
        launchedRockRadius: 20,
        initialObjects: [
            InitialObjectDefinition(
                type: .paper,
                xPercent: 0.20,
                yPercent: 0.78,
                directionDX: 3,
                directionDY: -2,
                speed: 150,
                radius: 20
            ),
            InitialObjectDefinition(
                type: .scissors,
                xPercent: 0.78,
                yPercent: 0.35,
                directionDX: -2,
                directionDY: 2,
                speed: 150,
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
        launchSpeed: 220,
        launchedRockRadius: 20,
        initialObjects: [
            // Theme: vertical lanes, staggered so they do not meet immediately
            InitialObjectDefinition(type: .paper, xPercent: 0.18, yPercent: 0.22, directionDX: 0, directionDY: 1, speed: 220, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.38, yPercent: 0.72, directionDX: 0, directionDY: -1, speed: 220, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.62, yPercent: 0.30, directionDX: 0, directionDY: 1, speed: 220, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.82, yPercent: 0.78, directionDX: 0, directionDY: -1, speed: 220, radius: 20)
        ],
        introMessage: "Objects move faster now."
    )

    static let level7 = LevelDefinition(
        levelNumber: 7,
        startingAmmo: 5,
        launchSpeed: 220,
        launchedRockRadius: 20,
        initialObjects: [
            // Theme: horizontal lanes, separated vertically
            InitialObjectDefinition(type: .paper, xPercent: 0.18, yPercent: 0.22, directionDX: 1, directionDY: 0, speed: 220, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.82, yPercent: 0.38, directionDX: -1, directionDY: 0, speed: 220, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.24, yPercent: 0.58, directionDX: 1, directionDY: 0, speed: 220, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.76, yPercent: 0.78, directionDX: -1, directionDY: 0, speed: 220, radius: 20)
        ]
    )

    static let level8 = LevelDefinition(
        levelNumber: 8,
        startingAmmo: 5,
        launchSpeed: 220,
        launchedRockRadius: 20,
        initialObjects: [
            InitialObjectDefinition(type: .paper, xPercent: 0.14, yPercent: 0.22, angleDegrees: 0, speed: 220, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.34, yPercent: 0.38, angleDegrees: 0, speed: 220, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.54, yPercent: 0.54, angleDegrees: 0, speed: 220, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.74, yPercent: 0.70, angleDegrees: 0, speed: 220, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.22, yPercent: 0.86, angleDegrees: 0, speed: 220, radius: 20)
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
            InitialObjectDefinition(type: .scissors, xPercent: 0.18, yPercent: 0.64, directionDX: 1, directionDY: 0, speed: 220, radius: 20),

            InitialObjectDefinition(type: .paper, xPercent: 0.82, yPercent: 0.34, directionDX: -1, directionDY: 0, speed: 220, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.76, yPercent: 0.56, directionDX: -1, directionDY: 0, speed: 220, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.82, yPercent: 0.78, directionDX: -1, directionDY: 0, speed: 220, radius: 20)
        ]
    )

    static let level10 = LevelDefinition(
        levelNumber: 10,
        startingAmmo: 4,
        launchSpeed: 220,
        launchedRockRadius: 20,
        initialObjects: [
            // Theme: center traffic, with separated lanes to prevent instant collapse
            InitialObjectDefinition(type: .paper, xPercent: 0.16, yPercent: 0.18, angleDegrees: 90, speed: 220, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.52, yPercent: 0.58, angleDegrees: 90, speed: 220, radius: 20),

            InitialObjectDefinition(type: .scissors, xPercent: 0.34, yPercent: 0.38, angleDegrees: 90, speed: 220, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.70, yPercent: 0.78, angleDegrees: 90, speed: 220, radius: 20),

            InitialObjectDefinition(type: .paper, xPercent: 0.86, yPercent: 0.30, angleDegrees: 90, speed: 220, radius: 20)
        ]
    )

    static let level11 = LevelDefinition(
        levelNumber: 11,
        startingAmmo: 4,
        launchSpeed: 220,
        launchedRockRadius: 20,
        initialObjects: [
            // Theme: broad diagonal lanes with equal launch and arena speeds
            InitialObjectDefinition(type: .paper, xPercent: 0.14, yPercent: 0.18, angleDegrees: 18, speed: 220, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.84, yPercent: 0.26, angleDegrees: 162, speed: 220, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.18, yPercent: 0.60, angleDegrees: 342, speed: 220, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.78, yPercent: 0.76, angleDegrees: 198, speed: 220, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.50, yPercent: 0.88, angleDegrees: 0, speed: 220, radius: 20)
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
        startingAmmo: 4,
        launchSpeed: 200,
        launchedRockRadius: 18,
        initialObjects: [
            // Theme: first friendly rock, with lanes that leave time to plan
            InitialObjectDefinition(type: .rock,
                                    xPercent: 0.16, yPercent: 0.24,
                                    angleDegrees: 0, speed: 200,
                                    radius: 18),

            InitialObjectDefinition(type: .paper,
                                    xPercent: 0.36, yPercent: 0.38,
                                    angleDegrees: 0, speed: 200,
                                    radius: 18),
            InitialObjectDefinition(type: .scissors,
                                    xPercent: 0.58, yPercent: 0.52,
                                    angleDegrees: 0, speed: 200,
                                    radius: 18),
            InitialObjectDefinition(type: .paper,
                                    xPercent: 0.78, yPercent: 0.66,
                                    angleDegrees: 0, speed: 200,
                                    radius: 18),
            InitialObjectDefinition(type: .scissors,
                                    xPercent: 0.26, yPercent: 0.82,
                                    angleDegrees: 0, speed: 200,
                                    radius: 18)
        ],
        introMessage: "Some levels start with rocks already in play."
    )


    static let level14 = LevelDefinition(
        levelNumber: 14,
        startingAmmo: 3,
        launchSpeed: 220,
        launchedRockRadius: 20,
        initialObjects: [
            // Theme: corner motion with center rock
            InitialObjectDefinition(type: .paper, xPercent: 0.50, yPercent: 0.50, directionDX: 0, directionDY: 1, speed: 220, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.25, yPercent: 0.75, angleDegrees: -60, speed: 220, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.75, yPercent: 0.75, angleDegrees: 240, speed: 220, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.2, yPercent: 0.50, angleDegrees: 90, speed: 220, radius: 20),
            InitialObjectDefinition(type: .rock, xPercent: 0.8, yPercent: 0.50, angleDegrees: 90, speed: 220, radius: 20),
        ]
    )

    static let level15 = LevelDefinition(
        levelNumber: 15,
        startingAmmo: 3,
        launchSpeed: 220,
        launchedRockRadius: 20,
        initialObjects: [
            // Theme: broad random lanes that do not solve themselves
            InitialObjectDefinition(type: .rock, xPercent: 0.12, yPercent: 0.18,
                                    angleDegrees: 35, speed: 220, radius: 20),

            InitialObjectDefinition(type: .paper, xPercent: 0.34, yPercent: 0.25,
                                    angleDegrees: 35, speed: 220, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.58, yPercent: 0.32,
                                    angleDegrees: 35, speed: 220, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.82, yPercent: 0.42,
                                    angleDegrees: 35, speed: 220, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.18, yPercent: 0.64,
                                    angleDegrees: 35, speed: 220, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.42, yPercent: 0.74,
                                    angleDegrees: 35, speed: 220, radius: 20),
            InitialObjectDefinition(type: .rock, xPercent: 0.68, yPercent: 0.84,
                                    angleDegrees: 35, speed: 220, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.88, yPercent: 0.90,
                                    angleDegrees: 35, speed: 220, radius: 20)
        ]
    )
    static let level16 = LevelDefinition(
        levelNumber: 16,
        startingAmmo: 3,
        launchSpeed: 220,
        launchedRockRadius: 20,
        initialObjects: [
            // Theme: two going side to side, one going up/down, in groups
            InitialObjectDefinition(type: .rock,
                                    xPercent: 0.1, yPercent: 0.2,
                                    angleDegrees: 0, speed: 220,
                                    radius: 20),
            InitialObjectDefinition(type: .paper,
                                    xPercent: 0.1, yPercent: 0.4,
                                    angleDegrees: 0, speed: 220,
                                    radius: 20),
            InitialObjectDefinition(type: .rock,
                                    xPercent: 0.3, yPercent: 0.2,
                                    angleDegrees: 0, speed: 220,
                                    radius: 20),
            InitialObjectDefinition(type: .paper,
                                    xPercent: 0.3, yPercent: 0.4,
                                    angleDegrees: 0, speed: 220,
                                    radius: 20),
            InitialObjectDefinition(type: .scissors,
                                    xPercent: 0.5, yPercent: 0.6,
                                    angleDegrees: 0, speed: 220,
                                    radius: 20),
            InitialObjectDefinition(type: .paper,
                                    xPercent: 0.5, yPercent: 0.8,
                                    angleDegrees: 0, speed: 220,
                                    radius: 20),
            InitialObjectDefinition(type: .scissors,
                                    xPercent: 0.7, yPercent: 0.6,
                                    angleDegrees: 0, speed: 220,
                                    radius: 20),
            InitialObjectDefinition(type: .paper,
                                    xPercent: 0.7, yPercent: 0.8,
                                    angleDegrees: 0, speed: 220,
                                    radius: 20),
            InitialObjectDefinition(type: .scissors,
                                    xPercent: 0.1, yPercent: 0.95,
                                    angleDegrees: 90, speed: 220,
                                    radius: 20),
            InitialObjectDefinition(type: .scissors,
                                    xPercent: 0.3, yPercent: 0.95,
                                    angleDegrees: 90, speed: 220,
                                    radius: 20),
            InitialObjectDefinition(type: .scissors,
                                    xPercent: 0.1, yPercent: 0.75,
                                    angleDegrees: -90, speed: 220,
                                    radius: 20),
            InitialObjectDefinition(type: .scissors,
                                    xPercent: 0.3, yPercent: 0.75,
                                    angleDegrees: -90, speed: 220,
                                    radius: 20)
        ]
    )

    static let level17 = LevelDefinition(
        levelNumber: 17,
        startingAmmo: 3,
        launchSpeed: 220,
        launchedRockRadius: 20,
        initialObjects: [
            InitialObjectDefinition(type: .rock, xPercent: 0.18, yPercent: 0.22, angleDegrees: 10, speed: 220, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.38, yPercent: 0.36, angleDegrees: 10, speed: 220, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.60, yPercent: 0.50, angleDegrees: 10, speed: 220, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.82, yPercent: 0.66, angleDegrees: 10, speed: 220, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.28, yPercent: 0.82, angleDegrees: 10, speed: 220, radius: 20)
        ],
        introMessage: "Watch the starting rock. It can help or hurt depending on timing."
    )

    static let level18 = LevelDefinition(
        levelNumber: 18,
        startingAmmo: 3,
        launchSpeed: 220,
        launchedRockRadius: 20,
        initialObjects: [
            InitialObjectDefinition(type: .scissors, xPercent: 0.16, yPercent: 0.20, angleDegrees: 325, speed: 220, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.38, yPercent: 0.30, angleDegrees: 325, speed: 220, radius: 20),
            InitialObjectDefinition(type: .rock, xPercent: 0.62, yPercent: 0.40, angleDegrees: 325, speed: 220, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.84, yPercent: 0.50, angleDegrees: 325, speed: 220, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.28, yPercent: 0.72, angleDegrees: 325, speed: 220, radius: 20),
            InitialObjectDefinition(type: .rock, xPercent: 0.58, yPercent: 0.84, angleDegrees: 325, speed: 220, radius: 20)
        ]
    )

    static let level19 = LevelDefinition(
        levelNumber: 19,
        startingAmmo: 2,
        launchSpeed: 230,
        launchedRockRadius: 20,
        initialObjects: [
            InitialObjectDefinition(type: .scissors, xPercent: 0.16, yPercent: 0.30, angleDegrees: 8, speed: 230, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.38, yPercent: 0.18, angleDegrees: 76, speed: 230, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.64, yPercent: 0.82, angleDegrees: 258, speed: 230, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.84, yPercent: 0.68, angleDegrees: 188, speed: 230, radius: 20),
            InitialObjectDefinition(type: .rock, xPercent: 0.50, yPercent: 0.50, angleDegrees: 24, speed: 230, radius: 20)
        ],
        introMessage: "Ammo is tighter now. Wait for the board to open up."
    )

    static let level20 = LevelDefinition(
        levelNumber: 20,
        startingAmmo: 2,
        launchSpeed: 230,
        launchedRockRadius: 20,
        initialObjects: [
            InitialObjectDefinition(type: .rock, xPercent: 0.18, yPercent: 0.18, angleDegrees: 42, speed: 230, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.82, yPercent: 0.22, angleDegrees: 156, speed: 230, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.22, yPercent: 0.48, angleDegrees: 348, speed: 230, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.78, yPercent: 0.58, angleDegrees: 204, speed: 230, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.34, yPercent: 0.82, angleDegrees: 294, speed: 230, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.66, yPercent: 0.84, angleDegrees: 246, speed: 230, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.1, yPercent: 0.1, angleDegrees: 0, speed: 230, radius: 20),
            InitialObjectDefinition(type: .rock, xPercent: 0.1, yPercent: 0.9, angleDegrees: 0, speed: 230, radius: 20)
        ]
    )

    static let level21 = LevelDefinition(
        levelNumber: 21,
        startingAmmo: 3,
        launchSpeed: 270,
        launchedRockRadius: 20,
        initialObjects: [
            InitialObjectDefinition(type: .paper, xPercent: 0.16, yPercent: 0.24, angleDegrees: 18, speed: 150, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.84, yPercent: 0.32, angleDegrees: 162, speed: 150, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.24, yPercent: 0.70, angleDegrees: 342, speed: 150, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.76, yPercent: 0.82, angleDegrees: 198, speed: 150, radius: 20),
            InitialObjectDefinition(type: .rock, xPercent: 0.50, yPercent: 0.52, angleDegrees: 90, speed: 140, radius: 20),
             InitialObjectDefinition(type: .rock, xPercent: 0.90, yPercent: 0.92, angleDegrees: 0, speed: 140, radius: 20)
        ],
        introMessage: "Fired rocks can be faster than the objects already in the arena."
    )

    static let level22 = LevelDefinition(
        levelNumber: 22,
        startingAmmo: 3,
        launchSpeed: 270,
        launchedRockRadius: 20,
        initialObjects: [
            InitialObjectDefinition(type: .rock, xPercent: 0.1, yPercent: 0.1, angleDegrees: 60, speed: 150, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.2, yPercent: 0.2, angleDegrees: 60, speed: 150, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.3, yPercent: 0.3, angleDegrees: 60, speed: 150, radius: 20),
            InitialObjectDefinition(type: .rock, xPercent: 0.1, yPercent: 0.7, angleDegrees: 240, speed: 150, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.2, yPercent: 0.8, angleDegrees: 240, speed: 140, radius: 20),
             InitialObjectDefinition(type: .scissors, xPercent: 0.3, yPercent: 0.9, angleDegrees: 240, speed: 140, radius: 20)
        ]
    )

    static let level23 = LevelDefinition(
        levelNumber: 23,
        startingAmmo: 3,
        launchSpeed: 245,
        launchedRockRadius: 20,
        initialObjects: [
            InitialObjectDefinition(type: .paper, xPercent: 0.16, yPercent: 0.22, angleDegrees: 24, speed: 185, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.84, yPercent: 0.30, angleDegrees: 156, speed: 185, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.20, yPercent: 0.72, angleDegrees: 336, speed: 185, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.80, yPercent: 0.82, angleDegrees: 204, speed: 185, radius: 20)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.44, widthPercent: 0.12, heightPercent: 0.34),
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.76, widthPercent: 0.42, heightPercent: 0.06)
        ],
        introMessage: "Walls deflect both fired rocks and moving objects."
    )



    static let level24 = LevelDefinition(
        levelNumber: 24,
        startingAmmo: 5,
        launchSpeed: 230,
        launchedRockRadius: 20,
        initialObjects: [
            // Concept: stationary targets
            InitialObjectDefinition(type: .scissors, xPercent: 0.18, yPercent: 0.26, angleDegrees: 0, speed: 0, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.82, yPercent: 0.30, angleDegrees: 0, speed: 0, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.28, yPercent: 0.74, angleDegrees: 0, speed: 0, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.72, yPercent: 0.78, angleDegrees: 0, speed: 0, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.50, yPercent: 0.18, angleDegrees: 90, speed: 0, radius: 20)
        ],
        introMessage: "Objects can be stationary targets. Use them as anchors for chain reactions."
    )

    static let level25 = LevelDefinition(
        levelNumber: 25,
        startingAmmo: 4,
        launchSpeed: 235,
        launchedRockRadius: 20,
        initialObjects: [
            // Stationary papers with moving scissors pressure
            InitialObjectDefinition(type: .paper, xPercent: 0.18, yPercent: 0.22, angleDegrees: 0, speed: 0, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.82, yPercent: 0.22, angleDegrees: 180, speed: 170, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.30, yPercent: 0.58, angleDegrees: 0, speed: 0, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.70, yPercent: 0.66, angleDegrees: 210, speed: 170, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.50, yPercent: 0.84, angleDegrees: 0, speed: 0, radius: 20)
        ]
    )

    static let level26 = LevelDefinition(
        levelNumber: 26,
        startingAmmo: 4,
        launchSpeed: 240,
        launchedRockRadius: 20,
        initialObjects: [
            // Static scissors plus a moving rock seed
            InitialObjectDefinition(type: .scissors, xPercent: 0.20, yPercent: 0.22, angleDegrees: 0, speed: 0, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.80, yPercent: 0.22, angleDegrees: 0, speed: 0, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.24, yPercent: 0.62, angleDegrees: 20, speed: 185, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.76, yPercent: 0.70, angleDegrees: 160, speed: 185, radius: 20),
            InitialObjectDefinition(type: .rock, xPercent: 0.50, yPercent: 0.48, angleDegrees: 90, speed: 120, radius: 20)
        ]
    )

    static let level27 = LevelDefinition(
        levelNumber: 27,
        startingAmmo: 3,
        launchSpeed: 245,
        launchedRockRadius: 20,
        initialObjects: [
            // Stationary target cluster with tighter ammo
            InitialObjectDefinition(type: .paper, xPercent: 0.14, yPercent: 0.28, angleDegrees: 0, speed: 0, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.86, yPercent: 0.34, angleDegrees: 0, speed: 0, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.24, yPercent: 0.72, angleDegrees: 335, speed: 190, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.76, yPercent: 0.82, angleDegrees: 205, speed: 190, radius: 20),
            InitialObjectDefinition(type: .rock, xPercent: 0.50, yPercent: 0.54, angleDegrees: 75, speed: 140, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.50, yPercent: 0.18, angleDegrees: 0, speed: 0, radius: 20)
        ]
    )

    static let level28 = LevelDefinition(
        levelNumber: 28,
        startingAmmo: 4,
        launchSpeed: 240,
        launchedRockRadius: 20,
        initialObjects: [
            // Concept: single center wall
            InitialObjectDefinition(type: .paper, xPercent: 0.16, yPercent: 0.24, angleDegrees: 20, speed: 190, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.84, yPercent: 0.30, angleDegrees: 160, speed: 190, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.22, yPercent: 0.74, angleDegrees: 340, speed: 190, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.78, yPercent: 0.82, angleDegrees: 200, speed: 190, radius: 20)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.50, widthPercent: 0.12, heightPercent: 0.36)
        ],
        introMessage: "Walls can block direct shots. Bank rocks around them."
    )

    static let level29 = LevelDefinition(
        levelNumber: 29,
        startingAmmo: 4,
        launchSpeed: 245,
        launchedRockRadius: 20,
        initialObjects: [
            // Horizontal shelf
            InitialObjectDefinition(type: .paper, xPercent: 0.18, yPercent: 0.18, angleDegrees: 35, speed: 200, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.82, yPercent: 0.24, angleDegrees: 145, speed: 200, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.20, yPercent: 0.80, angleDegrees: 325, speed: 200, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.80, yPercent: 0.86, angleDegrees: 215, speed: 200, radius: 20),
            InitialObjectDefinition(type: .rock, xPercent: 0.50, yPercent: 0.62, angleDegrees: 90, speed: 120, radius: 20)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.44, widthPercent: 0.52, heightPercent: 0.06)
        ]
    )

    static let level30 = LevelDefinition(
        levelNumber: 30,
        startingAmmo: 4,
        launchSpeed: 250,
        launchedRockRadius: 20,
        initialObjects: [
            // Two posts create side channels
            InitialObjectDefinition(type: .paper, xPercent: 0.15, yPercent: 0.30, angleDegrees: 12, speed: 205, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.85, yPercent: 0.36, angleDegrees: 168, speed: 205, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.24, yPercent: 0.68, angleDegrees: 330, speed: 205, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.76, yPercent: 0.76, angleDegrees: 210, speed: 205, radius: 20)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.34, yPercent: 0.54, widthPercent: 0.10, heightPercent: 0.42),
            ArenaWallDefinition(xPercent: 0.66, yPercent: 0.54, widthPercent: 0.10, heightPercent: 0.42)
        ]
    )

    static let level31 = LevelDefinition(
        levelNumber: 31,
        startingAmmo: 3,
        launchSpeed: 250,
        launchedRockRadius: 20,
        initialObjects: [
            // Wall corner
            InitialObjectDefinition(type: .paper, xPercent: 0.14, yPercent: 0.22, angleDegrees: 26, speed: 205, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.86, yPercent: 0.30, angleDegrees: 154, speed: 205, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.20, yPercent: 0.70, angleDegrees: 334, speed: 205, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.80, yPercent: 0.84, angleDegrees: 206, speed: 205, radius: 20),
            InitialObjectDefinition(type: .rock, xPercent: 0.50, yPercent: 0.50, angleDegrees: 90, speed: 130, radius: 20)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.42, widthPercent: 0.12, heightPercent: 0.30),
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.78, widthPercent: 0.48, heightPercent: 0.06)
        ]
    )

    static let level32 = LevelDefinition(
        levelNumber: 32,
        startingAmmo: 4,
        launchSpeed: 255,
        launchedRockRadius: 19,
        initialObjects: [
            // Concept: gate shots
            InitialObjectDefinition(type: .paper, xPercent: 0.16, yPercent: 0.22, angleDegrees: 0, speed: 215, radius: 19),
            InitialObjectDefinition(type: .scissors, xPercent: 0.84, yPercent: 0.28, angleDegrees: 180, speed: 215, radius: 19),
            InitialObjectDefinition(type: .paper, xPercent: 0.18, yPercent: 0.78, angleDegrees: 0, speed: 215, radius: 19),
            InitialObjectDefinition(type: .scissors, xPercent: 0.82, yPercent: 0.84, angleDegrees: 180, speed: 215, radius: 19)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.38, yPercent: 0.50, widthPercent: 0.08, heightPercent: 0.48),
            ArenaWallDefinition(xPercent: 0.62, yPercent: 0.50, widthPercent: 0.08, heightPercent: 0.48)
        ],
        introMessage: "Some walls form gates. Timing matters more than raw aim."
    )

    static let level33 = LevelDefinition(
        levelNumber: 33,
        startingAmmo: 4,
        launchSpeed: 255,
        launchedRockRadius: 19,
        initialObjects: [
            // Horizontal gates
            InitialObjectDefinition(type: .scissors, xPercent: 0.20, yPercent: 0.24, angleDegrees: 20, speed: 215, radius: 19),
            InitialObjectDefinition(type: .paper, xPercent: 0.80, yPercent: 0.34, angleDegrees: 160, speed: 215, radius: 19),
            InitialObjectDefinition(type: .scissors, xPercent: 0.24, yPercent: 0.72, angleDegrees: 340, speed: 215, radius: 19),
            InitialObjectDefinition(type: .paper, xPercent: 0.76, yPercent: 0.82, angleDegrees: 200, speed: 215, radius: 19),
            InitialObjectDefinition(type: .rock, xPercent: 0.50, yPercent: 0.58, angleDegrees: 90, speed: 130, radius: 19)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.36, widthPercent: 0.48, heightPercent: 0.06),
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.68, widthPercent: 0.48, heightPercent: 0.06)
        ]
    )

    static let level34 = LevelDefinition(
        levelNumber: 34,
        startingAmmo: 3,
        launchSpeed: 260,
        launchedRockRadius: 19,
        initialObjects: [
            // Offset maze
            InitialObjectDefinition(type: .paper, xPercent: 0.14, yPercent: 0.30, angleDegrees: 50, speed: 220, radius: 19),
            InitialObjectDefinition(type: .scissors, xPercent: 0.86, yPercent: 0.34, angleDegrees: 130, speed: 220, radius: 19),
            InitialObjectDefinition(type: .paper, xPercent: 0.22, yPercent: 0.76, angleDegrees: 310, speed: 220, radius: 19),
            InitialObjectDefinition(type: .scissors, xPercent: 0.78, yPercent: 0.82, angleDegrees: 230, speed: 220, radius: 19)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.32, yPercent: 0.46, widthPercent: 0.08, heightPercent: 0.38),
            ArenaWallDefinition(xPercent: 0.68, yPercent: 0.66, widthPercent: 0.08, heightPercent: 0.38),
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.56, widthPercent: 0.24, heightPercent: 0.06)
        ]
    )

    static let level35 = LevelDefinition(
        levelNumber: 35,
        startingAmmo: 3,
        launchSpeed: 265,
        launchedRockRadius: 19,
        initialObjects: [
            // Banked maze with low ammo
            InitialObjectDefinition(type: .paper, xPercent: 0.18, yPercent: 0.20, angleDegrees: 25, speed: 225, radius: 19),
            InitialObjectDefinition(type: .scissors, xPercent: 0.82, yPercent: 0.26, angleDegrees: 155, speed: 225, radius: 19),
            InitialObjectDefinition(type: .paper, xPercent: 0.20, yPercent: 0.74, angleDegrees: 335, speed: 225, radius: 19),
            InitialObjectDefinition(type: .scissors, xPercent: 0.80, yPercent: 0.86, angleDegrees: 205, speed: 225, radius: 19),
            InitialObjectDefinition(type: .rock, xPercent: 0.50, yPercent: 0.50, angleDegrees: 0, speed: 120, radius: 19)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.28, yPercent: 0.52, widthPercent: 0.08, heightPercent: 0.34),
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.72, widthPercent: 0.34, heightPercent: 0.06),
            ArenaWallDefinition(xPercent: 0.72, yPercent: 0.52, widthPercent: 0.08, heightPercent: 0.34)
        ]
    )

    static let level36 = LevelDefinition(
        levelNumber: 36,
        startingAmmo: 5,
        launchSpeed: 255,
        launchedRockRadius: 14,
        initialObjects: [
            // Concept: small objects
            InitialObjectDefinition(type: .paper, xPercent: 0.16, yPercent: 0.22, angleDegrees: 25, speed: 210, radius: 14),
            InitialObjectDefinition(type: .scissors, xPercent: 0.84, yPercent: 0.28, angleDegrees: 155, speed: 210, radius: 14),
            InitialObjectDefinition(type: .paper, xPercent: 0.22, yPercent: 0.62, angleDegrees: 340, speed: 210, radius: 14),
            InitialObjectDefinition(type: .scissors, xPercent: 0.78, yPercent: 0.72, angleDegrees: 200, speed: 210, radius: 14),
            InitialObjectDefinition(type: .paper, xPercent: 0.50, yPercent: 0.86, angleDegrees: 0, speed: 210, radius: 14)
        ],
        introMessage: "Smaller objects are harder to hit but create cleaner puzzles."
    )

    static let level37 = LevelDefinition(
        levelNumber: 37,
        startingAmmo: 5,
        launchSpeed: 260,
        launchedRockRadius: 14,
        initialObjects: [
            // Small diagonal train
            InitialObjectDefinition(type: .scissors, xPercent: 0.14, yPercent: 0.20, angleDegrees: 15, speed: 220, radius: 14),
            InitialObjectDefinition(type: .paper, xPercent: 0.36, yPercent: 0.34, angleDegrees: 15, speed: 220, radius: 14),
            InitialObjectDefinition(type: .scissors, xPercent: 0.58, yPercent: 0.48, angleDegrees: 15, speed: 220, radius: 14),
            InitialObjectDefinition(type: .paper, xPercent: 0.80, yPercent: 0.62, angleDegrees: 15, speed: 220, radius: 14),
            InitialObjectDefinition(type: .scissors, xPercent: 0.24, yPercent: 0.82, angleDegrees: 15, speed: 220, radius: 14)
        ]
    )

    static let level38 = LevelDefinition(
        levelNumber: 38,
        startingAmmo: 4,
        launchSpeed: 265,
        launchedRockRadius: 13,
        initialObjects: [
            // Small lane targets
            InitialObjectDefinition(type: .paper, xPercent: 0.18, yPercent: 0.24, angleDegrees: 0, speed: 230, radius: 13),
            InitialObjectDefinition(type: .scissors, xPercent: 0.82, yPercent: 0.30, angleDegrees: 180, speed: 230, radius: 13),
            InitialObjectDefinition(type: .paper, xPercent: 0.18, yPercent: 0.56, angleDegrees: 0, speed: 230, radius: 13),
            InitialObjectDefinition(type: .scissors, xPercent: 0.82, yPercent: 0.64, angleDegrees: 180, speed: 230, radius: 13),
            InitialObjectDefinition(type: .paper, xPercent: 0.50, yPercent: 0.84, angleDegrees: 0, speed: 230, radius: 13),
            InitialObjectDefinition(type: .rock, xPercent: 0.50, yPercent: 0.46, angleDegrees: 90, speed: 140, radius: 13)
        ]
    )

    static let level39 = LevelDefinition(
        levelNumber: 39,
        startingAmmo: 4,
        launchSpeed: 270,
        launchedRockRadius: 13,
        initialObjects: [
            // Small moving and stationary mix
            InitialObjectDefinition(type: .paper, xPercent: 0.14, yPercent: 0.22, angleDegrees: 45, speed: 235, radius: 13),
            InitialObjectDefinition(type: .scissors, xPercent: 0.86, yPercent: 0.28, angleDegrees: 135, speed: 235, radius: 13),
            InitialObjectDefinition(type: .paper, xPercent: 0.20, yPercent: 0.72, angleDegrees: 315, speed: 235, radius: 13),
            InitialObjectDefinition(type: .scissors, xPercent: 0.80, yPercent: 0.82, angleDegrees: 225, speed: 235, radius: 13),
            InitialObjectDefinition(type: .paper, xPercent: 0.50, yPercent: 0.52, angleDegrees: 0, speed: 0, radius: 13),
            InitialObjectDefinition(type: .scissors, xPercent: 0.50, yPercent: 0.88, angleDegrees: 0, speed: 0, radius: 13)
        ]
    )

    static let level40 = LevelDefinition(
        levelNumber: 40,
        startingAmmo: 4,
        launchSpeed: 245,
        launchedRockRadius: 20,
        initialObjects: [
            // Concept: very large initial object
            InitialObjectDefinition(type: .paper, xPercent: 0.50, yPercent: 0.70, angleDegrees: 0, speed: 120, radius: 42),
            InitialObjectDefinition(type: .scissors, xPercent: 0.18, yPercent: 0.24, angleDegrees: 25, speed: 210, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.82, yPercent: 0.32, angleDegrees: 155, speed: 210, radius: 20),
            InitialObjectDefinition(type: .rock, xPercent: 0.50, yPercent: 0.28, angleDegrees: 0, speed: 120, radius: 20)
        ],
        introMessage: "Large objects dominate the board. Convert them early or they reshape everything."
    )

    static let level41 = LevelDefinition(
        levelNumber: 41,
        startingAmmo: 4,
        launchSpeed: 250,
        launchedRockRadius: 20,
        initialObjects: [
            // Large scissors threat
            InitialObjectDefinition(type: .scissors, xPercent: 0.50, yPercent: 0.66, angleDegrees: 180, speed: 130, radius: 40),
            InitialObjectDefinition(type: .paper, xPercent: 0.20, yPercent: 0.24, angleDegrees: 0, speed: 215, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.80, yPercent: 0.34, angleDegrees: 180, speed: 215, radius: 20),
            InitialObjectDefinition(type: .rock, xPercent: 0.50, yPercent: 0.86, angleDegrees: 270, speed: 120, radius: 20)
        ]
    )

    static let level42 = LevelDefinition(
        levelNumber: 42,
        startingAmmo: 3,
        launchSpeed: 255,
        launchedRockRadius: 19,
        initialObjects: [
            // Large target behind wall
            InitialObjectDefinition(type: .paper, xPercent: 0.32, yPercent: 0.58, angleDegrees: 45, speed: 140, radius: 38),
            InitialObjectDefinition(type: .scissors, xPercent: 0.72, yPercent: 0.72, angleDegrees: 205, speed: 220, radius: 19),
            InitialObjectDefinition(type: .scissors, xPercent: 0.18, yPercent: 0.28, angleDegrees: 25, speed: 220, radius: 19),
            InitialObjectDefinition(type: .rock, xPercent: 0.82, yPercent: 0.32, angleDegrees: 155, speed: 130, radius: 19)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.42, widthPercent: 0.12, heightPercent: 0.28)
        ]
    )

    static let level43 = LevelDefinition(
        levelNumber: 43,
        startingAmmo: 3,
        launchSpeed: 260,
        launchedRockRadius: 18,
        initialObjects: [
            // Large center with fast satellites
            InitialObjectDefinition(type: .paper, xPercent: 0.50, yPercent: 0.52, angleDegrees: 90, speed: 150, radius: 36),
            InitialObjectDefinition(type: .scissors, xPercent: 0.20, yPercent: 0.20, angleDegrees: 20, speed: 230, radius: 18),
            InitialObjectDefinition(type: .scissors, xPercent: 0.80, yPercent: 0.28, angleDegrees: 160, speed: 230, radius: 18),
            InitialObjectDefinition(type: .paper, xPercent: 0.22, yPercent: 0.84, angleDegrees: 340, speed: 230, radius: 18),
            InitialObjectDefinition(type: .rock, xPercent: 0.78, yPercent: 0.78, angleDegrees: 200, speed: 140, radius: 18)
        ]
    )

    static let level44 = LevelDefinition(
        levelNumber: 44,
        startingAmmo: 4,
        launchSpeed: 260,
        launchedRockRadius: 18,
        initialObjects: [
            // Concept: mixed sizes
            InitialObjectDefinition(type: .paper, xPercent: 0.18, yPercent: 0.22, angleDegrees: 20, speed: 220, radius: 14),
            InitialObjectDefinition(type: .scissors, xPercent: 0.82, yPercent: 0.28, angleDegrees: 160, speed: 220, radius: 26),
            InitialObjectDefinition(type: .paper, xPercent: 0.22, yPercent: 0.68, angleDegrees: 340, speed: 220, radius: 18),
            InitialObjectDefinition(type: .scissors, xPercent: 0.78, yPercent: 0.82, angleDegrees: 200, speed: 220, radius: 14),
            InitialObjectDefinition(type: .rock, xPercent: 0.50, yPercent: 0.54, angleDegrees: 90, speed: 140, radius: 22)
        ],
        introMessage: "Mixed sizes change priorities. Big threats are easy to hit, small threats are easy to miss."
    )

    static let level45 = LevelDefinition(
        levelNumber: 45,
        startingAmmo: 4,
        launchSpeed: 265,
        launchedRockRadius: 17,
        initialObjects: [
            // Mixed-size horizontal flow
            InitialObjectDefinition(type: .paper, xPercent: 0.16, yPercent: 0.24, angleDegrees: 0, speed: 230, radius: 12),
            InitialObjectDefinition(type: .scissors, xPercent: 0.36, yPercent: 0.38, angleDegrees: 0, speed: 230, radius: 24),
            InitialObjectDefinition(type: .paper, xPercent: 0.58, yPercent: 0.52, angleDegrees: 0, speed: 230, radius: 16),
            InitialObjectDefinition(type: .scissors, xPercent: 0.80, yPercent: 0.66, angleDegrees: 0, speed: 230, radius: 12),
            InitialObjectDefinition(type: .paper, xPercent: 0.26, yPercent: 0.84, angleDegrees: 0, speed: 230, radius: 24)
        ]
    )

    static let level46 = LevelDefinition(
        levelNumber: 46,
        startingAmmo: 3,
        launchSpeed: 270,
        launchedRockRadius: 17,
        initialObjects: [
            // Large corner threats
            InitialObjectDefinition(type: .scissors, xPercent: 0.20, yPercent: 0.22, angleDegrees: 30, speed: 235, radius: 28),
            InitialObjectDefinition(type: .paper, xPercent: 0.82, yPercent: 0.32, angleDegrees: 150, speed: 235, radius: 13),
            InitialObjectDefinition(type: .scissors, xPercent: 0.24, yPercent: 0.72, angleDegrees: 330, speed: 235, radius: 13),
            InitialObjectDefinition(type: .paper, xPercent: 0.76, yPercent: 0.84, angleDegrees: 210, speed: 235, radius: 28),
            InitialObjectDefinition(type: .rock, xPercent: 0.50, yPercent: 0.54, angleDegrees: 90, speed: 150, radius: 17)
        ]
    )

    static let level47 = LevelDefinition(
        levelNumber: 47,
        startingAmmo: 3,
        launchSpeed: 275,
        launchedRockRadius: 16,
        initialObjects: [
            // Mixed sizes plus shelf
            InitialObjectDefinition(type: .paper, xPercent: 0.16, yPercent: 0.22, angleDegrees: 25, speed: 240, radius: 12),
            InitialObjectDefinition(type: .scissors, xPercent: 0.84, yPercent: 0.30, angleDegrees: 155, speed: 240, radius: 12),
            InitialObjectDefinition(type: .paper, xPercent: 0.20, yPercent: 0.70, angleDegrees: 335, speed: 240, radius: 26),
            InitialObjectDefinition(type: .scissors, xPercent: 0.80, yPercent: 0.84, angleDegrees: 205, speed: 240, radius: 26),
            InitialObjectDefinition(type: .rock, xPercent: 0.50, yPercent: 0.48, angleDegrees: 0, speed: 150, radius: 16)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.64, widthPercent: 0.44, heightPercent: 0.06)
        ]
    )

    static let level48 = LevelDefinition(
        levelNumber: 48,
        startingAmmo: 3,
        launchSpeed: 300,
        launchedRockRadius: 18,
        initialObjects: [
            // Concept: speed mismatch
            InitialObjectDefinition(type: .paper, xPercent: 0.16, yPercent: 0.24, angleDegrees: 20, speed: 150, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.84, yPercent: 0.32, angleDegrees: 160, speed: 150, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.24, yPercent: 0.72, angleDegrees: 340, speed: 150, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.76, yPercent: 0.82, angleDegrees: 200, speed: 150, radius: 20)
        ],
        introMessage: "Your fired rocks are much faster here. Use quick angles instead of waiting."
    )

    static let level49 = LevelDefinition(
        levelNumber: 49,
        startingAmmo: 3,
        launchSpeed: 305,
        launchedRockRadius: 18,
        initialObjects: [
            // Fast launch, slow board
            InitialObjectDefinition(type: .scissors, xPercent: 0.18, yPercent: 0.22, angleDegrees: 35, speed: 160, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.82, yPercent: 0.34, angleDegrees: 145, speed: 160, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.24, yPercent: 0.76, angleDegrees: 325, speed: 160, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.76, yPercent: 0.84, angleDegrees: 215, speed: 160, radius: 20),
            InitialObjectDefinition(type: .rock, xPercent: 0.50, yPercent: 0.54, angleDegrees: 90, speed: 120, radius: 18)
        ]
    )

    static let level50 = LevelDefinition(
        levelNumber: 50,
        startingAmmo: 3,
        launchSpeed: 310,
        launchedRockRadius: 17,
        initialObjects: [
            // Fast rocks around center post
            InitialObjectDefinition(type: .paper, xPercent: 0.14, yPercent: 0.20, angleDegrees: 0, speed: 170, radius: 18),
            InitialObjectDefinition(type: .scissors, xPercent: 0.86, yPercent: 0.28, angleDegrees: 180, speed: 170, radius: 18),
            InitialObjectDefinition(type: .paper, xPercent: 0.18, yPercent: 0.58, angleDegrees: 0, speed: 170, radius: 18),
            InitialObjectDefinition(type: .scissors, xPercent: 0.82, yPercent: 0.66, angleDegrees: 180, speed: 170, radius: 18),
            InitialObjectDefinition(type: .paper, xPercent: 0.50, yPercent: 0.86, angleDegrees: 0, speed: 170, radius: 18)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.50, widthPercent: 0.12, heightPercent: 0.40)
        ]
    )

    static let level51 = LevelDefinition(
        levelNumber: 51,
        startingAmmo: 2,
        launchSpeed: 315,
        launchedRockRadius: 17,
        initialObjects: [
            // Fast low-ammo gate
            InitialObjectDefinition(type: .paper, xPercent: 0.18, yPercent: 0.22, angleDegrees: 24, speed: 175, radius: 18),
            InitialObjectDefinition(type: .scissors, xPercent: 0.82, yPercent: 0.30, angleDegrees: 156, speed: 175, radius: 18),
            InitialObjectDefinition(type: .paper, xPercent: 0.22, yPercent: 0.72, angleDegrees: 336, speed: 175, radius: 18),
            InitialObjectDefinition(type: .scissors, xPercent: 0.78, yPercent: 0.84, angleDegrees: 204, speed: 175, radius: 18),
            InitialObjectDefinition(type: .rock, xPercent: 0.50, yPercent: 0.50, angleDegrees: 90, speed: 110, radius: 18)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.36, yPercent: 0.58, widthPercent: 0.08, heightPercent: 0.38),
            ArenaWallDefinition(xPercent: 0.64, yPercent: 0.58, widthPercent: 0.08, heightPercent: 0.38)
        ]
    )

    static let level52 = LevelDefinition(
        levelNumber: 52,
        startingAmmo: 2,
        launchSpeed: 280,
        launchedRockRadius: 18,
        initialObjects: [
            // Concept: low-ammo precision
            InitialObjectDefinition(type: .scissors, xPercent: 0.18, yPercent: 0.25, angleDegrees: 15, speed: 220, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.80, yPercent: 0.35, angleDegrees: 160, speed: 220, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.24, yPercent: 0.78, angleDegrees: 330, speed: 220, radius: 20),
            InitialObjectDefinition(type: .rock, xPercent: 0.62, yPercent: 0.66, angleDegrees: 210, speed: 140, radius: 20)
        ],
        introMessage: "Some levels give only a few rocks. One good shot should start the solution."
    )

    static let level53 = LevelDefinition(
        levelNumber: 53,
        startingAmmo: 2,
        launchSpeed: 285,
        launchedRockRadius: 18,
        initialObjects: [
            // Two-shot wall puzzle
            InitialObjectDefinition(type: .paper, xPercent: 0.16, yPercent: 0.22, angleDegrees: 25, speed: 230, radius: 18),
            InitialObjectDefinition(type: .scissors, xPercent: 0.84, yPercent: 0.30, angleDegrees: 155, speed: 230, radius: 18),
            InitialObjectDefinition(type: .paper, xPercent: 0.22, yPercent: 0.74, angleDegrees: 335, speed: 230, radius: 18),
            InitialObjectDefinition(type: .rock, xPercent: 0.76, yPercent: 0.82, angleDegrees: 205, speed: 150, radius: 18)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.52, widthPercent: 0.12, heightPercent: 0.32)
        ]
    )

    static let level54 = LevelDefinition(
        levelNumber: 54,
        startingAmmo: 2,
        launchSpeed: 290,
        launchedRockRadius: 17,
        initialObjects: [
            // Two-shot small train
            InitialObjectDefinition(type: .scissors, xPercent: 0.20, yPercent: 0.24, angleDegrees: 0, speed: 230, radius: 15),
            InitialObjectDefinition(type: .paper, xPercent: 0.42, yPercent: 0.40, angleDegrees: 0, speed: 230, radius: 15),
            InitialObjectDefinition(type: .scissors, xPercent: 0.64, yPercent: 0.56, angleDegrees: 0, speed: 230, radius: 15),
            InitialObjectDefinition(type: .paper, xPercent: 0.84, yPercent: 0.72, angleDegrees: 0, speed: 230, radius: 15),
            InitialObjectDefinition(type: .rock, xPercent: 0.24, yPercent: 0.84, angleDegrees: 0, speed: 150, radius: 17)
        ]
    )

    static let level55 = LevelDefinition(
        levelNumber: 55,
        startingAmmo: 1,
        launchSpeed: 300,
        launchedRockRadius: 20,
        initialObjects: [
            // One-rock chain reaction
            InitialObjectDefinition(type: .paper, xPercent: 0.24, yPercent: 0.26, angleDegrees: 30, speed: 190, radius: 22),
            InitialObjectDefinition(type: .scissors, xPercent: 0.76, yPercent: 0.34, angleDegrees: 150, speed: 190, radius: 22),
            InitialObjectDefinition(type: .paper, xPercent: 0.28, yPercent: 0.76, angleDegrees: 330, speed: 190, radius: 22),
            InitialObjectDefinition(type: .scissors, xPercent: 0.72, yPercent: 0.84, angleDegrees: 210, speed: 190, radius: 22),
            InitialObjectDefinition(type: .rock, xPercent: 0.50, yPercent: 0.56, angleDegrees: 90, speed: 120, radius: 22)
        ]
    )

    static let level56 = LevelDefinition(
        levelNumber: 56,
        startingAmmo: 4,
        launchSpeed: 275,
        launchedRockRadius: 18,
        initialObjects: [
            // Concept: chaotic dispersions
            InitialObjectDefinition(type: .paper, xPercent: 0.14, yPercent: 0.20, angleDegrees: 17, speed: 230, radius: 18),
            InitialObjectDefinition(type: .scissors, xPercent: 0.82, yPercent: 0.24, angleDegrees: 143, speed: 225, radius: 18),
            InitialObjectDefinition(type: .paper, xPercent: 0.30, yPercent: 0.46, angleDegrees: 281, speed: 235, radius: 18),
            InitialObjectDefinition(type: .scissors, xPercent: 0.68, yPercent: 0.52, angleDegrees: 64, speed: 220, radius: 18),
            InitialObjectDefinition(type: .paper, xPercent: 0.22, yPercent: 0.78, angleDegrees: 331, speed: 230, radius: 18),
            InitialObjectDefinition(type: .scissors, xPercent: 0.86, yPercent: 0.86, angleDegrees: 213, speed: 225, radius: 18)
        ],
        introMessage: "Random-looking boards reward patience. Let the ecology move before firing."
    )

    static let level57 = LevelDefinition(
        levelNumber: 57,
        startingAmmo: 4,
        launchSpeed: 280,
        launchedRockRadius: 18,
        initialObjects: [
            // Random six-object board
            InitialObjectDefinition(type: .scissors, xPercent: 0.16, yPercent: 0.22, angleDegrees: 52, speed: 235, radius: 17),
            InitialObjectDefinition(type: .paper, xPercent: 0.44, yPercent: 0.26, angleDegrees: 118, speed: 225, radius: 17),
            InitialObjectDefinition(type: .scissors, xPercent: 0.76, yPercent: 0.36, angleDegrees: 207, speed: 240, radius: 17),
            InitialObjectDefinition(type: .paper, xPercent: 0.24, yPercent: 0.58, angleDegrees: 302, speed: 230, radius: 17),
            InitialObjectDefinition(type: .scissors, xPercent: 0.58, yPercent: 0.72, angleDegrees: 18, speed: 235, radius: 17),
            InitialObjectDefinition(type: .paper, xPercent: 0.84, yPercent: 0.84, angleDegrees: 244, speed: 225, radius: 17)
        ]
    )

    static let level58 = LevelDefinition(
        levelNumber: 58,
        startingAmmo: 3,
        launchSpeed: 285,
        launchedRockRadius: 17,
        initialObjects: [
            // Random with rock seed
            InitialObjectDefinition(type: .paper, xPercent: 0.18, yPercent: 0.20, angleDegrees: 11, speed: 240, radius: 16),
            InitialObjectDefinition(type: .scissors, xPercent: 0.78, yPercent: 0.22, angleDegrees: 166, speed: 230, radius: 20),
            InitialObjectDefinition(type: .rock, xPercent: 0.40, yPercent: 0.42, angleDegrees: 74, speed: 150, radius: 18),
            InitialObjectDefinition(type: .paper, xPercent: 0.64, yPercent: 0.54, angleDegrees: 259, speed: 235, radius: 16),
            InitialObjectDefinition(type: .scissors, xPercent: 0.24, yPercent: 0.76, angleDegrees: 318, speed: 240, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.86, yPercent: 0.84, angleDegrees: 219, speed: 230, radius: 16)
        ]
    )

    static let level59 = LevelDefinition(
        levelNumber: 59,
        startingAmmo: 3,
        launchSpeed: 290,
        launchedRockRadius: 17,
        initialObjects: [
            // Chaotic shelf board
            InitialObjectDefinition(type: .scissors, xPercent: 0.14, yPercent: 0.24, angleDegrees: 35, speed: 245, radius: 15),
            InitialObjectDefinition(type: .paper, xPercent: 0.34, yPercent: 0.32, angleDegrees: 101, speed: 235, radius: 21),
            InitialObjectDefinition(type: .scissors, xPercent: 0.68, yPercent: 0.40, angleDegrees: 191, speed: 245, radius: 15),
            InitialObjectDefinition(type: .paper, xPercent: 0.86, yPercent: 0.56, angleDegrees: 274, speed: 235, radius: 21),
            InitialObjectDefinition(type: .rock, xPercent: 0.24, yPercent: 0.82, angleDegrees: 326, speed: 150, radius: 17),
            InitialObjectDefinition(type: .paper, xPercent: 0.60, yPercent: 0.84, angleDegrees: 227, speed: 240, radius: 15)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.62, widthPercent: 0.40, heightPercent: 0.06)
        ]
    )

    static let level60 = LevelDefinition(
        levelNumber: 60,
        startingAmmo: 3,
        launchSpeed: 270,
        launchedRockRadius: 18,
        initialObjects: [
            // Concept: rock seeds
            InitialObjectDefinition(type: .rock, xPercent: 0.16, yPercent: 0.22, angleDegrees: 20, speed: 190, radius: 18),
            InitialObjectDefinition(type: .paper, xPercent: 0.36, yPercent: 0.34, angleDegrees: 20, speed: 210, radius: 18),
            InitialObjectDefinition(type: .scissors, xPercent: 0.58, yPercent: 0.46, angleDegrees: 20, speed: 210, radius: 18),
            InitialObjectDefinition(type: .rock, xPercent: 0.80, yPercent: 0.58, angleDegrees: 20, speed: 190, radius: 18),
            InitialObjectDefinition(type: .paper, xPercent: 0.24, yPercent: 0.80, angleDegrees: 20, speed: 210, radius: 18)
        ],
        introMessage: "Starting rocks can become allies. Protect them from paper long enough to spread."
    )

    static let level61 = LevelDefinition(
        levelNumber: 61,
        startingAmmo: 3,
        launchSpeed: 275,
        launchedRockRadius: 18,
        initialObjects: [
            // Two rock seeds in flow
            InitialObjectDefinition(type: .rock, xPercent: 0.20, yPercent: 0.22, angleDegrees: 0, speed: 170, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.40, yPercent: 0.36, angleDegrees: 0, speed: 220, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.62, yPercent: 0.50, angleDegrees: 0, speed: 220, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.84, yPercent: 0.64, angleDegrees: 0, speed: 220, radius: 20),
            InitialObjectDefinition(type: .rock, xPercent: 0.28, yPercent: 0.82, angleDegrees: 0, speed: 170, radius: 20)
        ]
    )

    static let level62 = LevelDefinition(
        levelNumber: 62,
        startingAmmo: 2,
        launchSpeed: 280,
        launchedRockRadius: 17,
        initialObjects: [
            // Central seed behind wall
            InitialObjectDefinition(type: .rock, xPercent: 0.50, yPercent: 0.54, angleDegrees: 90, speed: 130, radius: 17),
            InitialObjectDefinition(type: .paper, xPercent: 0.16, yPercent: 0.24, angleDegrees: 24, speed: 235, radius: 17),
            InitialObjectDefinition(type: .scissors, xPercent: 0.84, yPercent: 0.30, angleDegrees: 156, speed: 235, radius: 17),
            InitialObjectDefinition(type: .paper, xPercent: 0.22, yPercent: 0.72, angleDegrees: 336, speed: 235, radius: 17),
            InitialObjectDefinition(type: .scissors, xPercent: 0.78, yPercent: 0.84, angleDegrees: 204, speed: 235, radius: 17)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.42, widthPercent: 0.12, heightPercent: 0.28)
        ]
    )

    static let level63 = LevelDefinition(
        levelNumber: 63,
        startingAmmo: 2,
        launchSpeed: 285,
        launchedRockRadius: 17,
        initialObjects: [
            // Twin seed timing
            InitialObjectDefinition(type: .rock, xPercent: 0.18, yPercent: 0.20, angleDegrees: 45, speed: 160, radius: 17),
            InitialObjectDefinition(type: .rock, xPercent: 0.82, yPercent: 0.28, angleDegrees: 135, speed: 160, radius: 17),
            InitialObjectDefinition(type: .paper, xPercent: 0.26, yPercent: 0.54, angleDegrees: 315, speed: 235, radius: 17),
            InitialObjectDefinition(type: .scissors, xPercent: 0.74, yPercent: 0.62, angleDegrees: 225, speed: 235, radius: 17),
            InitialObjectDefinition(type: .paper, xPercent: 0.50, yPercent: 0.84, angleDegrees: 0, speed: 235, radius: 17)
        ]
    )

    static let level64 = LevelDefinition(
        levelNumber: 64,
        startingAmmo: 4,
        launchSpeed: 285,
        launchedRockRadius: 15,
        initialObjects: [
            // Concept: combined mechanics
            InitialObjectDefinition(type: .scissors, xPercent: 0.18, yPercent: 0.24, angleDegrees: 0, speed: 0, radius: 15),
            InitialObjectDefinition(type: .paper, xPercent: 0.82, yPercent: 0.30, angleDegrees: 160, speed: 220, radius: 15),
            InitialObjectDefinition(type: .scissors, xPercent: 0.24, yPercent: 0.72, angleDegrees: 0, speed: 0, radius: 15),
            InitialObjectDefinition(type: .paper, xPercent: 0.76, yPercent: 0.84, angleDegrees: 200, speed: 220, radius: 15),
            InitialObjectDefinition(type: .rock, xPercent: 0.50, yPercent: 0.56, angleDegrees: 90, speed: 140, radius: 15)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.46, widthPercent: 0.12, heightPercent: 0.34)
        ],
        introMessage: "Concepts now combine: small objects, stationary targets, rocks, and walls."
    )

    static let level65 = LevelDefinition(
        levelNumber: 65,
        startingAmmo: 4,
        launchSpeed: 290,
        launchedRockRadius: 15,
        initialObjects: [
            // Small gate plus static targets
            InitialObjectDefinition(type: .paper, xPercent: 0.14, yPercent: 0.22, angleDegrees: 25, speed: 230, radius: 14),
            InitialObjectDefinition(type: .scissors, xPercent: 0.86, yPercent: 0.28, angleDegrees: 155, speed: 230, radius: 14),
            InitialObjectDefinition(type: .paper, xPercent: 0.20, yPercent: 0.72, angleDegrees: 0, speed: 0, radius: 14),
            InitialObjectDefinition(type: .scissors, xPercent: 0.80, yPercent: 0.82, angleDegrees: 0, speed: 0, radius: 14),
            InitialObjectDefinition(type: .rock, xPercent: 0.50, yPercent: 0.52, angleDegrees: 90, speed: 140, radius: 18)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.36, yPercent: 0.56, widthPercent: 0.08, heightPercent: 0.40),
            ArenaWallDefinition(xPercent: 0.64, yPercent: 0.56, widthPercent: 0.08, heightPercent: 0.40)
        ]
    )

    static let level66 = LevelDefinition(
        levelNumber: 66,
        startingAmmo: 3,
        launchSpeed: 295,
        launchedRockRadius: 15,
        initialObjects: [
            // Mixed sizes with shelf
            InitialObjectDefinition(type: .paper, xPercent: 0.18, yPercent: 0.20, angleDegrees: 35, speed: 235, radius: 13),
            InitialObjectDefinition(type: .scissors, xPercent: 0.82, yPercent: 0.26, angleDegrees: 145, speed: 235, radius: 24),
            InitialObjectDefinition(type: .paper, xPercent: 0.22, yPercent: 0.70, angleDegrees: 325, speed: 235, radius: 13),
            InitialObjectDefinition(type: .scissors, xPercent: 0.78, yPercent: 0.84, angleDegrees: 215, speed: 235, radius: 24),
            InitialObjectDefinition(type: .rock, xPercent: 0.50, yPercent: 0.52, angleDegrees: 0, speed: 140, radius: 15)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.72, widthPercent: 0.46, heightPercent: 0.06)
        ]
    )

    static let level67 = LevelDefinition(
        levelNumber: 67,
        startingAmmo: 3,
        launchSpeed: 300,
        launchedRockRadius: 14,
        initialObjects: [
            // Combined maze
            InitialObjectDefinition(type: .scissors, xPercent: 0.16, yPercent: 0.24, angleDegrees: 0, speed: 0, radius: 14),
            InitialObjectDefinition(type: .paper, xPercent: 0.84, yPercent: 0.32, angleDegrees: 156, speed: 240, radius: 14),
            InitialObjectDefinition(type: .scissors, xPercent: 0.24, yPercent: 0.76, angleDegrees: 336, speed: 240, radius: 14),
            InitialObjectDefinition(type: .paper, xPercent: 0.76, yPercent: 0.84, angleDegrees: 0, speed: 0, radius: 14),
            InitialObjectDefinition(type: .rock, xPercent: 0.50, yPercent: 0.50, angleDegrees: 90, speed: 140, radius: 14)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.30, yPercent: 0.52, widthPercent: 0.08, heightPercent: 0.36),
            ArenaWallDefinition(xPercent: 0.70, yPercent: 0.52, widthPercent: 0.08, heightPercent: 0.36),
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.74, widthPercent: 0.28, heightPercent: 0.06)
        ]
    )

    static let level68 = LevelDefinition(
        levelNumber: 68,
        startingAmmo: 3,
        launchSpeed: 300,
        launchedRockRadius: 16,
        initialObjects: [
            // Final stretch: mixed concepts
            InitialObjectDefinition(type: .paper, xPercent: 0.14, yPercent: 0.22, angleDegrees: 18, speed: 245, radius: 14),
            InitialObjectDefinition(type: .scissors, xPercent: 0.84, yPercent: 0.30, angleDegrees: 162, speed: 245, radius: 22),
            InitialObjectDefinition(type: .paper, xPercent: 0.22, yPercent: 0.70, angleDegrees: 342, speed: 245, radius: 14),
            InitialObjectDefinition(type: .scissors, xPercent: 0.78, yPercent: 0.84, angleDegrees: 198, speed: 245, radius: 22),
            InitialObjectDefinition(type: .rock, xPercent: 0.50, yPercent: 0.54, angleDegrees: 90, speed: 145, radius: 16),
            InitialObjectDefinition(type: .paper, xPercent: 0.50, yPercent: 0.88, angleDegrees: 0, speed: 0, radius: 16)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.42, widthPercent: 0.12, heightPercent: 0.30)
        ],
        introMessage: "From here on, anything can appear together."
    )

    static let level69 = LevelDefinition(
        levelNumber: 69,
        startingAmmo: 3,
        launchSpeed: 305,
        launchedRockRadius: 15,
        initialObjects: [
            // Chaotic mixed shelf
            InitialObjectDefinition(type: .scissors, xPercent: 0.16, yPercent: 0.20, angleDegrees: 44, speed: 250, radius: 15),
            InitialObjectDefinition(type: .paper, xPercent: 0.42, yPercent: 0.28, angleDegrees: 116, speed: 240, radius: 20),
            InitialObjectDefinition(type: .rock, xPercent: 0.72, yPercent: 0.38, angleDegrees: 196, speed: 150, radius: 15),
            InitialObjectDefinition(type: .paper, xPercent: 0.22, yPercent: 0.60, angleDegrees: 302, speed: 250, radius: 15),
            InitialObjectDefinition(type: .scissors, xPercent: 0.58, yPercent: 0.76, angleDegrees: 28, speed: 240, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.84, yPercent: 0.86, angleDegrees: 236, speed: 250, radius: 15)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.62, widthPercent: 0.44, heightPercent: 0.06)
        ]
    )

    static let level70 = LevelDefinition(
        levelNumber: 70,
        startingAmmo: 2,
        launchSpeed: 310,
        launchedRockRadius: 15,
        initialObjects: [
            // Large object final
            InitialObjectDefinition(type: .paper, xPercent: 0.18, yPercent: 0.22, angleDegrees: 25, speed: 185, radius: 38),
            InitialObjectDefinition(type: .scissors, xPercent: 0.82, yPercent: 0.30, angleDegrees: 155, speed: 250, radius: 15),
            InitialObjectDefinition(type: .paper, xPercent: 0.22, yPercent: 0.74, angleDegrees: 335, speed: 250, radius: 15),
            InitialObjectDefinition(type: .scissors, xPercent: 0.78, yPercent: 0.84, angleDegrees: 205, speed: 250, radius: 15),
            InitialObjectDefinition(type: .rock, xPercent: 0.50, yPercent: 0.52, angleDegrees: 90, speed: 145, radius: 15)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.44, widthPercent: 0.12, heightPercent: 0.34)
        ]
    )

    static let level71 = LevelDefinition(
        levelNumber: 71,
        startingAmmo: 2,
        launchSpeed: 315,
        launchedRockRadius: 14,
        initialObjects: [
            // Fast small train
            InitialObjectDefinition(type: .rock, xPercent: 0.16, yPercent: 0.24, angleDegrees: 0, speed: 150, radius: 14),
            InitialObjectDefinition(type: .paper, xPercent: 0.34, yPercent: 0.36, angleDegrees: 0, speed: 255, radius: 14),
            InitialObjectDefinition(type: .scissors, xPercent: 0.52, yPercent: 0.48, angleDegrees: 0, speed: 255, radius: 14),
            InitialObjectDefinition(type: .paper, xPercent: 0.70, yPercent: 0.60, angleDegrees: 0, speed: 255, radius: 14),
            InitialObjectDefinition(type: .scissors, xPercent: 0.88, yPercent: 0.72, angleDegrees: 0, speed: 255, radius: 14),
            InitialObjectDefinition(type: .rock, xPercent: 0.26, yPercent: 0.84, angleDegrees: 0, speed: 150, radius: 14)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.76, widthPercent: 0.40, heightPercent: 0.06)
        ]
    )

    static let level72 = LevelDefinition(
        levelNumber: 72,
        startingAmmo: 2,
        launchSpeed: 320,
        launchedRockRadius: 14,
        initialObjects: [
            // Low ammo chaos gate
            InitialObjectDefinition(type: .paper, xPercent: 0.14, yPercent: 0.20, angleDegrees: 31, speed: 255, radius: 13),
            InitialObjectDefinition(type: .scissors, xPercent: 0.84, yPercent: 0.24, angleDegrees: 149, speed: 255, radius: 13),
            InitialObjectDefinition(type: .paper, xPercent: 0.28, yPercent: 0.48, angleDegrees: 287, speed: 245, radius: 22),
            InitialObjectDefinition(type: .scissors, xPercent: 0.68, yPercent: 0.56, angleDegrees: 73, speed: 245, radius: 22),
            InitialObjectDefinition(type: .rock, xPercent: 0.22, yPercent: 0.80, angleDegrees: 337, speed: 145, radius: 14),
            InitialObjectDefinition(type: .paper, xPercent: 0.86, yPercent: 0.86, angleDegrees: 211, speed: 255, radius: 13)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.34, yPercent: 0.54, widthPercent: 0.08, heightPercent: 0.38),
            ArenaWallDefinition(xPercent: 0.66, yPercent: 0.54, widthPercent: 0.08, heightPercent: 0.38)
        ]
    )

    static let level73 = LevelDefinition(
        levelNumber: 73,
        startingAmmo: 1,
        launchSpeed: 330,
        launchedRockRadius: 14,
        initialObjects: [
            // One-shot final combo
            InitialObjectDefinition(type: .rock, xPercent: 0.50, yPercent: 0.50, angleDegrees: 90, speed: 140, radius: 14),
            InitialObjectDefinition(type: .paper, xPercent: 0.16, yPercent: 0.22, angleDegrees: 20, speed: 255, radius: 14),
            InitialObjectDefinition(type: .scissors, xPercent: 0.84, yPercent: 0.30, angleDegrees: 160, speed: 255, radius: 14),
            InitialObjectDefinition(type: .paper, xPercent: 0.22, yPercent: 0.70, angleDegrees: 340, speed: 255, radius: 24),
            InitialObjectDefinition(type: .scissors, xPercent: 0.78, yPercent: 0.84, angleDegrees: 200, speed: 255, radius: 24),
            InitialObjectDefinition(type: .paper, xPercent: 0.50, yPercent: 0.88, angleDegrees: 0, speed: 0, radius: 14)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.40, widthPercent: 0.12, heightPercent: 0.30),
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.72, widthPercent: 0.42, heightPercent: 0.06)
        ],
        introMessage: "Final test: one rock, all concepts. Wait, bank, and let the chain finish."
    )
}
