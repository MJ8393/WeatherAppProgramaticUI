//
//  WAHourlyCollectionViewCell.swift
//  WeatherApp
//
//  Created by dev ios on 24/05/22.
//

import UIKit

class WAHourlyCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "HourlyCollectionViewCell"
    
    let hourlyDateLabel      = WALabel(fontSize: 20, fontName: Fonts.temperatureLableFont)
    let conditionImageView   = WAConditionImageView(frame: .zero)
    let temperatureLabel     = WALabel(fontSize: 34, fontName: Fonts.temperatureLableFont)
    
    var item: WAHourlyViewModel? {
        didSet {
            if let item = item {
                hourlyDateLabel.text       = item.date
                conditionImageView.image   = item.image
                temperatureLabel.text      = item.temperature
            }
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureCell()
        setupUI()
    }
    
    
    func configureCell() {
        backgroundColor      = .systemBlue.withAlphaComponent(0.5)
        layer.cornerRadius   = 14
        layer.masksToBounds  = true
        layer.shadowColor    = UIColor.black.cgColor
        layer.shadowOpacity  = 1
        layer.shadowOffset   = .zero
        layer.shadowRadius   = 10
    }
    
    
    private func setupUI() {
        addSubviews(hourlyDateLabel, conditionImageView, temperatureLabel)

        hourlyDateLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(10)
        }
        

        conditionImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-10)
            make.height.width.equalTo(70)
        }
        
        
        temperatureLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(-10)
        }
    }
}

