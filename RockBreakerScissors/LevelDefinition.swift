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
        level73,
        level74,
        level75,
        level76,
        level77,
        level78,
        level79,
        level80,
        level81,
        level82,
        level83,
        level84,
        level85,
        level86,
        level87,
        level88,
        level89,
        level90,
        level91,
        level92,
        level93,
        level94,
        level95,
        level96,
        level97,
        level98,
        level99,
        level100
    ]

    static let level1 = LevelDefinition(
        levelNumber: 1,
        startingAmmo: 8,
        launchSpeed: 110,
        launchedRockRadius: 22,
        initialObjects: [
            InitialObjectDefinition(type: .scissors, xPercent: 0.50, yPercent: 0.60, angleDegrees: 0, speed: 0, radius: 22)
        ]
    )

    static let level2 = LevelDefinition(
        levelNumber: 2,
        startingAmmo: 8,
        launchSpeed: 110,
        launchedRockRadius: 22,
        initialObjects: [
            InitialObjectDefinition(type: .scissors, xPercent: 0.28, yPercent: 0.55, angleDegrees: 0, speed: 0, radius: 22),
            InitialObjectDefinition(type: .scissors, xPercent: 0.72, yPercent: 0.72, angleDegrees: 0, speed: 0, radius: 22)
        ]
    )

    static let level3 = LevelDefinition(
        levelNumber: 3,
        startingAmmo: 8,
        launchSpeed: 110,
        launchedRockRadius: 22,
        initialObjects: [
            InitialObjectDefinition(type: .scissors, xPercent: 0.25, yPercent: 0.55, angleDegrees: 0, speed: 110, radius: 22),
            InitialObjectDefinition(type: .scissors, xPercent: 0.75, yPercent: 0.78, angleDegrees: 180, speed: 110, radius: 22)
        ]
    )

    static let level4 = LevelDefinition(
        levelNumber: 4,
        startingAmmo: 10,
        launchSpeed: 100,
        launchedRockRadius: 22,
        initialObjects: [
            InitialObjectDefinition(type: .scissors, xPercent: 0.20, yPercent: 0.72, angleDegrees: 0, speed: 100, radius: 22),
            InitialObjectDefinition(type: .paper, xPercent: 0.65, yPercent: 0.72, angleDegrees: 0, speed: 0, radius: 22)
        ]
    )

    static let level5 = LevelDefinition(
        levelNumber: 5,
        startingAmmo: 10,
        launchSpeed: 120,
        launchedRockRadius: 22,
        initialObjects: [
            InitialObjectDefinition(type: .scissors, xPercent: 0.18, yPercent: 0.72, angleDegrees: 0, speed: 120, radius: 22),
            InitialObjectDefinition(type: .paper, xPercent: 0.42, yPercent: 0.72, angleDegrees: 0, speed: 0, radius: 22),
            InitialObjectDefinition(type: .paper, xPercent: 0.72, yPercent: 0.72, angleDegrees: 0, speed: 0, radius: 22)
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
        startingAmmo: 6,
        launchSpeed: 160,
        launchedRockRadius: 20,
        initialObjects: [
            // single divider
            InitialObjectDefinition(type: .paper, xPercent: 0.22, yPercent: 0.30, angleDegrees: 25, speed: 160, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.78, yPercent: 0.34, angleDegrees: 155, speed: 160, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.24, yPercent: 0.76, angleDegrees: 335, speed: 160, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.76, yPercent: 0.82, angleDegrees: 205, speed: 160, radius: 20)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.54, widthPercent: 0.09, heightPercent: 0.34)
        ],
        introMessage: "Walls change the arena."
    )

    static let level18 = LevelDefinition(
        levelNumber: 18,
        startingAmmo: 6,
        launchSpeed: 165,
        launchedRockRadius: 20,
        initialObjects: [
            // horizontal shelf
            InitialObjectDefinition(type: .paper, xPercent: 0.18, yPercent: 0.24, angleDegrees: 15, speed: 165, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.82, yPercent: 0.30, angleDegrees: 165, speed: 165, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.20, yPercent: 0.70, angleDegrees: 345, speed: 165, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.80, yPercent: 0.80, angleDegrees: 195, speed: 165, radius: 20)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.48, widthPercent: 0.42, heightPercent: 0.06)
        ]
    )

    static let level19 = LevelDefinition(
        levelNumber: 19,
        startingAmmo: 5,
        launchSpeed: 170,
        launchedRockRadius: 20,
        initialObjects: [
            // side lanes
            InitialObjectDefinition(type: .paper, xPercent: 0.16, yPercent: 0.26, angleDegrees: 0, speed: 170, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.84, yPercent: 0.34, angleDegrees: 180, speed: 170, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.18, yPercent: 0.70, angleDegrees: 0, speed: 170, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.82, yPercent: 0.78, angleDegrees: 180, speed: 170, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.50, yPercent: 0.54, angleDegrees: 90, speed: 150, radius: 20)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.34, yPercent: 0.50, widthPercent: 0.08, heightPercent: 0.46),
            ArenaWallDefinition(xPercent: 0.66, yPercent: 0.50, widthPercent: 0.08, heightPercent: 0.46)
        ]
    )

    static let level20 = LevelDefinition(
        levelNumber: 20,
        startingAmmo: 5,
        launchSpeed: 175,
        launchedRockRadius: 20,
        initialObjects: [
            // split center gap
            InitialObjectDefinition(type: .paper, xPercent: 0.18, yPercent: 0.24, angleDegrees: 30, speed: 175, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.82, yPercent: 0.26, angleDegrees: 150, speed: 175, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.24, yPercent: 0.76, angleDegrees: 330, speed: 175, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.76, yPercent: 0.82, angleDegrees: 210, speed: 175, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.50, yPercent: 0.50, angleDegrees: 90, speed: 150, radius: 20)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.30, widthPercent: 0.08, heightPercent: 0.26),
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.76, widthPercent: 0.08, heightPercent: 0.26)
        ]
    )

    static let level21 = LevelDefinition(
        levelNumber: 21,
        startingAmmo: 5,
        launchSpeed: 180,
        launchedRockRadius: 20,
        initialObjects: [
            // L shape
            InitialObjectDefinition(type: .paper, xPercent: 0.20, yPercent: 0.22, angleDegrees: 20, speed: 180, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.80, yPercent: 0.28, angleDegrees: 160, speed: 180, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.24, yPercent: 0.72, angleDegrees: 340, speed: 180, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.74, yPercent: 0.84, angleDegrees: 200, speed: 180, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.50, yPercent: 0.58, angleDegrees: 270, speed: 140, radius: 20)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.38, yPercent: 0.50, widthPercent: 0.08, heightPercent: 0.40),
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.68, widthPercent: 0.32, heightPercent: 0.06)
        ],
        introMessage: "Walls can form gates."
    )

    static let level22 = LevelDefinition(
        levelNumber: 22,
        startingAmmo: 5,
        launchSpeed: 185,
        launchedRockRadius: 20,
        initialObjects: [
            // gate
            InitialObjectDefinition(type: .paper, xPercent: 0.16, yPercent: 0.26, angleDegrees: 5, speed: 185, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.84, yPercent: 0.30, angleDegrees: 175, speed: 185, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.18, yPercent: 0.76, angleDegrees: 355, speed: 185, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.82, yPercent: 0.82, angleDegrees: 185, speed: 185, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.50, yPercent: 0.58, angleDegrees: 90, speed: 150, radius: 20)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.40, yPercent: 0.52, widthPercent: 0.08, heightPercent: 0.50),
            ArenaWallDefinition(xPercent: 0.60, yPercent: 0.52, widthPercent: 0.08, heightPercent: 0.50)
        ]
    )

    static let level23 = LevelDefinition(
        levelNumber: 23,
        startingAmmo: 4,
        launchSpeed: 190,
        launchedRockRadius: 20,
        initialObjects: [
            // offset dividers
            InitialObjectDefinition(type: .paper, xPercent: 0.18, yPercent: 0.22, angleDegrees: 35, speed: 190, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.82, yPercent: 0.28, angleDegrees: 145, speed: 190, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.24, yPercent: 0.68, angleDegrees: 325, speed: 190, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.76, yPercent: 0.82, angleDegrees: 215, speed: 190, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.50, yPercent: 0.88, angleDegrees: 270, speed: 150, radius: 20)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.30, yPercent: 0.46, widthPercent: 0.08, heightPercent: 0.34),
            ArenaWallDefinition(xPercent: 0.70, yPercent: 0.60, widthPercent: 0.08, heightPercent: 0.34),
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.54, widthPercent: 0.28, heightPercent: 0.06)
        ]
    )

    static let level24 = LevelDefinition(
        levelNumber: 24,
        startingAmmo: 4,
        launchSpeed: 190,
        launchedRockRadius: 20,
        initialObjects: [
            // wall review
            InitialObjectDefinition(type: .paper, xPercent: 0.20, yPercent: 0.24, angleDegrees: 0, speed: 190, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.80, yPercent: 0.30, angleDegrees: 180, speed: 190, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.20, yPercent: 0.64, angleDegrees: 0, speed: 190, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.80, yPercent: 0.76, angleDegrees: 180, speed: 190, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.50, yPercent: 0.88, angleDegrees: 270, speed: 150, radius: 20)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.42, widthPercent: 0.44, heightPercent: 0.06),
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.72, widthPercent: 0.44, heightPercent: 0.06)
        ]
    )

    static let level25 = LevelDefinition(
        levelNumber: 25,
        startingAmmo: 7,
        launchSpeed: 185,
        launchedRockRadius: 20,
        initialObjects: [
            // all stationary intro
            InitialObjectDefinition(type: .paper, xPercent: 0.24, yPercent: 0.30, angleDegrees: 0, speed: 0, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.76, yPercent: 0.30, angleDegrees: 0, speed: 0, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.28, yPercent: 0.72, angleDegrees: 0, speed: 0, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.72, yPercent: 0.72, angleDegrees: 0, speed: 0, radius: 20)
        ],
        introMessage: "Objects can be stationary."
    )
    static let level26 = LevelDefinition(
        levelNumber: 26,
        startingAmmo: 6,
        launchSpeed: 190,
        launchedRockRadius: 20,
        initialObjects: [
            // stationary cross
            InitialObjectDefinition(type: .paper, xPercent: 0.22, yPercent: 0.28, angleDegrees: 0, speed: 0, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.78, yPercent: 0.32, angleDegrees: 0, speed: 0, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.50, yPercent: 0.54, angleDegrees: 0, speed: 0, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.28, yPercent: 0.80, angleDegrees: 0, speed: 0, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.72, yPercent: 0.80, angleDegrees: 0, speed: 0, radius: 20)
        ]
    )
    static let level27 = LevelDefinition(
        levelNumber: 27,
        startingAmmo: 6,
        launchSpeed: 195,
        launchedRockRadius: 20,
        initialObjects: [
            // stationary rows
            InitialObjectDefinition(type: .paper, xPercent: 0.22, yPercent: 0.24, angleDegrees: 0, speed: 0, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.50, yPercent: 0.30, angleDegrees: 0, speed: 0, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.78, yPercent: 0.24, angleDegrees: 0, speed: 0, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.32, yPercent: 0.72, angleDegrees: 0, speed: 0, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.68, yPercent: 0.72, angleDegrees: 0, speed: 0, radius: 20)
        ]
    )
    static let level28 = LevelDefinition(
        levelNumber: 28,
        startingAmmo: 4,
        launchSpeed: 200,
        launchedRockRadius: 20,
        initialObjects: [
            // two large stationary targets
            InitialObjectDefinition(type: .paper, xPercent: 0.35, yPercent: 0.64, angleDegrees: 0, speed: 0, radius: 34),
            InitialObjectDefinition(type: .scissors, xPercent: 0.65, yPercent: 0.64, angleDegrees: 0, speed: 0, radius: 34)
        ]
    )
    static let level29 = LevelDefinition(
        levelNumber: 29,
        startingAmmo: 6,
        launchSpeed: 190,
        launchedRockRadius: 15,
        initialObjects: [
            // small intro
            InitialObjectDefinition(type: .paper, xPercent: 0.20, yPercent: 0.24, angleDegrees: 25, speed: 190, radius: 15),
            InitialObjectDefinition(type: .scissors, xPercent: 0.80, yPercent: 0.30, angleDegrees: 155, speed: 190, radius: 15),
            InitialObjectDefinition(type: .paper, xPercent: 0.24, yPercent: 0.70, angleDegrees: 335, speed: 190, radius: 15),
            InitialObjectDefinition(type: .scissors, xPercent: 0.76, yPercent: 0.82, angleDegrees: 205, speed: 190, radius: 15),
            InitialObjectDefinition(type: .paper, xPercent: 0.50, yPercent: 0.54, angleDegrees: 90, speed: 190, radius: 15)
        ],
        introMessage: "Objects can be small."
    )
    static let level30 = LevelDefinition(
        levelNumber: 30,
        startingAmmo: 6,
        launchSpeed: 200,
        launchedRockRadius: 15,
        initialObjects: [
            // small lanes
            InitialObjectDefinition(type: .paper, xPercent: 0.16, yPercent: 0.24, angleDegrees: 0, speed: 200, radius: 14),
            InitialObjectDefinition(type: .scissors, xPercent: 0.84, yPercent: 0.30, angleDegrees: 180, speed: 200, radius: 14),
            InitialObjectDefinition(type: .paper, xPercent: 0.18, yPercent: 0.58, angleDegrees: 0, speed: 200, radius: 14),
            InitialObjectDefinition(type: .scissors, xPercent: 0.82, yPercent: 0.66, angleDegrees: 180, speed: 200, radius: 14),
            InitialObjectDefinition(type: .paper, xPercent: 0.50, yPercent: 0.84, angleDegrees: 270, speed: 200, radius: 14)
        ]
    )
    static let level31 = LevelDefinition(
        levelNumber: 31,
        startingAmmo: 5,
        launchSpeed: 205,
        launchedRockRadius: 14,
        initialObjects: [
            // small with divider
            InitialObjectDefinition(type: .paper, xPercent: 0.20, yPercent: 0.22, angleDegrees: 30, speed: 205, radius: 14),
            InitialObjectDefinition(type: .scissors, xPercent: 0.80, yPercent: 0.28, angleDegrees: 150, speed: 205, radius: 14),
            InitialObjectDefinition(type: .paper, xPercent: 0.24, yPercent: 0.72, angleDegrees: 330, speed: 205, radius: 14),
            InitialObjectDefinition(type: .scissors, xPercent: 0.76, yPercent: 0.84, angleDegrees: 210, speed: 205, radius: 14),
            InitialObjectDefinition(type: .scissors, xPercent: 0.62, yPercent: 0.54, angleDegrees: 90, speed: 205, radius: 14)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.52, widthPercent: 0.09, heightPercent: 0.36)
        ]
    )
    static let level32 = LevelDefinition(
        levelNumber: 32,
        startingAmmo: 5,
        launchSpeed: 210,
        launchedRockRadius: 14,
        initialObjects: [
            // small review
            InitialObjectDefinition(type: .paper, xPercent: 0.18, yPercent: 0.20, angleDegrees: 45, speed: 210, radius: 14),
            InitialObjectDefinition(type: .scissors, xPercent: 0.82, yPercent: 0.26, angleDegrees: 135, speed: 210, radius: 14),
            InitialObjectDefinition(type: .paper, xPercent: 0.22, yPercent: 0.54, angleDegrees: 315, speed: 210, radius: 14),
            InitialObjectDefinition(type: .scissors, xPercent: 0.78, yPercent: 0.64, angleDegrees: 225, speed: 210, radius: 14),
            InitialObjectDefinition(type: .paper, xPercent: 0.30, yPercent: 0.86, angleDegrees: 0, speed: 0, radius: 14),
            InitialObjectDefinition(type: .scissors, xPercent: 0.70, yPercent: 0.86, angleDegrees: 0, speed: 0, radius: 14)
        ]
    )
    static let level33 = LevelDefinition(
        levelNumber: 33,
        startingAmmo: 5,
        launchSpeed: 185,
        launchedRockRadius: 20,
        initialObjects: [
            // large intro
            InitialObjectDefinition(type: .paper, xPercent: 0.28, yPercent: 0.30, angleDegrees: 25, speed: 185, radius: 28),
            InitialObjectDefinition(type: .scissors, xPercent: 0.72, yPercent: 0.36, angleDegrees: 155, speed: 185, radius: 28),
            InitialObjectDefinition(type: .paper, xPercent: 0.30, yPercent: 0.74, angleDegrees: 335, speed: 185, radius: 28),
            InitialObjectDefinition(type: .scissors, xPercent: 0.70, yPercent: 0.80, angleDegrees: 205, speed: 185, radius: 28)
        ],
        introMessage: "Objects can be large."
    )
    static let level34 = LevelDefinition(
        levelNumber: 34,
        startingAmmo: 5,
        launchSpeed: 190,
        launchedRockRadius: 20,
        initialObjects: [
            // large horizontal lanes
            InitialObjectDefinition(type: .paper, xPercent: 0.20, yPercent: 0.28, angleDegrees: 0, speed: 190, radius: 30),
            InitialObjectDefinition(type: .scissors, xPercent: 0.80, yPercent: 0.42, angleDegrees: 180, speed: 190, radius: 30),
            InitialObjectDefinition(type: .paper, xPercent: 0.20, yPercent: 0.66, angleDegrees: 0, speed: 190, radius: 30),
            InitialObjectDefinition(type: .scissors, xPercent: 0.80, yPercent: 0.82, angleDegrees: 180, speed: 190, radius: 30)
        ]
    )
    static let level35 = LevelDefinition(
        levelNumber: 35,
        startingAmmo: 4,
        launchSpeed: 200,
        launchedRockRadius: 22,
        initialObjects: [
            // large with one wall
            InitialObjectDefinition(type: .paper, xPercent: 0.24, yPercent: 0.28, angleDegrees: 20, speed: 200, radius: 30),
            InitialObjectDefinition(type: .scissors, xPercent: 0.76, yPercent: 0.34, angleDegrees: 160, speed: 200, radius: 30),
            InitialObjectDefinition(type: .paper, xPercent: 0.28, yPercent: 0.78, angleDegrees: 340, speed: 200, radius: 30),
            InitialObjectDefinition(type: .scissors, xPercent: 0.72, yPercent: 0.84, angleDegrees: 200, speed: 200, radius: 30)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.54, widthPercent: 0.42, heightPercent: 0.06)
        ]
    )
    static let level36 = LevelDefinition(
        levelNumber: 36,
        startingAmmo: 1,
        launchSpeed: 200,
        launchedRockRadius: 44,
        initialObjects: [
            // one big launched rock
            InitialObjectDefinition(type: .paper, xPercent: 0.18, yPercent: 0.30, angleDegrees: 0, speed: 200, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.82, yPercent: 0.44, angleDegrees: 180, speed: 200, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.18, yPercent: 0.64, angleDegrees: 0, speed: 200, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.82, yPercent: 0.80, angleDegrees: 180, speed: 200, radius: 20)
        ]
    )
    static let level37 = LevelDefinition(
        levelNumber: 37,
        startingAmmo: 5,
        launchSpeed: 210,
        launchedRockRadius: 20,
        initialObjects: [
            // mixed sizes intro
            InitialObjectDefinition(type: .paper, xPercent: 0.20, yPercent: 0.24, angleDegrees: 25, speed: 210, radius: 14),
            InitialObjectDefinition(type: .scissors, xPercent: 0.80, yPercent: 0.30, angleDegrees: 155, speed: 210, radius: 26),
            InitialObjectDefinition(type: .paper, xPercent: 0.24, yPercent: 0.72, angleDegrees: 335, speed: 210, radius: 28),
            InitialObjectDefinition(type: .scissors, xPercent: 0.76, yPercent: 0.82, angleDegrees: 205, speed: 210, radius: 14)
        ],
        introMessage: "Objects can have mixed sizes."
    )
    static let level38 = LevelDefinition(
        levelNumber: 38,
        startingAmmo: 5,
        launchSpeed: 220,
        launchedRockRadius: 19,
        initialObjects: [
            // mixed size lanes
            InitialObjectDefinition(type: .paper, xPercent: 0.18, yPercent: 0.24, angleDegrees: 0, speed: 220, radius: 14),
            InitialObjectDefinition(type: .scissors, xPercent: 0.82, yPercent: 0.34, angleDegrees: 180, speed: 220, radius: 28),
            InitialObjectDefinition(type: .paper, xPercent: 0.18, yPercent: 0.62, angleDegrees: 0, speed: 220, radius: 28),
            InitialObjectDefinition(type: .scissors, xPercent: 0.82, yPercent: 0.78, angleDegrees: 180, speed: 220, radius: 14),
            InitialObjectDefinition(type: .paper, xPercent: 0.50, yPercent: 0.88, angleDegrees: 0, speed: 0, radius: 18)
        ]
    )
    static let level39 = LevelDefinition(
        levelNumber: 39,
        startingAmmo: 4,
        launchSpeed: 220,
        launchedRockRadius: 18,
        initialObjects: [
            // mixed sizes with divider
            InitialObjectDefinition(type: .paper, xPercent: 0.20, yPercent: 0.22, angleDegrees: 35, speed: 220, radius: 14),
            InitialObjectDefinition(type: .scissors, xPercent: 0.80, yPercent: 0.30, angleDegrees: 145, speed: 220, radius: 28),
            InitialObjectDefinition(type: .paper, xPercent: 0.22, yPercent: 0.74, angleDegrees: 325, speed: 220, radius: 26),
            InitialObjectDefinition(type: .scissors, xPercent: 0.78, yPercent: 0.84, angleDegrees: 215, speed: 220, radius: 14),
            InitialObjectDefinition(type: .paper, xPercent: 0.62, yPercent: 0.54, angleDegrees: 90, speed: 220, radius: 18)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.54, widthPercent: 0.10, heightPercent: 0.38)
        ]
    )
    static let level40 = LevelDefinition(
        levelNumber: 40,
        startingAmmo: 4,
        launchSpeed: 230,
        launchedRockRadius: 18,
        initialObjects: [
            // mixed size review
            InitialObjectDefinition(type: .paper, xPercent: 0.18, yPercent: 0.20, angleDegrees: 45, speed: 230, radius: 14),
            InitialObjectDefinition(type: .scissors, xPercent: 0.82, yPercent: 0.26, angleDegrees: 135, speed: 230, radius: 30),
            InitialObjectDefinition(type: .paper, xPercent: 0.24, yPercent: 0.56, angleDegrees: 315, speed: 230, radius: 24),
            InitialObjectDefinition(type: .scissors, xPercent: 0.76, yPercent: 0.68, angleDegrees: 225, speed: 230, radius: 16),
            InitialObjectDefinition(type: .paper, xPercent: 0.48, yPercent: 0.86, angleDegrees: 0, speed: 0, radius: 22)
        ]
    )
    static let level41 = LevelDefinition(
        levelNumber: 41,
        startingAmmo: 6,
        launchSpeed: 260,
        launchedRockRadius: 20,
        initialObjects: [
            // all different speeds
            InitialObjectDefinition(type: .paper, xPercent: 0.18, yPercent: 0.24, angleDegrees: 20, speed: 150, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.82, yPercent: 0.34, angleDegrees: 160, speed: 180, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.24, yPercent: 0.68, angleDegrees: 340, speed: 215, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.76, yPercent: 0.82, angleDegrees: 200, speed: 245, radius: 20)
        ],
        introMessage: "Objects can have different speeds — including launched rocks!"
    )
    static let level42 = LevelDefinition(
        levelNumber: 42,
        startingAmmo: 6,
        launchSpeed: 230,
        launchedRockRadius: 20,
        initialObjects: [
            // different-speed lanes
            InitialObjectDefinition(type: .paper, xPercent: 0.16, yPercent: 0.24, angleDegrees: 0, speed: 160, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.84, yPercent: 0.36, angleDegrees: 180, speed: 190, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.18, yPercent: 0.60, angleDegrees: 0, speed: 220, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.82, yPercent: 0.78, angleDegrees: 180, speed: 250, radius: 20)
        ]
    )
    static let level43 = LevelDefinition(
        levelNumber: 43,
        startingAmmo: 5,
        launchSpeed: 180,
        launchedRockRadius: 20,
        initialObjects: [
            // slower launched rocks
            InitialObjectDefinition(type: .paper, xPercent: 0.20, yPercent: 0.24, angleDegrees: 30, speed: 210, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.80, yPercent: 0.34, angleDegrees: 150, speed: 230, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.26, yPercent: 0.72, angleDegrees: 330, speed: 250, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.74, yPercent: 0.84, angleDegrees: 210, speed: 270, radius: 20)
        ]
    )
    static let level44 = LevelDefinition(
        levelNumber: 44,
        startingAmmo: 5,
        launchSpeed: 310,
        launchedRockRadius: 20,
        initialObjects: [
            // faster launched rocks
            InitialObjectDefinition(type: .paper, xPercent: 0.20, yPercent: 0.24, angleDegrees: 25, speed: 180, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.80, yPercent: 0.34, angleDegrees: 155, speed: 205, radius: 20),
            InitialObjectDefinition(type: .paper, xPercent: 0.24, yPercent: 0.68, angleDegrees: 335, speed: 230, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.76, yPercent: 0.82, angleDegrees: 205, speed: 255, radius: 20)
        ]
    )
    static let level45 = LevelDefinition(
        levelNumber: 45,
        startingAmmo: 3,
        launchSpeed: 205,
        launchedRockRadius: 18,
        initialObjects: [
            // low ammo intro
            InitialObjectDefinition(type: .paper, xPercent: 0.22, yPercent: 0.26, angleDegrees: 25, speed: 205, radius: 18),
            InitialObjectDefinition(type: .scissors, xPercent: 0.78, yPercent: 0.32, angleDegrees: 155, speed: 205, radius: 18),
            InitialObjectDefinition(type: .paper, xPercent: 0.26, yPercent: 0.76, angleDegrees: 335, speed: 205, radius: 18),
            InitialObjectDefinition(type: .scissors, xPercent: 0.74, yPercent: 0.82, angleDegrees: 205, speed: 205, radius: 18)
        ],
        introMessage: "Ammo can be tight."
    )

    static let level46 = LevelDefinition(
        levelNumber: 46,
        startingAmmo: 3,
        launchSpeed: 210,
        launchedRockRadius: 17,
        initialObjects: [
            // low ammo wall
            InitialObjectDefinition(type: .paper, xPercent: 0.18, yPercent: 0.24, angleDegrees: 0, speed: 210, radius: 17),
            InitialObjectDefinition(type: .scissors, xPercent: 0.82, yPercent: 0.30, angleDegrees: 180, speed: 210, radius: 17),
            InitialObjectDefinition(type: .paper, xPercent: 0.20, yPercent: 0.74, angleDegrees: 0, speed: 210, radius: 17),
            InitialObjectDefinition(type: .scissors, xPercent: 0.80, yPercent: 0.82, angleDegrees: 180, speed: 210, radius: 17),
            InitialObjectDefinition(type: .paper, xPercent: 0.62, yPercent: 0.56, angleDegrees: 90, speed: 180, radius: 17)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.48, widthPercent: 0.10, heightPercent: 0.38)
        ]
    )

    static let level47 = LevelDefinition(
        levelNumber: 47,
        startingAmmo: 3,
        launchSpeed: 220,
        launchedRockRadius: 16,
        initialObjects: [
            // low ammo small
            InitialObjectDefinition(type: .paper, xPercent: 0.20, yPercent: 0.22, angleDegrees: 30, speed: 220, radius: 15),
            InitialObjectDefinition(type: .scissors, xPercent: 0.80, yPercent: 0.28, angleDegrees: 150, speed: 220, radius: 15),
            InitialObjectDefinition(type: .paper, xPercent: 0.24, yPercent: 0.72, angleDegrees: 330, speed: 220, radius: 15),
            InitialObjectDefinition(type: .scissors, xPercent: 0.76, yPercent: 0.84, angleDegrees: 210, speed: 220, radius: 15),
            InitialObjectDefinition(type: .paper, xPercent: 0.50, yPercent: 0.52, angleDegrees: 0, speed: 0, radius: 15)
        ]
    )

    static let level48 = LevelDefinition(
        levelNumber: 48,
        startingAmmo: 2,
        launchSpeed: 210,
        launchedRockRadius: 18,
        initialObjects: [
            // low ammo review
            InitialObjectDefinition(type: .paper, xPercent: 0.24, yPercent: 0.30, angleDegrees: 20, speed: 210, radius: 18),
            InitialObjectDefinition(type: .scissors, xPercent: 0.76, yPercent: 0.36, angleDegrees: 160, speed: 210, radius: 18),
            InitialObjectDefinition(type: .paper, xPercent: 0.28, yPercent: 0.78, angleDegrees: 340, speed: 210, radius: 18),
            InitialObjectDefinition(type: .scissors, xPercent: 0.72, yPercent: 0.84, angleDegrees: 200, speed: 210, radius: 18)
        ]
    )

    static let level49 = LevelDefinition(
        levelNumber: 49,
        startingAmmo: 5,
        launchSpeed: 230,
        launchedRockRadius: 18,
        initialObjects: [
            // chaos intro
            InitialObjectDefinition(type: .paper, xPercent: 0.14, yPercent: 0.24, angleDegrees: 18, speed: 230, radius: 18),
            InitialObjectDefinition(type: .scissors, xPercent: 0.38, yPercent: 0.32, angleDegrees: 147, speed: 215, radius: 18),
            InitialObjectDefinition(type: .paper, xPercent: 0.72, yPercent: 0.24, angleDegrees: 264, speed: 225, radius: 18),
            InitialObjectDefinition(type: .scissors, xPercent: 0.84, yPercent: 0.58, angleDegrees: 201, speed: 235, radius: 18),
            InitialObjectDefinition(type: .paper, xPercent: 0.46, yPercent: 0.72, angleDegrees: 333, speed: 220, radius: 18),
            InitialObjectDefinition(type: .scissors, xPercent: 0.22, yPercent: 0.86, angleDegrees: 76, speed: 230, radius: 18)
        ],
        introMessage: "Starts can be chaotic."
    )

    static let level50 = LevelDefinition(
        levelNumber: 50,
        startingAmmo: 5,
        launchSpeed: 235,
        launchedRockRadius: 17,
        initialObjects: [
            // chaos spread
            InitialObjectDefinition(type: .paper, xPercent: 0.16, yPercent: 0.20, angleDegrees: 41, speed: 235, radius: 17),
            InitialObjectDefinition(type: .scissors, xPercent: 0.80, yPercent: 0.24, angleDegrees: 153, speed: 225, radius: 17),
            InitialObjectDefinition(type: .paper, xPercent: 0.28, yPercent: 0.46, angleDegrees: 287, speed: 240, radius: 17),
            InitialObjectDefinition(type: .scissors, xPercent: 0.62, yPercent: 0.56, angleDegrees: 205, speed: 230, radius: 17),
            InitialObjectDefinition(type: .paper, xPercent: 0.84, yPercent: 0.78, angleDegrees: 118, speed: 220, radius: 17),
            InitialObjectDefinition(type: .scissors, xPercent: 0.38, yPercent: 0.84, angleDegrees: 351, speed: 235, radius: 17)
        ]
    )

    static let level51 = LevelDefinition(
        levelNumber: 51,
        startingAmmo: 4,
        launchSpeed: 235,
        launchedRockRadius: 17,
        initialObjects: [
            // chaos gates
            InitialObjectDefinition(type: .paper, xPercent: 0.18, yPercent: 0.24, angleDegrees: 28, speed: 235, radius: 17),
            InitialObjectDefinition(type: .scissors, xPercent: 0.82, yPercent: 0.28, angleDegrees: 152, speed: 235, radius: 17),
            InitialObjectDefinition(type: .paper, xPercent: 0.22, yPercent: 0.74, angleDegrees: 316, speed: 235, radius: 17),
            InitialObjectDefinition(type: .scissors, xPercent: 0.78, yPercent: 0.82, angleDegrees: 224, speed: 235, radius: 17),
            InitialObjectDefinition(type: .paper, xPercent: 0.50, yPercent: 0.52, angleDegrees: 77, speed: 210, radius: 17),
            InitialObjectDefinition(type: .scissors, xPercent: 0.50, yPercent: 0.86, angleDegrees: 258, speed: 210, radius: 17)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.34, yPercent: 0.52, widthPercent: 0.08, heightPercent: 0.36),
            ArenaWallDefinition(xPercent: 0.66, yPercent: 0.52, widthPercent: 0.08, heightPercent: 0.36)
        ]
    )

    static let level52 = LevelDefinition(
        levelNumber: 52,
        startingAmmo: 4,
        launchSpeed: 245,
        launchedRockRadius: 16,
        initialObjects: [
            // chaos review
            InitialObjectDefinition(type: .paper, xPercent: 0.12, yPercent: 0.28, angleDegrees: 13, speed: 245, radius: 16),
            InitialObjectDefinition(type: .scissors, xPercent: 0.88, yPercent: 0.32, angleDegrees: 167, speed: 245, radius: 16),
            InitialObjectDefinition(type: .paper, xPercent: 0.20, yPercent: 0.82, angleDegrees: 347, speed: 245, radius: 16),
            InitialObjectDefinition(type: .scissors, xPercent: 0.80, yPercent: 0.78, angleDegrees: 193, speed: 245, radius: 16),
            InitialObjectDefinition(type: .paper, xPercent: 0.40, yPercent: 0.54, angleDegrees: 92, speed: 215, radius: 16),
            InitialObjectDefinition(type: .scissors, xPercent: 0.62, yPercent: 0.60, angleDegrees: 271, speed: 215, radius: 16)
        ]
    )

    static let level53 = LevelDefinition(
        levelNumber: 53,
        startingAmmo: 4,
        launchSpeed: 230,
        launchedRockRadius: 17,
        initialObjects: [
            // combined intro
            InitialObjectDefinition(type: .paper, xPercent: 0.18, yPercent: 0.24, angleDegrees: 20, speed: 230, radius: 17),
            InitialObjectDefinition(type: .scissors, xPercent: 0.82, yPercent: 0.28, angleDegrees: 160, speed: 230, radius: 17),
            InitialObjectDefinition(type: .paper, xPercent: 0.24, yPercent: 0.72, angleDegrees: 340, speed: 230, radius: 14),
            InitialObjectDefinition(type: .scissors, xPercent: 0.76, yPercent: 0.84, angleDegrees: 200, speed: 230, radius: 24),
            InitialObjectDefinition(type: .paper, xPercent: 0.50, yPercent: 0.54, angleDegrees: 0, speed: 0, radius: 17)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.46, widthPercent: 0.38, heightPercent: 0.06)
        ],
        introMessage: "Concepts can now combine."
    )

    static let level54 = LevelDefinition(
        levelNumber: 54,
        startingAmmo: 4,
        launchSpeed: 240,
        launchedRockRadius: 16,
        initialObjects: [
            // gate mix
            InitialObjectDefinition(type: .paper, xPercent: 0.16, yPercent: 0.24, angleDegrees: 0, speed: 240, radius: 14),
            InitialObjectDefinition(type: .scissors, xPercent: 0.84, yPercent: 0.30, angleDegrees: 180, speed: 240, radius: 18),
            InitialObjectDefinition(type: .paper, xPercent: 0.20, yPercent: 0.64, angleDegrees: 0, speed: 200, radius: 24),
            InitialObjectDefinition(type: .scissors, xPercent: 0.80, yPercent: 0.76, angleDegrees: 180, speed: 200, radius: 14),
            InitialObjectDefinition(type: .paper, xPercent: 0.50, yPercent: 0.88, angleDegrees: 270, speed: 220, radius: 16)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.40, yPercent: 0.52, widthPercent: 0.08, heightPercent: 0.46),
            ArenaWallDefinition(xPercent: 0.60, yPercent: 0.52, widthPercent: 0.08, heightPercent: 0.46)
        ]
    )

    static let level55 = LevelDefinition(
        levelNumber: 55,
        startingAmmo: 3,
        launchSpeed: 235,
        launchedRockRadius: 16,
        initialObjects: [
            // large wall mix
            InitialObjectDefinition(type: .paper, xPercent: 0.50, yPercent: 0.70, angleDegrees: 0, speed: 130, radius: 34),
            InitialObjectDefinition(type: .scissors, xPercent: 0.20, yPercent: 0.24, angleDegrees: 25, speed: 235, radius: 15),
            InitialObjectDefinition(type: .scissors, xPercent: 0.80, yPercent: 0.30, angleDegrees: 155, speed: 235, radius: 15),
            InitialObjectDefinition(type: .paper, xPercent: 0.24, yPercent: 0.82, angleDegrees: 335, speed: 200, radius: 16),
            InitialObjectDefinition(type: .scissors, xPercent: 0.76, yPercent: 0.84, angleDegrees: 205, speed: 200, radius: 16)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.44, widthPercent: 0.12, heightPercent: 0.28)
        ]
    )

    static let level56 = LevelDefinition(
        levelNumber: 56,
        startingAmmo: 4,
        launchSpeed: 245,
        launchedRockRadius: 15,
        initialObjects: [
            // still small mix
            InitialObjectDefinition(type: .paper, xPercent: 0.18, yPercent: 0.20, angleDegrees: 45, speed: 245, radius: 13),
            InitialObjectDefinition(type: .scissors, xPercent: 0.82, yPercent: 0.26, angleDegrees: 135, speed: 245, radius: 13),
            InitialObjectDefinition(type: .paper, xPercent: 0.22, yPercent: 0.54, angleDegrees: 315, speed: 245, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.78, yPercent: 0.64, angleDegrees: 225, speed: 245, radius: 13),
            InitialObjectDefinition(type: .paper, xPercent: 0.30, yPercent: 0.86, angleDegrees: 0, speed: 0, radius: 15),
            InitialObjectDefinition(type: .scissors, xPercent: 0.70, yPercent: 0.86, angleDegrees: 0, speed: 0, radius: 15)
        ]
    )

    static let level57 = LevelDefinition(
        levelNumber: 57,
        startingAmmo: 4,
        launchSpeed: 250,
        launchedRockRadius: 16,
        initialObjects: [
            // mixed lane
            InitialObjectDefinition(type: .paper, xPercent: 0.18, yPercent: 0.24, angleDegrees: 19, speed: 250, radius: 16),
            InitialObjectDefinition(type: .scissors, xPercent: 0.38, yPercent: 0.34, angleDegrees: 143, speed: 230, radius: 24),
            InitialObjectDefinition(type: .paper, xPercent: 0.62, yPercent: 0.52, angleDegrees: 267, speed: 210, radius: 14),
            InitialObjectDefinition(type: .scissors, xPercent: 0.82, yPercent: 0.70, angleDegrees: 209, speed: 250, radius: 16),
            InitialObjectDefinition(type: .paper, xPercent: 0.50, yPercent: 0.84, angleDegrees: 0, speed: 0, radius: 16)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.56, widthPercent: 0.36, heightPercent: 0.06)
        ]
    )

    static let level58 = LevelDefinition(
        levelNumber: 58,
        startingAmmo: 3,
        launchSpeed: 240,
        launchedRockRadius: 16,
        initialObjects: [
            // large center lanes
            InitialObjectDefinition(type: .paper, xPercent: 0.18, yPercent: 0.22, angleDegrees: 30, speed: 240, radius: 16),
            InitialObjectDefinition(type: .scissors, xPercent: 0.82, yPercent: 0.28, angleDegrees: 150, speed: 240, radius: 16),
            InitialObjectDefinition(type: .paper, xPercent: 0.24, yPercent: 0.72, angleDegrees: 330, speed: 240, radius: 16),
            InitialObjectDefinition(type: .scissors, xPercent: 0.76, yPercent: 0.84, angleDegrees: 210, speed: 240, radius: 16),
            InitialObjectDefinition(type: .paper, xPercent: 0.50, yPercent: 0.52, angleDegrees: 90, speed: 210, radius: 28)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.30, yPercent: 0.50, widthPercent: 0.08, heightPercent: 0.36),
            ArenaWallDefinition(xPercent: 0.70, yPercent: 0.62, widthPercent: 0.08, heightPercent: 0.36)
        ]
    )

    static let level59 = LevelDefinition(
        levelNumber: 59,
        startingAmmo: 3,
        launchSpeed: 250,
        launchedRockRadius: 15,
        initialObjects: [
            // fast shelf
            InitialObjectDefinition(type: .paper, xPercent: 0.16, yPercent: 0.24, angleDegrees: 0, speed: 250, radius: 15),
            InitialObjectDefinition(type: .scissors, xPercent: 0.84, yPercent: 0.30, angleDegrees: 180, speed: 250, radius: 15),
            InitialObjectDefinition(type: .paper, xPercent: 0.20, yPercent: 0.58, angleDegrees: 0, speed: 250, radius: 15),
            InitialObjectDefinition(type: .scissors, xPercent: 0.80, yPercent: 0.66, angleDegrees: 180, speed: 250, radius: 15),
            InitialObjectDefinition(type: .paper, xPercent: 0.50, yPercent: 0.84, angleDegrees: 270, speed: 220, radius: 15),
            InitialObjectDefinition(type: .scissors, xPercent: 0.50, yPercent: 0.44, angleDegrees: 90, speed: 220, radius: 15)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.50, widthPercent: 0.44, heightPercent: 0.06)
        ]
    )

    static let level60 = LevelDefinition(
        levelNumber: 60,
        startingAmmo: 3,
        launchSpeed: 255,
        launchedRockRadius: 15,
        initialObjects: [
            // combined review
            InitialObjectDefinition(type: .paper, xPercent: 0.14, yPercent: 0.26, angleDegrees: 17, speed: 255, radius: 15),
            InitialObjectDefinition(type: .scissors, xPercent: 0.86, yPercent: 0.32, angleDegrees: 163, speed: 255, radius: 15),
            InitialObjectDefinition(type: .paper, xPercent: 0.24, yPercent: 0.80, angleDegrees: 343, speed: 255, radius: 15),
            InitialObjectDefinition(type: .scissors, xPercent: 0.76, yPercent: 0.78, angleDegrees: 197, speed: 255, radius: 15),
            InitialObjectDefinition(type: .paper, xPercent: 0.44, yPercent: 0.56, angleDegrees: 91, speed: 225, radius: 22),
            InitialObjectDefinition(type: .scissors, xPercent: 0.62, yPercent: 0.60, angleDegrees: 269, speed: 225, radius: 13)
        ]
    )

    static let level61 = LevelDefinition(
        levelNumber: 61,
        startingAmmo: 4,
        launchSpeed: 220,
        launchedRockRadius: 17,
        initialObjects: [
            // rock seed intro
            InitialObjectDefinition(type: .rock, xPercent: 0.50, yPercent: 0.22, angleDegrees: 90, speed: 120, radius: 17),
            InitialObjectDefinition(type: .paper, xPercent: 0.22, yPercent: 0.32, angleDegrees: 20, speed: 220, radius: 17),
            InitialObjectDefinition(type: .scissors, xPercent: 0.78, yPercent: 0.38, angleDegrees: 160, speed: 220, radius: 17),
            InitialObjectDefinition(type: .paper, xPercent: 0.24, yPercent: 0.78, angleDegrees: 340, speed: 220, radius: 17),
            InitialObjectDefinition(type: .scissors, xPercent: 0.76, yPercent: 0.84, angleDegrees: 200, speed: 220, radius: 17)
        ],
        introMessage: "Some levels start with rocks."
    )

    static let level62 = LevelDefinition(
        levelNumber: 62,
        startingAmmo: 4,
        launchSpeed: 230,
        launchedRockRadius: 16,
        initialObjects: [
            // rock seed wall
            InitialObjectDefinition(type: .rock, xPercent: 0.18, yPercent: 0.86, angleDegrees: 0, speed: 130, radius: 16),
            InitialObjectDefinition(type: .paper, xPercent: 0.22, yPercent: 0.24, angleDegrees: 20, speed: 230, radius: 16),
            InitialObjectDefinition(type: .scissors, xPercent: 0.78, yPercent: 0.30, angleDegrees: 160, speed: 230, radius: 16),
            InitialObjectDefinition(type: .paper, xPercent: 0.28, yPercent: 0.70, angleDegrees: 340, speed: 230, radius: 16),
            InitialObjectDefinition(type: .scissors, xPercent: 0.74, yPercent: 0.78, angleDegrees: 200, speed: 230, radius: 16)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.52, widthPercent: 0.10, heightPercent: 0.36)
        ]
    )

    static let level63 = LevelDefinition(
        levelNumber: 63,
        startingAmmo: 3,
        launchSpeed: 235,
        launchedRockRadius: 16,
        initialObjects: [
            // rock mixed sizes
            InitialObjectDefinition(type: .rock, xPercent: 0.82, yPercent: 0.86, angleDegrees: 180, speed: 120, radius: 16),
            InitialObjectDefinition(type: .paper, xPercent: 0.18, yPercent: 0.22, angleDegrees: 35, speed: 235, radius: 14),
            InitialObjectDefinition(type: .scissors, xPercent: 0.82, yPercent: 0.28, angleDegrees: 145, speed: 235, radius: 22),
            InitialObjectDefinition(type: .paper, xPercent: 0.24, yPercent: 0.72, angleDegrees: 325, speed: 235, radius: 14),
            InitialObjectDefinition(type: .scissors, xPercent: 0.76, yPercent: 0.82, angleDegrees: 215, speed: 235, radius: 22)
        ]
    )

    static let level64 = LevelDefinition(
        levelNumber: 64,
        startingAmmo: 3,
        launchSpeed: 240,
        launchedRockRadius: 15,
        initialObjects: [
            // rock seed review
            InitialObjectDefinition(type: .rock, xPercent: 0.50, yPercent: 0.50, angleDegrees: 90, speed: 120, radius: 15),
            InitialObjectDefinition(type: .paper, xPercent: 0.18, yPercent: 0.24, angleDegrees: 0, speed: 240, radius: 15),
            InitialObjectDefinition(type: .scissors, xPercent: 0.82, yPercent: 0.30, angleDegrees: 180, speed: 240, radius: 15),
            InitialObjectDefinition(type: .paper, xPercent: 0.20, yPercent: 0.72, angleDegrees: 0, speed: 240, radius: 15),
            InitialObjectDefinition(type: .scissors, xPercent: 0.80, yPercent: 0.82, angleDegrees: 180, speed: 240, radius: 15),
            InitialObjectDefinition(type: .paper, xPercent: 0.50, yPercent: 0.86, angleDegrees: 0, speed: 0, radius: 15)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.40, yPercent: 0.52, widthPercent: 0.08, heightPercent: 0.42),
            ArenaWallDefinition(xPercent: 0.60, yPercent: 0.52, widthPercent: 0.08, heightPercent: 0.42)
        ]
    )

    static let level65 = LevelDefinition(
        levelNumber: 65,
        startingAmmo: 3,
        launchSpeed: 230,
        launchedRockRadius: 15,
        initialObjects: [
            // still wall intro
            InitialObjectDefinition(type: .paper, xPercent: 0.20, yPercent: 0.24, angleDegrees: 0, speed: 0, radius: 14),
            InitialObjectDefinition(type: .scissors, xPercent: 0.80, yPercent: 0.30, angleDegrees: 0, speed: 0, radius: 14),
            InitialObjectDefinition(type: .paper, xPercent: 0.24, yPercent: 0.76, angleDegrees: 0, speed: 0, radius: 14),
            InitialObjectDefinition(type: .scissors, xPercent: 0.76, yPercent: 0.82, angleDegrees: 0, speed: 0, radius: 14),
            InitialObjectDefinition(type: .paper, xPercent: 0.50, yPercent: 0.50, angleDegrees: 91, speed: 230, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.50, yPercent: 0.66, angleDegrees: 269, speed: 230, radius: 14)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.42, widthPercent: 0.34, heightPercent: 0.06)
        ],
        introMessage: "Stationary objects and walls can mix."
    )

    static let level66 = LevelDefinition(
        levelNumber: 66,
        startingAmmo: 3,
        launchSpeed: 245,
        launchedRockRadius: 15,
        initialObjects: [
            // small still gate
            InitialObjectDefinition(type: .paper, xPercent: 0.18, yPercent: 0.22, angleDegrees: 30, speed: 245, radius: 13),
            InitialObjectDefinition(type: .scissors, xPercent: 0.82, yPercent: 0.28, angleDegrees: 150, speed: 245, radius: 13),
            InitialObjectDefinition(type: .paper, xPercent: 0.26, yPercent: 0.72, angleDegrees: 0, speed: 0, radius: 22),
            InitialObjectDefinition(type: .scissors, xPercent: 0.74, yPercent: 0.84, angleDegrees: 0, speed: 0, radius: 13),
            InitialObjectDefinition(type: .paper, xPercent: 0.50, yPercent: 0.54, angleDegrees: 90, speed: 220, radius: 13)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.34, yPercent: 0.54, widthPercent: 0.08, heightPercent: 0.38),
            ArenaWallDefinition(xPercent: 0.66, yPercent: 0.54, widthPercent: 0.08, heightPercent: 0.38)
        ]
    )

    static let level67 = LevelDefinition(
        levelNumber: 67,
        startingAmmo: 3,
        launchSpeed: 245,
        launchedRockRadius: 15,
        initialObjects: [
            // large still mix
            InitialObjectDefinition(type: .paper, xPercent: 0.50, yPercent: 0.70, angleDegrees: 0, speed: 110, radius: 32),
            InitialObjectDefinition(type: .scissors, xPercent: 0.22, yPercent: 0.26, angleDegrees: 25, speed: 245, radius: 14),
            InitialObjectDefinition(type: .scissors, xPercent: 0.78, yPercent: 0.32, angleDegrees: 155, speed: 245, radius: 14),
            InitialObjectDefinition(type: .paper, xPercent: 0.24, yPercent: 0.84, angleDegrees: 0, speed: 0, radius: 14),
            InitialObjectDefinition(type: .scissors, xPercent: 0.76, yPercent: 0.84, angleDegrees: 0, speed: 0, radius: 14)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.48, widthPercent: 0.12, heightPercent: 0.32)
        ]
    )

    static let level68 = LevelDefinition(
        levelNumber: 68,
        startingAmmo: 2,
        launchSpeed: 235,
        launchedRockRadius: 15,
        initialObjects: [
            // advanced review
            InitialObjectDefinition(type: .paper, xPercent: 0.20, yPercent: 0.24, angleDegrees: 0, speed: 235, radius: 15),
            InitialObjectDefinition(type: .scissors, xPercent: 0.80, yPercent: 0.32, angleDegrees: 180, speed: 235, radius: 15),
            InitialObjectDefinition(type: .paper, xPercent: 0.24, yPercent: 0.76, angleDegrees: 0, speed: 0, radius: 15),
            InitialObjectDefinition(type: .scissors, xPercent: 0.76, yPercent: 0.84, angleDegrees: 0, speed: 0, radius: 15),
            InitialObjectDefinition(type: .rock, xPercent: 0.50, yPercent: 0.52, angleDegrees: 90, speed: 110, radius: 15)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.44, widthPercent: 0.36, heightPercent: 0.06),
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.70, widthPercent: 0.36, heightPercent: 0.06)
        ]
    )

    static let level69 = LevelDefinition(
        levelNumber: 69,
        startingAmmo: 3,
        launchSpeed: 230,
        launchedRockRadius: 15,
        initialObjects: [
            // maze intro
            InitialObjectDefinition(type: .paper, xPercent: 0.16, yPercent: 0.24, angleDegrees: 0, speed: 230, radius: 15),
            InitialObjectDefinition(type: .scissors, xPercent: 0.84, yPercent: 0.30, angleDegrees: 180, speed: 230, radius: 15),
            InitialObjectDefinition(type: .paper, xPercent: 0.20, yPercent: 0.74, angleDegrees: 0, speed: 230, radius: 15),
            InitialObjectDefinition(type: .scissors, xPercent: 0.80, yPercent: 0.82, angleDegrees: 180, speed: 230, radius: 15),
            InitialObjectDefinition(type: .paper, xPercent: 0.50, yPercent: 0.54, angleDegrees: 90, speed: 210, radius: 15)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.30, yPercent: 0.42, widthPercent: 0.08, heightPercent: 0.32),
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.62, widthPercent: 0.32, heightPercent: 0.06),
            ArenaWallDefinition(xPercent: 0.70, yPercent: 0.42, widthPercent: 0.08, heightPercent: 0.32)
        ],
        introMessage: "Walls can form mazes."
    )

    static let level70 = LevelDefinition(
        levelNumber: 70,
        startingAmmo: 3,
        launchSpeed: 240,
        launchedRockRadius: 15,
        initialObjects: [
            // double gate maze
            InitialObjectDefinition(type: .paper, xPercent: 0.18, yPercent: 0.22, angleDegrees: 30, speed: 240, radius: 15),
            InitialObjectDefinition(type: .scissors, xPercent: 0.82, yPercent: 0.28, angleDegrees: 150, speed: 240, radius: 15),
            InitialObjectDefinition(type: .paper, xPercent: 0.24, yPercent: 0.72, angleDegrees: 330, speed: 240, radius: 15),
            InitialObjectDefinition(type: .scissors, xPercent: 0.76, yPercent: 0.84, angleDegrees: 210, speed: 240, radius: 15),
            InitialObjectDefinition(type: .scissors, xPercent: 0.50, yPercent: 0.52, angleDegrees: 90, speed: 210, radius: 15)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.36, yPercent: 0.52, widthPercent: 0.08, heightPercent: 0.48),
            ArenaWallDefinition(xPercent: 0.64, yPercent: 0.52, widthPercent: 0.08, heightPercent: 0.48),
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.76, widthPercent: 0.30, heightPercent: 0.06)
        ]
    )

    static let level71 = LevelDefinition(
        levelNumber: 71,
        startingAmmo: 3,
        launchSpeed: 250,
        launchedRockRadius: 14,
        initialObjects: [
            // offset maze
            InitialObjectDefinition(type: .paper, xPercent: 0.16, yPercent: 0.20, angleDegrees: 45, speed: 250, radius: 14),
            InitialObjectDefinition(type: .scissors, xPercent: 0.84, yPercent: 0.26, angleDegrees: 135, speed: 250, radius: 14),
            InitialObjectDefinition(type: .paper, xPercent: 0.22, yPercent: 0.54, angleDegrees: 315, speed: 250, radius: 14),
            InitialObjectDefinition(type: .scissors, xPercent: 0.78, yPercent: 0.64, angleDegrees: 225, speed: 250, radius: 14),
            InitialObjectDefinition(type: .paper, xPercent: 0.50, yPercent: 0.86, angleDegrees: 0, speed: 0, radius: 14)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.28, yPercent: 0.58, widthPercent: 0.08, heightPercent: 0.34),
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.40, widthPercent: 0.34, heightPercent: 0.06),
            ArenaWallDefinition(xPercent: 0.72, yPercent: 0.62, widthPercent: 0.08, heightPercent: 0.34)
        ]
    )

    static let level72 = LevelDefinition(
        levelNumber: 72,
        startingAmmo: 2,
        launchSpeed: 250,
        launchedRockRadius: 14,
        initialObjects: [
            // narrow gates
            InitialObjectDefinition(type: .paper, xPercent: 0.20, yPercent: 0.24, angleDegrees: 0, speed: 250, radius: 14),
            InitialObjectDefinition(type: .scissors, xPercent: 0.80, yPercent: 0.30, angleDegrees: 180, speed: 250, radius: 14),
            InitialObjectDefinition(type: .paper, xPercent: 0.24, yPercent: 0.76, angleDegrees: 0, speed: 250, radius: 14),
            InitialObjectDefinition(type: .scissors, xPercent: 0.76, yPercent: 0.82, angleDegrees: 180, speed: 250, radius: 14),
            InitialObjectDefinition(type: .rock, xPercent: 0.50, yPercent: 0.22, angleDegrees: 90, speed: 120, radius: 14)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.42, yPercent: 0.50, widthPercent: 0.08, heightPercent: 0.50),
            ArenaWallDefinition(xPercent: 0.58, yPercent: 0.50, widthPercent: 0.08, heightPercent: 0.50)
        ]
    )

    static let level73 = LevelDefinition(
        levelNumber: 73,
        startingAmmo: 3,
        launchSpeed: 245,
        launchedRockRadius: 14,
        initialObjects: [
            // maze plus large
            InitialObjectDefinition(type: .paper, xPercent: 0.18, yPercent: 0.22, angleDegrees: 30, speed: 245, radius: 14),
            InitialObjectDefinition(type: .scissors, xPercent: 0.82, yPercent: 0.28, angleDegrees: 150, speed: 245, radius: 18),
            InitialObjectDefinition(type: .paper, xPercent: 0.24, yPercent: 0.72, angleDegrees: 330, speed: 245, radius: 14),
            InitialObjectDefinition(type: .scissors, xPercent: 0.76, yPercent: 0.84, angleDegrees: 210, speed: 245, radius: 18),
            InitialObjectDefinition(type: .paper, xPercent: 0.50, yPercent: 0.52, angleDegrees: 0, speed: 0, radius: 22)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.38, widthPercent: 0.42, heightPercent: 0.06),
            ArenaWallDefinition(xPercent: 0.34, yPercent: 0.64, widthPercent: 0.08, heightPercent: 0.30),
            ArenaWallDefinition(xPercent: 0.66, yPercent: 0.64, widthPercent: 0.08, heightPercent: 0.30)
        ]
    )

    static let level74 = LevelDefinition(
        levelNumber: 74,
        startingAmmo: 3,
        launchSpeed: 255,
        launchedRockRadius: 14,
        initialObjects: [
            // maze chaos
            InitialObjectDefinition(type: .paper, xPercent: 0.14, yPercent: 0.26, angleDegrees: 17, speed: 255, radius: 14),
            InitialObjectDefinition(type: .scissors, xPercent: 0.86, yPercent: 0.32, angleDegrees: 163, speed: 255, radius: 14),
            InitialObjectDefinition(type: .paper, xPercent: 0.24, yPercent: 0.80, angleDegrees: 343, speed: 255, radius: 14),
            InitialObjectDefinition(type: .scissors, xPercent: 0.76, yPercent: 0.78, angleDegrees: 197, speed: 255, radius: 14),
            InitialObjectDefinition(type: .paper, xPercent: 0.44, yPercent: 0.56, angleDegrees: 91, speed: 225, radius: 14),
            InitialObjectDefinition(type: .scissors, xPercent: 0.62, yPercent: 0.60, angleDegrees: 269, speed: 225, radius: 14)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.48, widthPercent: 0.44, heightPercent: 0.06),
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.76, widthPercent: 0.44, heightPercent: 0.06)
        ]
    )

    static let level75 = LevelDefinition(
        levelNumber: 75,
        startingAmmo: 2,
        launchSpeed: 260,
        launchedRockRadius: 14,
        initialObjects: [
            // low ammo maze
            InitialObjectDefinition(type: .paper, xPercent: 0.18, yPercent: 0.24, angleDegrees: 0, speed: 260, radius: 14),
            InitialObjectDefinition(type: .scissors, xPercent: 0.82, yPercent: 0.30, angleDegrees: 180, speed: 260, radius: 14),
            InitialObjectDefinition(type: .paper, xPercent: 0.20, yPercent: 0.64, angleDegrees: 0, speed: 220, radius: 22),
            InitialObjectDefinition(type: .scissors, xPercent: 0.80, yPercent: 0.76, angleDegrees: 180, speed: 220, radius: 14),
            InitialObjectDefinition(type: .rock, xPercent: 0.50, yPercent: 0.86, angleDegrees: 270, speed: 110, radius: 14)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.32, yPercent: 0.52, widthPercent: 0.08, heightPercent: 0.40),
            ArenaWallDefinition(xPercent: 0.68, yPercent: 0.52, widthPercent: 0.08, heightPercent: 0.40),
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.58, widthPercent: 0.24, heightPercent: 0.06)
        ]
    )

    static let level76 = LevelDefinition(
        levelNumber: 76,
        startingAmmo: 3,
        launchSpeed: 260,
        launchedRockRadius: 13,
        initialObjects: [
            // maze review
            InitialObjectDefinition(type: .paper, xPercent: 0.16, yPercent: 0.22, angleDegrees: 45, speed: 260, radius: 13),
            InitialObjectDefinition(type: .scissors, xPercent: 0.84, yPercent: 0.28, angleDegrees: 135, speed: 260, radius: 13),
            InitialObjectDefinition(type: .paper, xPercent: 0.22, yPercent: 0.58, angleDegrees: 315, speed: 260, radius: 13),
            InitialObjectDefinition(type: .scissors, xPercent: 0.78, yPercent: 0.68, angleDegrees: 225, speed: 260, radius: 13),
            InitialObjectDefinition(type: .paper, xPercent: 0.36, yPercent: 0.86, angleDegrees: 0, speed: 0, radius: 13),
            InitialObjectDefinition(type: .scissors, xPercent: 0.64, yPercent: 0.86, angleDegrees: 0, speed: 0, radius: 13)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.30, yPercent: 0.48, widthPercent: 0.08, heightPercent: 0.34),
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.64, widthPercent: 0.34, heightPercent: 0.06),
            ArenaWallDefinition(xPercent: 0.70, yPercent: 0.48, widthPercent: 0.08, heightPercent: 0.34)
        ]
    )

    static let level77 = LevelDefinition(
        levelNumber: 77,
        startingAmmo: 4,
        launchSpeed: 250,
        launchedRockRadius: 14,
        initialObjects: [
            // crowded intro
            InitialObjectDefinition(type: .paper, xPercent: 0.12, yPercent: 0.22, angleDegrees: 20, speed: 250, radius: 14),
            InitialObjectDefinition(type: .scissors, xPercent: 0.32, yPercent: 0.30, angleDegrees: 160, speed: 250, radius: 14),
            InitialObjectDefinition(type: .paper, xPercent: 0.52, yPercent: 0.22, angleDegrees: 340, speed: 250, radius: 14),
            InitialObjectDefinition(type: .scissors, xPercent: 0.72, yPercent: 0.30, angleDegrees: 200, speed: 250, radius: 14),
            InitialObjectDefinition(type: .paper, xPercent: 0.88, yPercent: 0.54, angleDegrees: 120, speed: 230, radius: 14),
            InitialObjectDefinition(type: .scissors, xPercent: 0.20, yPercent: 0.78, angleDegrees: 300, speed: 230, radius: 14),
            InitialObjectDefinition(type: .paper, xPercent: 0.50, yPercent: 0.86, angleDegrees: 0, speed: 0, radius: 14)
        ],
        introMessage: "Boards can get crowded."
    )

    static let level78 = LevelDefinition(
        levelNumber: 78,
        startingAmmo: 4,
        launchSpeed: 255,
        launchedRockRadius: 14,
        initialObjects: [
            // crowded shelf
            InitialObjectDefinition(type: .paper, xPercent: 0.16, yPercent: 0.20, angleDegrees: 35, speed: 255, radius: 13),
            InitialObjectDefinition(type: .scissors, xPercent: 0.36, yPercent: 0.30, angleDegrees: 145, speed: 255, radius: 13),
            InitialObjectDefinition(type: .paper, xPercent: 0.58, yPercent: 0.42, angleDegrees: 325, speed: 255, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.80, yPercent: 0.56, angleDegrees: 215, speed: 255, radius: 13),
            InitialObjectDefinition(type: .paper, xPercent: 0.26, yPercent: 0.72, angleDegrees: 95, speed: 230, radius: 13),
            InitialObjectDefinition(type: .scissors, xPercent: 0.70, yPercent: 0.84, angleDegrees: 265, speed: 230, radius: 20)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.54, widthPercent: 0.38, heightPercent: 0.06)
        ]
    )

    static let level79 = LevelDefinition(
        levelNumber: 79,
        startingAmmo: 3,
        launchSpeed: 265,
        launchedRockRadius: 13,
        initialObjects: [
            // crowded seed
            InitialObjectDefinition(type: .paper, xPercent: 0.14, yPercent: 0.24, angleDegrees: 0, speed: 265, radius: 13),
            InitialObjectDefinition(type: .scissors, xPercent: 0.34, yPercent: 0.34, angleDegrees: 180, speed: 265, radius: 13),
            InitialObjectDefinition(type: .paper, xPercent: 0.54, yPercent: 0.44, angleDegrees: 0, speed: 265, radius: 13),
            InitialObjectDefinition(type: .scissors, xPercent: 0.74, yPercent: 0.54, angleDegrees: 180, speed: 265, radius: 13),
            InitialObjectDefinition(type: .paper, xPercent: 0.24, yPercent: 0.78, angleDegrees: 0, speed: 230, radius: 22),
            InitialObjectDefinition(type: .scissors, xPercent: 0.80, yPercent: 0.84, angleDegrees: 180, speed: 230, radius: 13),
            InitialObjectDefinition(type: .rock, xPercent: 0.50, yPercent: 0.22, angleDegrees: 90, speed: 120, radius: 13)
        ]
    )

    static let level80 = LevelDefinition(
        levelNumber: 80,
        startingAmmo: 3,
        launchSpeed: 270,
        launchedRockRadius: 13,
        initialObjects: [
            // crowded gate
            InitialObjectDefinition(type: .paper, xPercent: 0.16, yPercent: 0.24, angleDegrees: 20, speed: 270, radius: 13),
            InitialObjectDefinition(type: .scissors, xPercent: 0.84, yPercent: 0.30, angleDegrees: 160, speed: 270, radius: 13),
            InitialObjectDefinition(type: .paper, xPercent: 0.20, yPercent: 0.58, angleDegrees: 340, speed: 240, radius: 13),
            InitialObjectDefinition(type: .scissors, xPercent: 0.80, yPercent: 0.66, angleDegrees: 200, speed: 240, radius: 13),
            InitialObjectDefinition(type: .paper, xPercent: 0.30, yPercent: 0.86, angleDegrees: 0, speed: 0, radius: 13),
            InitialObjectDefinition(type: .scissors, xPercent: 0.70, yPercent: 0.86, angleDegrees: 0, speed: 0, radius: 13),
            InitialObjectDefinition(type: .paper, xPercent: 0.50, yPercent: 0.48, angleDegrees: 90, speed: 220, radius: 20)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.40, yPercent: 0.54, widthPercent: 0.08, heightPercent: 0.46),
            ArenaWallDefinition(xPercent: 0.60, yPercent: 0.54, widthPercent: 0.08, heightPercent: 0.46)
        ]
    )

    static let level81 = LevelDefinition(
        levelNumber: 81,
        startingAmmo: 3,
        launchSpeed: 275,
        launchedRockRadius: 13,
        initialObjects: [
            // crowded random
            InitialObjectDefinition(type: .paper, xPercent: 0.12, yPercent: 0.24, angleDegrees: 31, speed: 275, radius: 13),
            InitialObjectDefinition(type: .scissors, xPercent: 0.28, yPercent: 0.36, angleDegrees: 149, speed: 275, radius: 13),
            InitialObjectDefinition(type: .paper, xPercent: 0.48, yPercent: 0.28, angleDegrees: 287, speed: 255, radius: 13),
            InitialObjectDefinition(type: .scissors, xPercent: 0.68, yPercent: 0.52, angleDegrees: 205, speed: 255, radius: 13),
            InitialObjectDefinition(type: .paper, xPercent: 0.86, yPercent: 0.76, angleDegrees: 118, speed: 235, radius: 13),
            InitialObjectDefinition(type: .scissors, xPercent: 0.38, yPercent: 0.84, angleDegrees: 351, speed: 235, radius: 13),
            InitialObjectDefinition(type: .rock, xPercent: 0.50, yPercent: 0.62, angleDegrees: 90, speed: 110, radius: 13)
        ]
    )

    static let level82 = LevelDefinition(
        levelNumber: 82,
        startingAmmo: 3,
        launchSpeed: 270,
        launchedRockRadius: 13,
        initialObjects: [
            // crowded sizes
            InitialObjectDefinition(type: .paper, xPercent: 0.18, yPercent: 0.20, angleDegrees: 45, speed: 270, radius: 12),
            InitialObjectDefinition(type: .scissors, xPercent: 0.82, yPercent: 0.26, angleDegrees: 135, speed: 270, radius: 12),
            InitialObjectDefinition(type: .paper, xPercent: 0.22, yPercent: 0.54, angleDegrees: 315, speed: 270, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.78, yPercent: 0.64, angleDegrees: 225, speed: 270, radius: 12),
            InitialObjectDefinition(type: .paper, xPercent: 0.30, yPercent: 0.86, angleDegrees: 0, speed: 0, radius: 12),
            InitialObjectDefinition(type: .scissors, xPercent: 0.70, yPercent: 0.86, angleDegrees: 0, speed: 0, radius: 20)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.30, yPercent: 0.48, widthPercent: 0.08, heightPercent: 0.34),
            ArenaWallDefinition(xPercent: 0.70, yPercent: 0.62, widthPercent: 0.08, heightPercent: 0.34)
        ]
    )

    static let level83 = LevelDefinition(
        levelNumber: 83,
        startingAmmo: 2,
        launchSpeed: 270,
        launchedRockRadius: 13,
        initialObjects: [
            // crowded low ammo
            InitialObjectDefinition(type: .paper, xPercent: 0.16, yPercent: 0.24, angleDegrees: 0, speed: 270, radius: 13),
            InitialObjectDefinition(type: .scissors, xPercent: 0.84, yPercent: 0.30, angleDegrees: 180, speed: 270, radius: 13),
            InitialObjectDefinition(type: .paper, xPercent: 0.20, yPercent: 0.72, angleDegrees: 0, speed: 270, radius: 13),
            InitialObjectDefinition(type: .scissors, xPercent: 0.80, yPercent: 0.82, angleDegrees: 180, speed: 270, radius: 13),
            InitialObjectDefinition(type: .paper, xPercent: 0.50, yPercent: 0.54, angleDegrees: 0, speed: 0, radius: 13),
            InitialObjectDefinition(type: .scissors, xPercent: 0.50, yPercent: 0.86, angleDegrees: 0, speed: 0, radius: 13)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.42, widthPercent: 0.34, heightPercent: 0.06),
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.70, widthPercent: 0.34, heightPercent: 0.06)
        ]
    )

    static let level84 = LevelDefinition(
        levelNumber: 84,
        startingAmmo: 3,
        launchSpeed: 280,
        launchedRockRadius: 12,
        initialObjects: [
            // crowded review
            InitialObjectDefinition(type: .paper, xPercent: 0.14, yPercent: 0.26, angleDegrees: 17, speed: 280, radius: 12),
            InitialObjectDefinition(type: .scissors, xPercent: 0.86, yPercent: 0.32, angleDegrees: 163, speed: 280, radius: 12),
            InitialObjectDefinition(type: .paper, xPercent: 0.24, yPercent: 0.80, angleDegrees: 343, speed: 280, radius: 12),
            InitialObjectDefinition(type: .scissors, xPercent: 0.76, yPercent: 0.78, angleDegrees: 197, speed: 280, radius: 12),
            InitialObjectDefinition(type: .paper, xPercent: 0.44, yPercent: 0.56, angleDegrees: 91, speed: 240, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.62, yPercent: 0.60, angleDegrees: 269, speed: 240, radius: 12),
            InitialObjectDefinition(type: .rock, xPercent: 0.50, yPercent: 0.22, angleDegrees: 90, speed: 120, radius: 12)
        ]
    )

    static let level85 = LevelDefinition(
        levelNumber: 85,
        startingAmmo: 3,
        launchSpeed: 270,
        launchedRockRadius: 13,
        initialObjects: [
            // gauntlet intro
            InitialObjectDefinition(type: .paper, xPercent: 0.18, yPercent: 0.22, angleDegrees: 30, speed: 270, radius: 13),
            InitialObjectDefinition(type: .scissors, xPercent: 0.82, yPercent: 0.28, angleDegrees: 150, speed: 270, radius: 13),
            InitialObjectDefinition(type: .paper, xPercent: 0.24, yPercent: 0.72, angleDegrees: 330, speed: 250, radius: 22),
            InitialObjectDefinition(type: .scissors, xPercent: 0.76, yPercent: 0.84, angleDegrees: 210, speed: 270, radius: 13),
            InitialObjectDefinition(type: .paper, xPercent: 0.50, yPercent: 0.52, angleDegrees: 0, speed: 0, radius: 13),
            InitialObjectDefinition(type: .rock, xPercent: 0.50, yPercent: 0.86, angleDegrees: 270, speed: 120, radius: 13)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.34, yPercent: 0.52, widthPercent: 0.08, heightPercent: 0.42),
            ArenaWallDefinition(xPercent: 0.66, yPercent: 0.52, widthPercent: 0.08, heightPercent: 0.42)
        ],
        introMessage: "Gauntlets combine everything."
    )

    static let level86 = LevelDefinition(
        levelNumber: 86,
        startingAmmo: 3,
        launchSpeed: 280,
        launchedRockRadius: 12,
        initialObjects: [
            // gauntlet maze
            InitialObjectDefinition(type: .paper, xPercent: 0.16, yPercent: 0.22, angleDegrees: 45, speed: 280, radius: 12),
            InitialObjectDefinition(type: .scissors, xPercent: 0.84, yPercent: 0.28, angleDegrees: 135, speed: 280, radius: 12),
            InitialObjectDefinition(type: .paper, xPercent: 0.22, yPercent: 0.58, angleDegrees: 315, speed: 280, radius: 12),
            InitialObjectDefinition(type: .scissors, xPercent: 0.78, yPercent: 0.68, angleDegrees: 225, speed: 280, radius: 12),
            InitialObjectDefinition(type: .paper, xPercent: 0.36, yPercent: 0.86, angleDegrees: 0, speed: 0, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.64, yPercent: 0.86, angleDegrees: 0, speed: 0, radius: 12)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.40, widthPercent: 0.44, heightPercent: 0.06),
            ArenaWallDefinition(xPercent: 0.30, yPercent: 0.66, widthPercent: 0.08, heightPercent: 0.30),
            ArenaWallDefinition(xPercent: 0.70, yPercent: 0.66, widthPercent: 0.08, heightPercent: 0.30)
        ]
    )

    static let level87 = LevelDefinition(
        levelNumber: 87,
        startingAmmo: 2,
        launchSpeed: 120,
        launchedRockRadius: 13,
        initialObjects: [
            // large gauntlet
            InitialObjectDefinition(type: .paper, xPercent: 0.50, yPercent: 0.70, angleDegrees: 0, speed: 120, radius: 34),
            InitialObjectDefinition(type: .scissors, xPercent: 0.18, yPercent: 0.24, angleDegrees: 25, speed: 280, radius: 12),
            InitialObjectDefinition(type: .scissors, xPercent: 0.82, yPercent: 0.30, angleDegrees: 155, speed: 280, radius: 12),
            InitialObjectDefinition(type: .paper, xPercent: 0.24, yPercent: 0.84, angleDegrees: 335, speed: 240, radius: 13),
            InitialObjectDefinition(type: .scissors, xPercent: 0.76, yPercent: 0.84, angleDegrees: 205, speed: 240, radius: 13),
            InitialObjectDefinition(type: .rock, xPercent: 0.50, yPercent: 0.24, angleDegrees: 90, speed: 120, radius: 13)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.48, widthPercent: 0.12, heightPercent: 0.30)
        ]
    )

    static let level88 = LevelDefinition(
        levelNumber: 88,
        startingAmmo: 3,
        launchSpeed: 285,
        launchedRockRadius: 12,
        initialObjects: [
            // chaos gauntlet
            InitialObjectDefinition(type: .paper, xPercent: 0.12, yPercent: 0.24, angleDegrees: 18, speed: 285, radius: 12),
            InitialObjectDefinition(type: .scissors, xPercent: 0.38, yPercent: 0.32, angleDegrees: 147, speed: 265, radius: 12),
            InitialObjectDefinition(type: .paper, xPercent: 0.72, yPercent: 0.24, angleDegrees: 264, speed: 275, radius: 12),
            InitialObjectDefinition(type: .scissors, xPercent: 0.84, yPercent: 0.58, angleDegrees: 201, speed: 285, radius: 12),
            InitialObjectDefinition(type: .paper, xPercent: 0.46, yPercent: 0.72, angleDegrees: 333, speed: 260, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.22, yPercent: 0.86, angleDegrees: 76, speed: 275, radius: 12)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.56, widthPercent: 0.38, heightPercent: 0.06)
        ]
    )

    static let level89 = LevelDefinition(
        levelNumber: 89,
        startingAmmo: 3,
        launchSpeed: 285,
        launchedRockRadius: 12,
        initialObjects: [
            // gate gauntlet
            InitialObjectDefinition(type: .paper, xPercent: 0.16, yPercent: 0.24, angleDegrees: 0, speed: 285, radius: 12),
            InitialObjectDefinition(type: .scissors, xPercent: 0.84, yPercent: 0.30, angleDegrees: 180, speed: 285, radius: 12),
            InitialObjectDefinition(type: .paper, xPercent: 0.20, yPercent: 0.58, angleDegrees: 0, speed: 245, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.80, yPercent: 0.66, angleDegrees: 180, speed: 285, radius: 12),
            InitialObjectDefinition(type: .paper, xPercent: 0.30, yPercent: 0.86, angleDegrees: 0, speed: 0, radius: 12),
            InitialObjectDefinition(type: .scissors, xPercent: 0.70, yPercent: 0.86, angleDegrees: 0, speed: 0, radius: 12),
            InitialObjectDefinition(type: .rock, xPercent: 0.50, yPercent: 0.50, angleDegrees: 90, speed: 110, radius: 12)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.40, yPercent: 0.52, widthPercent: 0.08, heightPercent: 0.46),
            ArenaWallDefinition(xPercent: 0.60, yPercent: 0.52, widthPercent: 0.08, heightPercent: 0.46)
        ]
    )

    static let level90 = LevelDefinition(
        levelNumber: 90,
        startingAmmo: 2,
        launchSpeed: 290,
        launchedRockRadius: 12,
        initialObjects: [
            // low ammo gauntlet
            InitialObjectDefinition(type: .paper, xPercent: 0.18, yPercent: 0.20, angleDegrees: 45, speed: 290, radius: 12),
            InitialObjectDefinition(type: .scissors, xPercent: 0.82, yPercent: 0.26, angleDegrees: 135, speed: 290, radius: 12),
            InitialObjectDefinition(type: .paper, xPercent: 0.22, yPercent: 0.54, angleDegrees: 315, speed: 290, radius: 12),
            InitialObjectDefinition(type: .scissors, xPercent: 0.78, yPercent: 0.64, angleDegrees: 225, speed: 290, radius: 12),
            InitialObjectDefinition(type: .paper, xPercent: 0.30, yPercent: 0.86, angleDegrees: 0, speed: 0, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.70, yPercent: 0.86, angleDegrees: 0, speed: 0, radius: 12)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.30, yPercent: 0.48, widthPercent: 0.08, heightPercent: 0.34),
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.64, widthPercent: 0.34, heightPercent: 0.06),
            ArenaWallDefinition(xPercent: 0.70, yPercent: 0.48, widthPercent: 0.08, heightPercent: 0.34)
        ]
    )

    static let level91 = LevelDefinition(
        levelNumber: 91,
        startingAmmo: 3,
        launchSpeed: 295,
        launchedRockRadius: 12,
        initialObjects: [
            // speed gauntlet
            InitialObjectDefinition(type: .paper, xPercent: 0.14, yPercent: 0.26, angleDegrees: 17, speed: 295, radius: 12),
            InitialObjectDefinition(type: .scissors, xPercent: 0.86, yPercent: 0.32, angleDegrees: 163, speed: 295, radius: 12),
            InitialObjectDefinition(type: .paper, xPercent: 0.24, yPercent: 0.80, angleDegrees: 343, speed: 295, radius: 12),
            InitialObjectDefinition(type: .scissors, xPercent: 0.76, yPercent: 0.78, angleDegrees: 197, speed: 295, radius: 12),
            InitialObjectDefinition(type: .paper, xPercent: 0.44, yPercent: 0.56, angleDegrees: 91, speed: 255, radius: 12),
            InitialObjectDefinition(type: .scissors, xPercent: 0.62, yPercent: 0.60, angleDegrees: 269, speed: 255, radius: 20),
            InitialObjectDefinition(type: .rock, xPercent: 0.50, yPercent: 0.22, angleDegrees: 90, speed: 120, radius: 12)
        ]
    )

    static let level92 = LevelDefinition(
        levelNumber: 92,
        startingAmmo: 2,
        launchSpeed: 290,
        launchedRockRadius: 12,
        initialObjects: [
            // gauntlet review
            InitialObjectDefinition(type: .paper, xPercent: 0.16, yPercent: 0.24, angleDegrees: 0, speed: 290, radius: 12),
            InitialObjectDefinition(type: .scissors, xPercent: 0.84, yPercent: 0.30, angleDegrees: 180, speed: 290, radius: 12),
            InitialObjectDefinition(type: .paper, xPercent: 0.20, yPercent: 0.72, angleDegrees: 0, speed: 250, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.80, yPercent: 0.82, angleDegrees: 180, speed: 290, radius: 12),
            InitialObjectDefinition(type: .paper, xPercent: 0.50, yPercent: 0.52, angleDegrees: 0, speed: 0, radius: 12),
            InitialObjectDefinition(type: .scissors, xPercent: 0.50, yPercent: 0.86, angleDegrees: 0, speed: 0, radius: 12),
            InitialObjectDefinition(type: .rock, xPercent: 0.50, yPercent: 0.22, angleDegrees: 90, speed: 110, radius: 12)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.42, widthPercent: 0.34, heightPercent: 0.06),
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.70, widthPercent: 0.34, heightPercent: 0.06)
        ]
    )

    static let level93 = LevelDefinition(
        levelNumber: 93,
        startingAmmo: 3,
        launchSpeed: 285,
        launchedRockRadius: 12,
        initialObjects: [
            // final intro
            InitialObjectDefinition(type: .paper, xPercent: 0.14, yPercent: 0.22, angleDegrees: 31, speed: 285, radius: 12),
            InitialObjectDefinition(type: .scissors, xPercent: 0.86, yPercent: 0.28, angleDegrees: 149, speed: 285, radius: 12),
            InitialObjectDefinition(type: .paper, xPercent: 0.22, yPercent: 0.54, angleDegrees: 287, speed: 260, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.78, yPercent: 0.64, angleDegrees: 205, speed: 285, radius: 12),
            InitialObjectDefinition(type: .paper, xPercent: 0.34, yPercent: 0.86, angleDegrees: 0, speed: 0, radius: 12),
            InitialObjectDefinition(type: .scissors, xPercent: 0.66, yPercent: 0.86, angleDegrees: 0, speed: 0, radius: 12),
            InitialObjectDefinition(type: .rock, xPercent: 0.50, yPercent: 0.24, angleDegrees: 90, speed: 110, radius: 12)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.34, yPercent: 0.52, widthPercent: 0.08, heightPercent: 0.38),
            ArenaWallDefinition(xPercent: 0.66, yPercent: 0.52, widthPercent: 0.08, heightPercent: 0.38)
        ],
        introMessage: "Final stretch."
    )

    static let level94 = LevelDefinition(
        levelNumber: 94,
        startingAmmo: 2,
        launchSpeed: 295,
        launchedRockRadius: 12,
        initialObjects: [
            // final large maze
            InitialObjectDefinition(type: .paper, xPercent: 0.50, yPercent: 0.70, angleDegrees: 0, speed: 130, radius: 34),
            InitialObjectDefinition(type: .scissors, xPercent: 0.18, yPercent: 0.24, angleDegrees: 25, speed: 295, radius: 12),
            InitialObjectDefinition(type: .scissors, xPercent: 0.82, yPercent: 0.30, angleDegrees: 155, speed: 295, radius: 12),
            InitialObjectDefinition(type: .paper, xPercent: 0.24, yPercent: 0.84, angleDegrees: 335, speed: 255, radius: 12),
            InitialObjectDefinition(type: .scissors, xPercent: 0.76, yPercent: 0.84, angleDegrees: 205, speed: 255, radius: 12),
            InitialObjectDefinition(type: .rock, xPercent: 0.50, yPercent: 0.22, angleDegrees: 90, speed: 110, radius: 12)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.46, widthPercent: 0.14, heightPercent: 0.32),
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.78, widthPercent: 0.36, heightPercent: 0.06)
        ]
    )

    static let level95 = LevelDefinition(
        levelNumber: 95,
        startingAmmo: 3,
        launchSpeed: 300,
        launchedRockRadius: 12,
        initialObjects: [
            // final chaos
            InitialObjectDefinition(type: .paper, xPercent: 0.12, yPercent: 0.24, angleDegrees: 18, speed: 300, radius: 12),
            InitialObjectDefinition(type: .scissors, xPercent: 0.38, yPercent: 0.32, angleDegrees: 147, speed: 285, radius: 12),
            InitialObjectDefinition(type: .paper, xPercent: 0.72, yPercent: 0.24, angleDegrees: 264, speed: 295, radius: 12),
            InitialObjectDefinition(type: .scissors, xPercent: 0.84, yPercent: 0.58, angleDegrees: 201, speed: 300, radius: 12),
            InitialObjectDefinition(type: .paper, xPercent: 0.46, yPercent: 0.72, angleDegrees: 333, speed: 280, radius: 12),
            InitialObjectDefinition(type: .scissors, xPercent: 0.22, yPercent: 0.86, angleDegrees: 76, speed: 295, radius: 12),
            InitialObjectDefinition(type: .rock, xPercent: 0.64, yPercent: 0.84, angleDegrees: 225, speed: 110, radius: 12)
        ]
    )

    static let level96 = LevelDefinition(
        levelNumber: 96,
        startingAmmo: 2,
        launchSpeed: 300,
        launchedRockRadius: 12,
        initialObjects: [
            // final low ammo
            InitialObjectDefinition(type: .paper, xPercent: 0.16, yPercent: 0.20, angleDegrees: 45, speed: 300, radius: 12),
            InitialObjectDefinition(type: .scissors, xPercent: 0.84, yPercent: 0.26, angleDegrees: 135, speed: 300, radius: 12),
            InitialObjectDefinition(type: .paper, xPercent: 0.22, yPercent: 0.54, angleDegrees: 315, speed: 300, radius: 12),
            InitialObjectDefinition(type: .scissors, xPercent: 0.78, yPercent: 0.64, angleDegrees: 225, speed: 300, radius: 12),
            InitialObjectDefinition(type: .paper, xPercent: 0.36, yPercent: 0.86, angleDegrees: 0, speed: 0, radius: 12),
            InitialObjectDefinition(type: .scissors, xPercent: 0.64, yPercent: 0.86, angleDegrees: 0, speed: 0, radius: 20),
            InitialObjectDefinition(type: .rock, xPercent: 0.50, yPercent: 0.50, angleDegrees: 90, speed: 110, radius: 12)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.30, yPercent: 0.48, widthPercent: 0.08, heightPercent: 0.34),
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.64, widthPercent: 0.34, heightPercent: 0.06),
            ArenaWallDefinition(xPercent: 0.70, yPercent: 0.48, widthPercent: 0.08, heightPercent: 0.34)
        ]
    )

    static let level97 = LevelDefinition(
        levelNumber: 97,
        startingAmmo: 3,
        launchSpeed: 305,
        launchedRockRadius: 11,
        initialObjects: [
            // final shelves
            InitialObjectDefinition(type: .paper, xPercent: 0.14, yPercent: 0.26, angleDegrees: 17, speed: 305, radius: 11),
            InitialObjectDefinition(type: .scissors, xPercent: 0.86, yPercent: 0.32, angleDegrees: 163, speed: 305, radius: 11),
            InitialObjectDefinition(type: .paper, xPercent: 0.24, yPercent: 0.80, angleDegrees: 343, speed: 305, radius: 20),
            InitialObjectDefinition(type: .scissors, xPercent: 0.76, yPercent: 0.78, angleDegrees: 197, speed: 305, radius: 11),
            InitialObjectDefinition(type: .paper, xPercent: 0.44, yPercent: 0.56, angleDegrees: 91, speed: 265, radius: 11),
            InitialObjectDefinition(type: .scissors, xPercent: 0.62, yPercent: 0.60, angleDegrees: 269, speed: 265, radius: 11),
            InitialObjectDefinition(type: .rock, xPercent: 0.50, yPercent: 0.22, angleDegrees: 90, speed: 110, radius: 11)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.48, widthPercent: 0.44, heightPercent: 0.06),
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.76, widthPercent: 0.44, heightPercent: 0.06)
        ]
    )

    static let level98 = LevelDefinition(
        levelNumber: 98,
        startingAmmo: 2,
        launchSpeed: 310,
        launchedRockRadius: 11,
        initialObjects: [
            // final gate
            InitialObjectDefinition(type: .paper, xPercent: 0.18, yPercent: 0.22, angleDegrees: 30, speed: 310, radius: 11),
            InitialObjectDefinition(type: .scissors, xPercent: 0.82, yPercent: 0.28, angleDegrees: 150, speed: 310, radius: 11),
            InitialObjectDefinition(type: .paper, xPercent: 0.24, yPercent: 0.72, angleDegrees: 330, speed: 270, radius: 22),
            InitialObjectDefinition(type: .scissors, xPercent: 0.76, yPercent: 0.84, angleDegrees: 210, speed: 310, radius: 11),
            InitialObjectDefinition(type: .paper, xPercent: 0.50, yPercent: 0.52, angleDegrees: 0, speed: 0, radius: 11),
            InitialObjectDefinition(type: .scissors, xPercent: 0.50, yPercent: 0.86, angleDegrees: 0, speed: 0, radius: 11),
            InitialObjectDefinition(type: .rock, xPercent: 0.50, yPercent: 0.24, angleDegrees: 90, speed: 100, radius: 11)
        ],
        walls: [
            ArenaWallDefinition(xPercent: 0.34, yPercent: 0.52, widthPercent: 0.08, heightPercent: 0.42),
            ArenaWallDefinition(xPercent: 0.66, yPercent: 0.52, widthPercent: 0.08, heightPercent: 0.42),
            ArenaWallDefinition(xPercent: 0.50, yPercent: 0.70, widthPercent: 0.24, heightPercent: 0.06)
        ]
    )

    static let level99 = LevelDefinition(
        levelNumber: 99,
        startingAmmo: 6,
        launchSpeed: 240,
        launchedRockRadius: 22,
        initialObjects: [
            InitialObjectDefinition(type: .paper, xPercent: 0.32, yPercent: 0.75, angleDegrees: 0, speed: 0, radius: 18),
            InitialObjectDefinition(type: .paper, xPercent: 0.68, yPercent: 0.75, angleDegrees: 0, speed: 0, radius: 18),
            InitialObjectDefinition(type: .scissors, xPercent: 0.14, yPercent: 0.75, angleDegrees: 0, speed: 180, radius: 18),
            InitialObjectDefinition(type: .scissors, xPercent: 0.86, yPercent: 0.75, angleDegrees: 180, speed: 180, radius: 18),
            InitialObjectDefinition(type: .rock, xPercent: 0.50, yPercent: 0.25, angleDegrees: 0, speed: 0, radius: 18)
        ],
        introMessage: "Let the scissors sweep up the paper, then aim for the upper lane."
    )

    static let level100 = LevelDefinition(
        levelNumber: 100,
        startingAmmo: 7,
        launchSpeed: 260,
        launchedRockRadius: 22,
        initialObjects: [
            InitialObjectDefinition(type: .paper, xPercent: 0.35, yPercent: 0.78, angleDegrees: 0, speed: 0, radius: 18),
            InitialObjectDefinition(type: .paper, xPercent: 0.65, yPercent: 0.78, angleDegrees: 0, speed: 0, radius: 18),
            InitialObjectDefinition(type: .scissors, xPercent: 0.15, yPercent: 0.78, angleDegrees: 0, speed: 210, radius: 18),
            InitialObjectDefinition(type: .paper, xPercent: 0.50, yPercent: 0.50, angleDegrees: 0, speed: 0, radius: 18),
            InitialObjectDefinition(type: .scissors, xPercent: 0.82, yPercent: 0.50, angleDegrees: 180, speed: 190, radius: 18),
            InitialObjectDefinition(type: .rock, xPercent: 0.50, yPercent: 0.20, angleDegrees: 0, speed: 0, radius: 18)
        ],
        introMessage: "Clear the paper in both lanes before turning the remaining scissors into rock."
    )

}
