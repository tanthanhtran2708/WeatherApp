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

    func cityVM_ShouldHaveDefaultValue() throws {
        let cityVM = CityViewModel()
        XCTAssert(!cityVM.city.isEmpty)
        XCTAssert(cityVM.weather.current.dt != 0)
        XCTAssert(cityVM.weather.daily[0].dt != 0)
        XCTAssert(cityVM.weather.hourly[0].dt != 0)
    }
    
    func cityVM_ShouldTriggerChangeWhenCityChange() throws {
        let currentCityVM = CityViewModel()
        let americaCityVM = CityViewModel()
        
        americaCityVM.city = "America"
        XCTAssert(americaCityVM.weather.current.clouds != currentCityVM.weather.current.clouds)
        XCTAssert(americaCityVM.weather.daily[0].temp.max != currentCityVM.weather.daily[0].temp.max)
        XCTAssert(americaCityVM.weather.hourly[0].temp != currentCityVM.weather.hourly[0].temp)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
