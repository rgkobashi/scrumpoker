//
//  ScrumPokerUITests.swift
//  ScrumPokerUITests
//
//  Created by Rogelio Kobashi on 2019/04/27.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import XCTest

class ScrumPokerUITests: XCTestCase {
    
    private var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false

        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {}

    func testMenuScreenIsShown() {
        let menuButton = app.navigationBars.firstMatch.buttons["ellipsis"]
        menuButton.tap()
        let menuVC = app.otherElements["MenuViewController.view"]
        XCTAssertTrue(menuVC.waitForExistence(timeout: 5))
    }
    
    func testCardScreenIsShown() {
        let collectionView = app.collectionViews.firstMatch
        collectionView.cells.staticTexts["0"].tap()
        let cardVC = app.otherElements["CardViewController.view"]
        XCTAssertTrue(cardVC.waitForExistence(timeout: 5))
    }
}
