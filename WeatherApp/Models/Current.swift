//
//  Current.swift
//  WeatherApp
//
//  Created by dev ios on 24/05/22.
//

struct Current: Decodable {
    let temp: Double
    let weather: [Weather]
}

