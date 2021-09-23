//
//  SuggestView.swift
//  WeatherApp
//
//  Created by thanhtan on 22/09/2021.
//

import SwiftUI

struct SuggestView: View {
    var cityViewModel: CityViewModel
    var data: [String]

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(data, id: \.self) { data in
                HStack(alignment: .top) {
                    Text(data).frame(maxWidth: .infinity).font(.subheadline.bold())
                }
                .foregroundColor(.white)
                .padding(.horizontal, 14)
                .padding(.vertical, 14)
                .background(RoundedRectangle(cornerRadius: 5).fill(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)))
                .shadow(color: Color.white.opacity(0.1), radius: 2, x: -2, y: -2)
                .shadow(color: Color.black.opacity(0.2), radius: 2, x: 2, y: 2)
                .onTapGesture {
                    cityViewModel.onTapElement(element: data)
                }
            }
        }.padding(.all, 0)
    }
}
