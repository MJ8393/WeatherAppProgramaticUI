//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by dev ios on 24/05/22.
//

import Foundation
import CoreLocation

class NetworkManager {
    static let shared = NetworkManager()
    private let IP_KEY = "b06f2be68923c666bc3cfbe68d35d8a1"
    private let baseUrl = "https://api.openweathermap.org/data/2.5/onecall?exclude=minutely&"
    
    func performRequest(lat: CLLocationDegrees, lon: CLLocationDegrees, completed: @escaping (Result<WAModel, WAError>) -> Void) {
        let endPoint = "\(baseUrl)lat=\(lat)&lon=\(lon)&appid=\(IP_KEY)&units=metric"

        guard let url = URL(string: endPoint) else {
            completed(.failure(.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode(WAModel.self, from: data)
                completed(.success(followers))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
}

