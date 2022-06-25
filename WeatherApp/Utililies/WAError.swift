//
//  WAError.swift
//  WeatherApp
//
//  Created by dev ios on 25/05/22.
//

enum WAError: String, Error {
    case invalidUrl         = "Promlem in URL"
    case unableToComplete   = "Unable to complate your request."
    case invalidResponse    = "Invalid response from the server."
    case invalidData        = "The data recieved from the server was invalid."
    case decodingCities     = "Error in Decoding cities.json file"
    case gettingData        = "Error in get cities data fom local file"
    case gettingCoordinate  = "Failure getting City info from WASearchTableVC"
}
