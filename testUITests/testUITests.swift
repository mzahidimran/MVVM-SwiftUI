//
//  testUITests.swift
//  testUITests
//
//  Created by Muhammad Zahid Imran on 23/03/2022.
//

import XCTest

class testUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        // In UI tests it is usually best to stop immediately when a failure occurs.
    
        self.app = XCUIApplication()
        app.launchArguments += ["UITEST_MODE"]
        app.launch()
    }


    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = true

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearch() throws {
        Thread.sleep(forTimeInterval: 5)
        app.textFields.firstMatch.tap()
        app.textFields.firstMatch.typeText("zahid")
        Thread.sleep(forTimeInterval: 1)
        app.buttons["Submit"].tap()
        Thread.sleep(forTimeInterval: 5)
        XCTAssert(app.staticTexts["zahid"].exists)

    }

}

