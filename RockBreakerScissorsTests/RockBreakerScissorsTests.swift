//
//  RockBreakerScissorsTests.swift
//  RockBreakerScissorsTests
//
//  Created by Grant Hevia on 4/14/26.
//

import CoreGraphics
import XCTest
@testable import RockBreakerScissors

final class RockBreakerScissorsTests: XCTestCase {

    func testLevelNumbersAreContiguous() throws {
        let numbers = LevelLibrary.allLevels.map(\.levelNumber)
        XCTAssertEqual(numbers, Array(1...LevelLibrary.allLevels.count))
    }

    func testLevelsUseValidLayoutValues() throws {
        for level in LevelLibrary.allLevels {
            XCTAssertGreaterThan(level.startingAmmo, 0, "Level \(level.levelNumber)")
            XCTAssertGreaterThan(level.launchSpeed, 0, "Level \(level.levelNumber)")
            XCTAssertGreaterThan(level.launchedRockRadius, 0, "Level \(level.levelNumber)")
            XCTAssertFalse(level.initialObjects.isEmpty, "Level \(level.levelNumber)")

            for object in level.initialObjects {
                XCTAssertGreaterThanOrEqual(object.xPercent, 0, "Level \(level.levelNumber)")
                XCTAssertLessThanOrEqual(object.xPercent, 1, "Level \(level.levelNumber)")
                XCTAssertGreaterThanOrEqual(object.yPercent, 0, "Level \(level.levelNumber)")
                XCTAssertLessThanOrEqual(object.yPercent, 1, "Level \(level.levelNumber)")
                XCTAssertGreaterThan(object.radius, 0, "Level \(level.levelNumber)")
                XCTAssertGreaterThanOrEqual(object.velocity.length, 0, "Level \(level.levelNumber)")
            }

            for wall in level.walls {
                XCTAssertGreaterThanOrEqual(wall.xPercent, 0, "Level \(level.levelNumber)")
                XCTAssertLessThanOrEqual(wall.xPercent, 1, "Level \(level.levelNumber)")
                XCTAssertGreaterThanOrEqual(wall.yPercent, 0, "Level \(level.levelNumber)")
                XCTAssertLessThanOrEqual(wall.yPercent, 1, "Level \(level.levelNumber)")
                XCTAssertGreaterThan(wall.widthPercent, 0, "Level \(level.levelNumber)")
                XCTAssertGreaterThan(wall.heightPercent, 0, "Level \(level.levelNumber)")
            }
        }
    }

    func testEarlyLevelsUseSameLaunchAndArenaSpeeds() throws {
        for level in LevelLibrary.allLevels where level.levelNumber < 21 {
            for object in level.initialObjects {
                guard object.velocity.length > 0 else { continue }
                XCTAssertEqual(
                    object.velocity.length,
                    level.launchSpeed,
                    accuracy: 0.001,
                    "Level \(level.levelNumber) has mixed speeds before the speed mechanic is introduced"
                )
            }
        }
    }

    func testNewMechanicLevelsHaveHints() throws {
        XCTAssertNotNil(LevelLibrary.level21.introMessage)
        XCTAssertNotNil(LevelLibrary.level22.introMessage)
        XCTAssertNotNil(LevelLibrary.level23.introMessage)
        XCTAssertFalse(LevelLibrary.level22.walls.isEmpty)
        XCTAssertTrue(LevelLibrary.level23.initialObjects.contains { $0.velocity.length == 0 })
    }

    func testInitialObjectsDoNotOverlapOnSmallArena() throws {
        let arenaSize = CGSize(width: 320, height: 568)
        let arenaInset: CGFloat = 24
        let minX = arenaInset
        let maxX = arenaSize.width - arenaInset
        let minY = arenaInset + 24
        let maxY = arenaSize.height - arenaInset
        let objectScale: CGFloat = 0.80

        for level in LevelLibrary.allLevels {
            let objects = level.initialObjects

            for i in 0..<objects.count {
                for j in (i + 1)..<objects.count {
                    let first = objects[i]
                    let second = objects[j]
                    let firstPoint = CGPoint(
                        x: minX + first.xPercent * (maxX - minX),
                        y: minY + first.yPercent * (maxY - minY)
                    )
                    let secondPoint = CGPoint(
                        x: minX + second.xPercent * (maxX - minX),
                        y: minY + second.yPercent * (maxY - minY)
                    )
                    let dx = firstPoint.x - secondPoint.x
                    let dy = firstPoint.y - secondPoint.y
                    let distance = sqrt(dx * dx + dy * dy)
                    let minimumDistance = (first.radius + second.radius) * objectScale

                    XCTAssertGreaterThan(
                        distance,
                        minimumDistance,
                        "Level \(level.levelNumber) objects \(i) and \(j) overlap at startup"
                    )
                }
            }
        }
    }

    func testReportedProblemLevelsDoNotCollapseWithoutPlayerInput() throws {
        let levels = [
            LevelLibrary.level8,
            LevelLibrary.level10,
            LevelLibrary.level11,
            LevelLibrary.level13,
            LevelLibrary.level15,
            LevelLibrary.level17,
            LevelLibrary.level18
        ]

        for level in levels {
            let uniformType = simulateUniformType(level: level, seconds: 3)
            XCTAssertNil(
                uniformType,
                "Level \(level.levelNumber) became all \(uniformType?.displayName ?? "unknown") without player input"
            )
        }
    }

    private func simulateUniformType(level: LevelDefinition, seconds: Int) -> ObjectType? {
        let arenaSize = CGSize(width: 320, height: 568)
        let arenaInset: CGFloat = 24
        let minX = arenaInset
        let maxX = arenaSize.width - arenaInset
        let minY = arenaInset + 24
        let maxY = arenaSize.height - arenaInset
        let objectScale: CGFloat = 0.80

        var objects = level.initialObjects.map { definition in
            SimulatedObject(
                type: definition.type,
                position: CGPoint(
                    x: minX + definition.xPercent * (maxX - minX),
                    y: minY + definition.yPercent * (maxY - minY)
                ),
                velocity: definition.velocity,
                radius: definition.radius * objectScale
            )
        }

        for _ in 0..<(seconds * 60) {
            for index in objects.indices {
                move(
                    object: &objects[index],
                    minX: minX,
                    maxX: maxX,
                    minY: minY,
                    maxY: maxY
                )
            }

            for i in 0..<(objects.count - 1) {
                for j in (i + 1)..<objects.count {
                    var first = objects[i]
                    var second = objects[j]
                    applyCollisionIfNeeded(first: &first, second: &second)
                    objects[i] = first
                    objects[j] = second
                }
            }

            if let firstType = objects.first?.type,
               objects.allSatisfy({ $0.type == firstType }) {
                return firstType
            }
        }

        return nil
    }

    private func move(
        object: inout SimulatedObject,
        minX: CGFloat,
        maxX: CGFloat,
        minY: CGFloat,
        maxY: CGFloat
    ) {
        let dt: CGFloat = 1.0 / 60.0
        object.position.x += object.velocity.dx * dt
        object.position.y += object.velocity.dy * dt

        if object.position.x - object.radius < minX {
            object.position.x = minX + object.radius
            object.velocity.dx *= -1
        } else if object.position.x + object.radius > maxX {
            object.position.x = maxX - object.radius
            object.velocity.dx *= -1
        }

        if object.position.y - object.radius < minY {
            object.position.y = minY + object.radius
            object.velocity.dy *= -1
        } else if object.position.y + object.radius > maxY {
            object.position.y = maxY - object.radius
            object.velocity.dy *= -1
        }
    }

    private func applyCollisionIfNeeded(first: inout SimulatedObject, second: inout SimulatedObject) {
        let dx = first.position.x - second.position.x
        let dy = first.position.y - second.position.y
        let distanceSquared = dx * dx + dy * dy
        let allowed = first.radius + second.radius

        guard distanceSquared <= allowed * allowed else { return }
        guard first.type != second.type else { return }

        switch (first.type, second.type) {
        case (.rock, .scissors), (.scissors, .paper), (.paper, .rock):
            second.type = first.type

        case (.scissors, .rock), (.paper, .scissors), (.rock, .paper):
            first.type = second.type

        default:
            break
        }
    }

    private struct SimulatedObject {
        var type: ObjectType
        var position: CGPoint
        var velocity: CGVector
        let radius: CGFloat
    }
}
