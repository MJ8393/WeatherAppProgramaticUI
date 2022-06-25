//
//  BaseVC.swift
//  WeatherApp
//
//  Created by dev ios on 25/05/22.
//

import UIKit

class BaseVC: UIViewController {
    let screensize: CGRect = UIScreen.main.bounds
    
    func add(childVC: UIViewController, to containerView: UIView) {
        self.addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    
    func formatCityName(_ str: String) -> String {
        var continent = ""
        var city      = ""
        let arr       = Array(str)
        let arrCount  = arr.count
        
        func getCity(_ startIndex: Int) {
            for i in startIndex..<arrCount {
                if arr[i] == "_" {
                    city += String(" ")
                } else {
                    city += String(arr[i])
                }
            }
        }
        
        for i in 0..<arrCount {
            if arr[i] == "/" {
                getCity(i + 1)
                break
            }
            continent += String(arr[i])
        }
        
        return city
    }
}

