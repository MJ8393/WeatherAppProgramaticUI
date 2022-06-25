//
//  WADailyTableVM.swift
//  WeatherApp
//
//  Created by dev ios on 24/05/22.
//

import UIKit

struct WADailyTableVM {
    var item: Daily!
    
    init(_ item: Daily) {
        self.item = item
    }
    
    
    var date: String {
        return item.dt.dateFormat(.day)
    }
    
    
    var temp: String {
        return item.temp.day.formatTemp()
    }
    
    
    var image: UIImage {
        return UIHelper.getConditionImage(weatherId: item.weather.first!.id)
    }
}

