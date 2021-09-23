//
//  WeatherAppUITests.swift
//  WeatherAppUITests
//
//  Created by thanhtan on 21/09/2021.
//

import XCTest

class WeatherAppUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
    }
    
    func testAppManualFlows() {
        let app = XCUIApplication()
        app.launch()
        
        // Sleep for 5 secs then the progressView now dissappear
        sleep(5)
        
        // Looking for the text input
        let searchField = app.textFields.element(boundBy: 0)
        XCTAssertTrue(searchField.exists) // Must exist and have value
        if (searchField.isHittable) {
            searchField.tap()
        }
        
        searchField.typeText("America")
        
        // Looking for button and tap on it
        let searchBtn = app.buttons.element(boundBy: 0)
        XCTAssertTrue(searchBtn.exists)
        if (searchBtn.isHittable) {
            searchBtn.tap()
        }
        sleep(5)
        
        // After 5s then checking for solution
        let todayLabel = app.staticTexts["America"]
        XCTAssert(todayLabel.label == "America")
    }
    
    func testSuggestView() {
        let app = XCUIApplication()
        app.launch()

        // Wait for 5 seconds to finish fetching data
        sleep(5)

        // Looking for the text input
        let searchField = app.textFields.element(boundBy: 0)
        XCTAssertTrue(searchField.exists) // Must exist and have value
        if (searchField.isHittable) {
            searchField.tap()
        }

        // First try typing 1 character
        searchField.typeText("C")
        var cells = app.textViews

        // Render nothing
        XCTAssertTrue(cells.count == 0)

        searchField.typeText("hi")

        // For now it should appear available solutions
        cells = app.staticTexts
        XCTAssertTrue(cells.count > 0)

        // Try tapping one
        let firstCell = cells.element(boundBy: cells.count - 1)
        XCTAssertTrue(firstCell.exists && firstCell.isHittable)
        firstCell.tap()

        // Back to the manual searching flow
        sleep(5)
        let todayLabel = app.staticTexts[firstCell.label]
        XCTAssert(todayLabel.label == firstCell.label)
    }
}
