//
//  APIManager.swift
//  WeatherApp
//
//  Created by thanhtan on 21/09/2021.
//

import Foundation

enum NetworkError: Error {
    case invalidResponse
    case invalidData
    case error(err: String)
}

struct API {
    static let apiKey = "60c6fbeb4b93ac653c492ba806fc346d"
    
}

extension API {
    static let baseURL = "https://api.openweathermap.org/data/2.5/"
    static func getURLWith(lat: Double, long: Double) -> String {
        return "\(baseURL)/onecall?lat=\(lat)&lon=\(long)&exclude=minutely&appid=\(apiKey)&units=imperial"
    }
}

final class APIManager<T: Codable> {
    static func fetch(for url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(.failure(.error(err: error.debugDescription)))
                return
            }
            
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let json = try JSONDecoder().decode(T.self, from: data)
                completion(.success(json))
            }
            catch let error {
                completion(.failure(.error(err: "Error decoding \(error.localizedDescription)")))
            }
            
        }.resume()
    }
}
