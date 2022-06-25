//
//  WACityTableViewCell.swift
//  WeatherApp
//
//  Created by dev ios on 24/05/22.
//

import UIKit

class WACityTableViewCell: UITableViewCell {
    static let reuseIdentifier = "CityTableViewCell"
    
    let nameLabel = WALabel(fontSize: 24, fontName: Fonts.temperatureLableFont)

    var cityName: String? {
        didSet {
            nameLabel.text = cityName
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureCell()
        setupUI()
    }
    
    
    private func configureCell() {
        backgroundColor = .systemBackground
        selectionStyle  = .none
    }
    
    
    private func setupUI() {
        addSubview(nameLabel)
        nameLabel.textColor = .label.withAlphaComponent(0.8)
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(20)
        }
    }
}

