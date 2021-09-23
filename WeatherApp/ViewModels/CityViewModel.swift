//
//  CityViewModel.swift
//  WeatherApp
//
//  Created by thanhtan on 21/09/2021.
//

import Foundation
import SwiftUI
import CoreLocation

final class CityViewModel: ObservableObject {
    @Published var weather = WeatherModel.empty()
    
    @Published var city: String = "Ho Chi Minh" {
        didSet {
            getLocation()
        }
    }
    
    @Published var isFetchingData: Bool = false
    
    @Published var isEditting: Bool = false
    
    @Published var isAlertShouldPresented: Bool = false
    
    @Published var suggestedData: [String] = []
    
    private lazy var dateFormatter: DateFormatter = {
        let fomatter = DateFormatter()
        fomatter.dateStyle = .full
        return fomatter
    }()
    
    private lazy var dayFormatter: DateFormatter = {
        let fomatter = DateFormatter()
        fomatter.dateFormat = "EEE"
        return fomatter
    }()
    
    private lazy var timeFormatter: DateFormatter = {
        let fomatter = DateFormatter()
        fomatter.dateFormat = "hh a"
        return fomatter
    }()
    
    init() {
        getLocation()
    }
    
    var date: String {
        return dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval((weather.current.dt))))
    }
    
    var weatherIcon: String {
        if weather.current.weather.count > 0 {
            return weather.current.weather[0].icon
        }
        
        return "sun.max.fill"
    }
    
    var temperature: String {
        return getTempFor(temp: weather.current.temp)
    }
    
    var condition: String {
        if weather.current.weather.count > 0 {
            return weather.current.weather[0].main
        }
        
        return ""
    }
    
    var windSpeed: String {
        return String(format: "%0.1f", weather.current.wind_speed)
    }
    
    var humidity: String {
        return String(format: "%d%%", weather.current.humidity)
    }
    
    var rainChances: String {
        return String(format: "%0.0f%%", weather.current.dew_point)
    }
    
    func getTempFor(temp: Double) -> String {
        return String(format: "%0.1f", temp)
    }
    
    func getTimeFor(timestamp: Int) -> String {
        return timeFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(timestamp)))
    }

    func getDayFor(timestamp: Int) -> String {
        return dayFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(timestamp)))
    }
    
    private func getWeather(coord: CLLocationCoordinate2D?) {
        if let coord = coord {
            let urlString = API.getURLWith(lat: coord.latitude, long: coord.longitude)
            getWeatherInternal(city: city, for: urlString)
        } else {
            let urlString = API.getURLWith(lat: 10.7659451, long: 106.6303599)
            getWeatherInternal(city: city, for: urlString)
        }
    }
    
    private func getWeatherInternal(city: String, for urlString: String) {
        APIManager<WeatherModel>.fetch(for: URL(string: urlString)!) { (result) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.weather = response
                    self.isFetchingData = false
                    self.isEditting = false
                }
            case .failure(let err):
                print(err)
                DispatchQueue.main.async {
                    self.isFetchingData = false
                    self.isEditting = false
                    self.isAlertShouldPresented = true
                }
            }
        }
    }
    
    func getLocation() {
        isFetchingData = true
        CLGeocoder().geocodeAddressString(city) { placemarks, Error in
            if (placemarks == nil) {
                self.isFetchingData = false
                self.isEditting = false
                self.isAlertShouldPresented = true
                return
            }
            if let places = placemarks, let place = places.first {
                self.getWeather(coord: place.location?.coordinate)
            }
        }
    }
    
    public func onTapElement(element: String) -> Void {
        self.city = element
    }
    
    func getLottieAnimationFor(icon: String) -> String {
        switch icon {
        case "01d":
            return "dayClearSky"
        case "01n":
            return "nightClearSky"
        case "02d":
            return "dayFewClouds"
        case "02n":
            return "nightFewClouds"
        case "03d":
            return "dayScatteredClouds"
        case "03n":
            return "nightScatteredClouds"
        case "04d":
            return "dayBrokenClouds"
        case "04n":
            return "nightBrokenClouds"
        case "09d":
            return "dayShowerRains"
        case "09n":
            return "nightShowerRains"
        case "10d":
            return "dayRain"
        case "10n":
            return "nightRain"
        case "11d":
            return "dayThunderstorm"
        case "11n":
            return "nightThunderstorm"
        case "13d":
            return "daySnow"
        case "13n":
            return "nightSnow"
        case "50d":
            return "dayMist"
        case "50n":
            return "nightMist"
        default:
            return "dayClearSky"
        }
    }
    
    func getWeatherIconFor(icon: String) -> Image {
        switch icon {
        case "01d":
            return Image(systemName: "sun.max.fill")
        case "01n":
            return Image(systemName: "moon.fill")
        case "02d":
            return Image(systemName: "cloud.sun.fill")
        case "02n":
            return Image(systemName: "cloud.moon.fill")
        case "03d":
            return Image(systemName: "cloud.fill")
        case "03n":
            return Image(systemName: "cloud.fill")
        case "04d":
            return Image(systemName: "cloud.fill")
        case "04n":
            return Image(systemName: "cloud.fill")
        case "09d":
            return Image(systemName: "cloud.drizzle.fill")
        case "09n":
            return Image(systemName: "cloud.drizzle.fill")
        case "10d":
            return Image(systemName: "cloud.heavyrain.fill")
        case "10n":
            return Image(systemName: "cloud.heavyrain.fill")
        case "11d":
            return Image(systemName: "cloud.bolt.fill")
        case "11n":
            return Image(systemName: "cloud.bolt.fill")
        case "13d":
            return Image(systemName: "cloud.snow.fill")
        case "13n":
            return Image(systemName: "cloud.snow.fill")
        case "50d":
            return Image(systemName: "cloud.fog.fill")
        case "50n":
            return Image(systemName: "cloud.fog.fill")
        default:
            return Image(systemName: "sun.max.fill")
        }
    }
    
    var DICTIONARY: [String] = [
        "Afghanistan"
        ,"Albania"
        ,"Algeria"
        ,"Andorra"
        ,"Angola"
        ,"Argentina"
        ,"Armenia"
        ,"Australia"
        ,"Austria"
        ,"Azerbaijan"
        ,"Bahamas"
        ,"Bahrain"
        ,"Bangladesh"
        ,"Barbados"
        ,"Belarus"
        ,"Belgium"
        ,"Belize"
        ,"Benin"
        ,"Bhutan"
        ,"Bolivia"
        ,"Botswana"
        ,"Brazil"
        ,"Brunei"
        ,"Bulgaria"
        ,"Burkina"
        ,"Chile"
        ,"China"
        ,"Colombia"
        ,"Comoros"
        ,"Congo"
        ,"Costa Rica"
        ,"Croatia"
        ,"Cuba"
        ,"Cyprus"
        ,"Denmark"
        ,"Djibouti"
        ,"Dominica"
        ,"Ecuador"
        ,"Egypt"
        ,"Finland"
        ,"France"
        ,"Gabon"
        ,"Gambia"
        ,"Georgia"
        ,"Germany"
        ,"Haiti"
        ,"Honduras"
        ,"Hungary"
        ,"Iceland"
        ,"India"
        ,"Indonesia"
        ,"Iran"
        ,"Iraq"
        ,"Israel"
        ,"Italy"
        ,"Jamaica"
        ,"Japan"
        ,"Jordan"
        ,"Kazakhstan"
        ,"Kenya"
        ,"Kiribati"
        ,"Korea North"
        ,"Korea South"
        ,"Kosovo"
        ,"Kuwait"
        ,"Kyrgyzstan"
        ,"Laos"
        ,"Latvia"
        ,"Lebanon"
        ,"Lesotho"
        ,"Liberia"
        ,"Libya"
        ,"Malaysia"
        ,"Maldives"
        ,"Mali"
        ,"Malta"
        ,"Mauritius"
        ,"Mexico"
        ,"Micronesia"
        ,"Nepal"
        ,"Netherlands"
        ,"New Zealand"
        ,"Norway"
        ,"Oman"
        ,"Paraguay"
        ,"Peru"
        ,"Philippines"
        ,"Poland"
        ,"Portugal"
        ,"Qatar"
        ,"Romania"
        ,"Swaziland"
        ,"Sweden"
        ,"Switzerland"
        ,"Syria"
        ,"Taiwan"
        ,"Tajikistan"
        ,"Tanzania"
        ,"Thailand"
        ,"Tunisia"
        ,"Turkey"
        ,"Turkmenistan"
        ,"Tuvalu"
        ,"Uganda"
        ,"Ukraine"
        ,"United Arab Emirates"
        ,"United Kingdom"
        ,"United States"
        ,"Uruguay"
        ,"Uzbekistan"
        ,"Vanuatu"
        ,"Venezuela"
        ,"Vietnam"
        ,"Yemen"
        ,"Zambia"
        ,"Zimbabwe"
    ]
}
