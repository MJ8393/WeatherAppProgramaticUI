//
//  WALabel.swift
//  WeatherApp
//
//  Created by dev ios on 25/05/22.
//

import UIKit

class WALabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(fontSize: CGFloat, fontName: String) {
        self.init(frame: .zero)
        font = UIFont(name: fontName, size: fontSize)
    }
    
    
    func configure() {
        textColor                   = .white
        adjustsFontSizeToFitWidth   = true
        minimumScaleFactor          = 0.9
        lineBreakMode               = .byTruncatingTail
    }
}

