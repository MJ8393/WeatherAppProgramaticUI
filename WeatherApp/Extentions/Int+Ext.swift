//
//  Int+Ext.swift
//  WeatherApp
//
//  Created by dev ios on 25/05/22.
//

import UIKit

enum DateFormat: String {
    case day  = "E"
    case hour = "MMM d, h:mm a"
}

extension Int {
    func dateFormat(_ type: DateFormat) -> String {
        let dateFromUnix = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = type.rawValue
        return dateFormatter.string(from: dateFromUnix)
    }
}
