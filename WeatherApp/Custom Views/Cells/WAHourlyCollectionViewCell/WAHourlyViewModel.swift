//
//  WAHourlyViewModel.swift
//  WeatherApp
//
//  Created by dev ios on 24/05/22.
//

import UIKit

struct WAHourlyViewModel {
    
    var item: Hourly!
    
    init(_ hourlyInfo: Hourly) {
        self.item = hourlyInfo
    }
    
    
    var temperature: String {
        return item.temp.formatTemp()
    }
    
    
    var date: String {
        return item.dt.dateFormat(.hour)
    }
    
    
    var image: UIImage {
        return UIHelper.getConditionImage(weatherId: item.weather.first?.id ?? 400)
    }
}


