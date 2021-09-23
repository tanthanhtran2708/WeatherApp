//
//  CityNameView.swift
//  WeatherApp
//
//  Created by thanhtan on 21/09/2021.
//

import SwiftUI

struct CityNameView: View {
    var city: String
    var date: String
    
    var body: some View {
        HStack {
            VStack(alignment: .center, spacing: 10) {
                Text(date).bold().font(.headline)
            }.foregroundColor(.white)
        }
    }
}

