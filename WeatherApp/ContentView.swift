//
//  ContentView.swift
//  WeatherApp
//
//  Created by thanhtan on 21/09/2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var cityViewModel = CityViewModel()
    var body: some View {
        if (cityViewModel.isFetchingData) {
            ProgressView()
        }
        else {
            ZStack(alignment: .bottom) {
                VStack(spacing: 0) {
                    HeaderView(cityViewModel: cityViewModel)
                    ScrollView(showsIndicators: false) {
                        if (cityViewModel.isEditting) {
                            SuggestView(cityViewModel: cityViewModel, data: cityViewModel.suggestedData)
                        }
                        else {
                            CityView(cityViewModel: cityViewModel)
                        }
                    }.padding(.top, 20)
                }.padding(.top, 40)
            }
            .background(RoundedRectangle(cornerRadius: 5).fill(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing)))
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/).alert(isPresented: $cityViewModel.isAlertShouldPresented, content: {
                Alert(title: Text("Error"), message: Text("There is no city found"), dismissButton: .default(Text("Got it!")))
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
