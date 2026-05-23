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
                XCTAssertGreaterThan(object.velocity.length, 0, "Level \(level.levelNumber)")
            }
        }
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
}
