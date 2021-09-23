//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by thanhtan on 21/09/2021.
//

import XCTest
@testable import WeatherApp

class WeatherAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCityVMShouldHaveDefaultValue() throws {
        let cityVM = CityViewModel()
        cityVM.getLocation()
        XCTAssert(!cityVM.city.isEmpty)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
