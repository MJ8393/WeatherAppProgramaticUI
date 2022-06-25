//
//  Double+Ext.swift
//  WeatherApp
//
//  Created by dev ios on 25/05/22.
//

extension Double {
    func formatTemp() -> String {
        return "\(String(format: "%.1f", self))°C"
    }
}
