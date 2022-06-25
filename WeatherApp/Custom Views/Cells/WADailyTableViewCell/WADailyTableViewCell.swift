//
//  WADailyTableViewCell.swift
//  WeatherApp
//
//  Created by dev ios on 24/05/22.
//

import UIKit

class WADailyTableViewCell: UITableViewCell {
    static let reuseIdentifier = "DailyTableViewCell"
    
    let dayLabel             = WALabel(fontSize: 20, fontName: Fonts.temperatureLableFont)
    let conditionImageView   = WAConditionImageView(frame: .zero)
    let temperatureLabel     = WALabel(fontSize: 24, fontName: Fonts.temperatureLableFont)
    let stackView = UIStackView()
    
    let emptyView = UIView()
    
    
    var item: WADailyTableVM? {
        didSet {
            if let item = item {
                dayLabel.text            = item.date
                temperatureLabel.text    = item.temp
                conditionImageView.image = item.image
            }
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureCell()
        configureStackView()
        setupUI()
    }
    
    
    private func configureCell() {
        backgroundColor = .systemBackground
        selectionStyle  = .none
    }
    
    
    private func configureStackView() {
        stackView.backgroundColor      = .systemGray.withAlphaComponent(0.5)
        stackView.layer.shadowColor    = UIColor.systemBlue.cgColor
        stackView.layer.shadowOpacity  = 1
        stackView.layer.shadowOffset   = .zero
        stackView.layer.shadowRadius   = 2
        stackView.layer.cornerRadius   = 10
        
        stackView.axis                 = .horizontal
        stackView.distribution         = .fillEqually

        stackView.addArrangedSubview(dayLabel)
        stackView.addArrangedSubview(temperatureLabel)
        stackView.addArrangedSubview(emptyView)
    }
    
    
    private func setupUI() {
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(8)
            make.bottom.equalTo(-8)
        }
        
        dayLabel.textAlignment         = .center
        temperatureLabel.textAlignment = .center
        
        emptyView.addSubview(conditionImageView)
        conditionImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(40)
        }
    }
}

