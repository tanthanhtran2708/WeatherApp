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

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testAppManualFlows() {
        let app = XCUIApplication()
        app.launch()
        
        // Progress view should appear first
        var progressView = app.children(matching: .progressIndicator).element(boundBy: 0)
        XCTAssertTrue(progressView.exists)
        
        // Sleep for 10 secs then the progressView now dissappear
        sleep(10)
        XCTAssertFalse(progressView.exists)
        
        // Looking for the text input
        let searchField = app.children(matching: .textField).element(boundBy: 0)
        XCTAssertTrue(searchField.exists && !searchField.title.isEmpty) // Must exist and have value
        if (searchField.isHittable) {
            searchField.tap()
        }
        
        searchField.typeText("America")
        
        // Looking for button and tap on it
        let searchBtn = app.children(matching: .button).element(boundBy: 0)
        XCTAssertTrue(searchBtn.exists)
        if (searchBtn.isHittable) {
            searchBtn.tap()
        }
        
        // For now, the progress view will appear again
        progressView = app.children(matching: .progressIndicator).element(boundBy: 0)
        XCTAssertTrue(progressView.exists)
        sleep(10)
        
        // After 10s then checking for solution
        let todayLabel = app.children(matching: .textView).element(boundBy: 0)
        XCTAssert(todayLabel.title == "America")
    }
    
    func testSuggestView() {
        let app = XCUIApplication()
        app.launch()
        
        // Wait for 10 seconds to finish fetching data
        sleep(10)
        
        // Looking for the text input
        let searchField = app.children(matching: .textField).element(boundBy: 0)
        XCTAssertTrue(searchField.exists && !searchField.title.isEmpty) // Must exist and have value
        if (searchField.isHittable) {
            searchField.tap()
        }
        
        // First try typing 1 character
        searchField.typeText("C")
        var cells = app.children(matching: .textView)
        
        // Render nothing
        XCTAssertTrue(cells.count == 0)
        
        searchField.typeText("hi")
        
        // For now it should appear available solutions
        cells = app.children(matching: .textView)
        XCTAssertTrue(cells.count > 0)
        
        // Try tapping one
        let firstCell = cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.exists && firstCell.isHittable)
        firstCell.tap()
        
        // Back to the manual searching flow
        sleep(10)
        let todayLabel = app.children(matching: .textView).element(boundBy: 0)
        XCTAssertTrue(todayLabel.title == firstCell.title)
    }
}
