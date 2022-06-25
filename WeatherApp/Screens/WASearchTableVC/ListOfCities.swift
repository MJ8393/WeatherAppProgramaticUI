//
//  ListOfCities.swift
//  WeatherApp
//
//  Created by dev ios on 24/05/22.
//

import Foundation

struct ListOfCities {
    
    var listOfCities: [City]!
    
    init() {
        listOfCities = decodeDataOfCities(getCitiesData())
    }
    
    private func getCitiesData() -> Data? {
        do {
            if let bundlePath   = Bundle.main.path(forResource: "cities", ofType: "json") {
                let jsonData    = try String(contentsOfFile: bundlePath).data(using: .utf8)
                return jsonData
            }
        } catch {
            print(WAError.gettingData)
        }
        return nil
    }
    
    mutating func decodeDataOfCities(_ data: Data?) -> [City]? {
        if let data = getCitiesData() {
            do {
                let decoder  = JSONDecoder()
                listOfCities = try decoder.decode([City].self, from: data)
                return listOfCities
            } catch {
                print(WAError.decodingCities)
            }
        }
        return nil
    }
    
}
