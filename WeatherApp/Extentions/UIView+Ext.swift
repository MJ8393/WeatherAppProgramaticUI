//
//  UIView+Ext.swift
//  WeatherApp
//
//  Created by dev ios on 25/05/22.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
}
