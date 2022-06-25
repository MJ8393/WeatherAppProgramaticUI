//
//  Hourly.swift
//  WeatherApp
//
//  Created by dev ios on 24/05/22.
//

struct Hourly: Decodable {
    let dt: Int
    let temp: Double
    let weather: [Weather]
}

