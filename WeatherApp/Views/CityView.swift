//
//  CityView.swift
//  WeatherApp
//
//  Created by thanhtan on 21/09/2021.
//

import SwiftUI

struct CityView: View {
    @ObservedObject var cityViewModel: CityViewModel

    var body: some View {
        VStack {
            CityNameView(city: cityViewModel.city, date: cityViewModel.date).shadow(radius: 0)
            TodayWeatherView(cityViewModel: cityViewModel).padding()
            HourlyView(cityViewModel: cityViewModel)
            DailyWeatherView(cityViewModel: cityViewModel)
        }.padding(.bottom, 30)
    }
}

