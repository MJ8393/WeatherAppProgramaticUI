//
//  WAModel.swift
//  WeatherApp
//
//  Created by dev ios on 24/05/22.
//

struct WAModel: Decodable {
    let timezone: String
    let current: Current
    let hourly: [Hourly]
    let daily: [Daily]
}

