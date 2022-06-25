//
//  UIHelper.swift
//  WeatherApp
//
//  Created by dev ios on 24/05/22.
//

import UIKit

struct UIHelper {
    static func createFlowLayout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 10)
        flowLayout.itemSize = CGSize(width: 190, height: 200)
        return flowLayout
    }
    
    
    static func getConditionImage(weatherId: Int) -> UIImage {
        var nameIcon = "cloud"
        switch weatherId {
        case 200...232:
            nameIcon = "cloud.bolt"
        case 300...321:
            nameIcon = "cloud.drizzle"
        case 500...531:
            nameIcon = "cloud.rain"
        case 600...622:
            nameIcon = "cloud.snow"
        case 701...781:
            nameIcon = "cloud.fog"
        case 800:
            nameIcon = "sun.max"
        case 801...804:
            nameIcon = "cloud.bolt"
        default:
            nameIcon = "cloud"
        }
        
        return UIImage(systemName: nameIcon) ?? UIImage()
    }
}
