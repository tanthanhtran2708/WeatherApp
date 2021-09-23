//
//  DailyWeatherView.swift
//  WeatherApp
//
//  Created by thanhtan on 21/09/2021.
//

import SwiftUI

struct DailyWeatherView: View {
    @ObservedObject var cityViewModel: CityViewModel

    var body: some View {
        ForEach(cityViewModel.weather.daily) { weather in
            LazyVStack {
                dailyWeatherViewCell(weather: weather)
            }.padding(.top, 10)
        }
    }
    
    private func dailyWeatherViewCell(weather: DailyWeather) -> some View {
        HStack {
            Text(cityViewModel.getDayFor(timestamp: weather.dt).uppercased()).frame(width: 50)
            Spacer()
            Text("\(cityViewModel.getTempFor(temp: weather.temp.max)) | \(cityViewModel.getTempFor(temp: weather.temp.min)) °F").frame(width: 150)
            Spacer()
            cityViewModel.getWeatherIconFor(icon: weather.weather.count > 0 ? weather.weather[0].icon : "sun.max.fill")
        }
        .foregroundColor(.white)
        .padding(.horizontal, 40)
        .padding(.vertical, 30)
        .background(RoundedRectangle(cornerRadius: 5).fill(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing)))
        .shadow(color: Color.white.opacity(0.1), radius: 2, x: -2, y: -2)
        .shadow(color: Color.black.opacity(0.2), radius: 2, x: 2, y: 2)
    }
}
