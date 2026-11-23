//
//  RockBreakerScissorsUITests.swift
//  RockBreakerScissorsUITests
//
//  Created by Grant Hevia on 4/14/26.
//

import XCTest

final class RockBreakerScissorsUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSelectingLessonShowsTextDespiteSavedLevel100() {
        let app = XCUIApplication()
        app.launchArguments = ["-highestUnlockedLevel", "100", "-completedTutorialLevels", "31"]
        app.launch()
        app.buttons["Rock Mode"].tap()
        app.buttons["Select Level"].tap()
        app.buttons["Lesson 1"].tap()
        let firstMessage = app.staticTexts["Your goal is to turn every object into rock. Rock turns scissors into rock when they touch."]
        XCTAssertTrue(firstMessage.waitForExistence(timeout: 5))
        app.buttons["Next"].tap()
        XCTAssertTrue(app.buttons["Play"].exists)
        app.buttons["Play"].tap()
        XCTAssertFalse(firstMessage.exists)
        app.buttons["Help"].tap()
        XCTAssertTrue(firstMessage.exists)
    }

    func testRandomModeCanBeSkippedAndReplayed() {
        let app = XCUIApplication()
        app.launch()
        app.buttons["Rock Mode"].tap()
        app.buttons["Random Levels"].tap()
        XCTAssertTrue(app.staticTexts["Random 1"].waitForExistence(timeout: 5))
        app.buttons["Skip"].tap()
        XCTAssertTrue(app.staticTexts["Random 2"].exists)
        app.buttons["Restart"].tap()
        XCTAssertTrue(app.staticTexts["Random 2"].exists)
        app.buttons["Menu"].tap()
        app.buttons["Rock Mode"].tap()
        XCTAssertTrue(app.buttons["Random Levels"].exists)
    }

    func testBetHasPreviewChoiceAndCountdown() {
        let app = XCUIApplication()
        app.launch()
        app.buttons["Bet"].tap()
        XCTAssertTrue(app.staticTexts["Who will be last? Choose before they move."].waitForExistence(timeout: 5))
        app.buttons["Paper"].tap()
        XCTAssertTrue(app.staticTexts["Your pick: Paper"].exists)
        XCTAssertTrue(app.staticTexts["Starting in 3"].waitForExistence(timeout: 1))
        app.buttons["Menu"].tap()
        app.buttons["Bet"].tap()
        XCTAssertTrue(app.buttons["Rock"].exists)
    }

    func testBalanceExplainsSurvivalAndStartsTheTimer() {
        let app = XCUIApplication()
        app.launch()
        app.buttons["Balance"].tap()
        XCTAssertTrue(app.buttons["Play"].waitForExistence(timeout: 5))
        app.buttons["Play"].tap()
        XCTAssertTrue(app.staticTexts["Unlimited rocks"].exists)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
