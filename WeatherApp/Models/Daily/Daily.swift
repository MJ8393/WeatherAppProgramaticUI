//
//  Daily.swift
//  WeatherApp
//
//  Created by dev ios on 24/05/22.
//

struct Daily: Decodable {
    let dt: Int
    let temp: Temp
    let weather: [Weather]
}
