//
//  HeaderView.swift
//  WeatherApp
//
//  Created by thanhtan on 21/09/2021.
//

import Foundation
import SwiftUI

struct HeaderView: View {
    @ObservedObject var cityViewModel: CityViewModel

    @State private var searchInput = "Enter your country"
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass").padding(.leading, 10).foregroundColor(.white)
            TextField("", text: $searchInput)
                .padding(.all, 10)
                .background(RoundedRectangle.init(cornerRadius: 10).fill(Color.purple))
                .foregroundColor(Color.white)
                .font(.headline)
                .onChange(of: searchInput, perform: { value in
                    cityViewModel.isEditting = true
                    cityViewModel.suggestedData = cityViewModel.DICTIONARY.filter({ searchInput != "" && searchInput.count >= 3 && $0.hasPrefix(searchInput) })
                })
                .onTapGesture {
                    searchInput = ""
                }

            Button {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                cityViewModel.city = searchInput
                cityViewModel.isEditting = false
                cityViewModel.isFetchingData = true
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10).fill(Color.blue)
                    Image(systemName: "location.fill")
                }
            }.frame(width: 50, height: 50)
        }
        .foregroundColor(.white)
        .padding()
        .background(ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 10).fill(Color.purple)
        })
    }
}
