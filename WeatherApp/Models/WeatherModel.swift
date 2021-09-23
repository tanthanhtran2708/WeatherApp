//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by thanhtan on 21/09/2021.
//

import Foundation

struct WeatherModel: Codable {
    var current: Weather
    var hourly: [Weather]
    var daily: [DailyWeather]
    
    static func empty() -> WeatherModel {
        return WeatherModel(current: Weather(), hourly: [Weather](repeating: Weather(), count: 23), daily: [DailyWeather](repeating: DailyWeather(), count: 8))
    }
}
