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
    private var timeoutToWaitForExistence: TimeInterval = 5
    private var menuScreen: XCUIElement {
        return app.otherElements["MenuViewController.view"]
    }
    private var deckScreen: XCUIElement {
        return app.otherElements["DeckViewController.view"]
    }
    private var cardScreen: XCUIElement {
        return app.otherElements["CardViewController.view"]
    }

    override func setUp() {
        continueAfterFailure = false

        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {}

    func test_menuScreen_is_shown() {
        let menuButton = app.navigationBars.firstMatch.buttons["ellipsis"]
        menuButton.tap()
        XCTAssertTrue(menuScreen.waitForExistence(timeout: timeoutToWaitForExistence))
    }
    
    func testCardScreenIsShown() {
        let collectionView = app.collectionViews.firstMatch
        collectionView.cells.staticTexts["0"].tap()
        let cardVC = app.otherElements["CardViewController.view"]
        XCTAssertTrue(cardVC.waitForExistence(timeout: 5))
    }
}
