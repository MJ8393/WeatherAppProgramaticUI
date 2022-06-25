//
//  WAMainVC.swift
//  WeatherApp
//
//  Created by dev ios on 24/05/22.
//

import Foundation

import UIKit
import SnapKit
import CoreLocation

protocol WASearchTableVCDelegate: AnyObject {
    func getCityInfo(for city: City)
}

class WAMainVC: BaseVC {
    let locationManager = CLLocationManager()
    
    var scrollView: UIScrollView!
    let headerView = UIView()
    let middleView = UIView()
    let footerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureScrollView()
        setupUI()
        getlocationData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollView.contentSize = CGSize(width: screensize.width, height: headerView.frame.height + middleView.frame.height + footerView.frame.height + 20)
    }
    
    private func configureViewController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        let rightButton                    = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTapped))
        navigationItem.rightBarButtonItem  = rightButton
        view.backgroundColor = .systemBackground
    }
    
    private func configureScrollView() {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: screensize.width, height: screensize.height))
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)
    }
    
    private func setupUI() {
        scrollView.addSubviews(headerView, middleView, footerView)
        
        headerView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top).offset(10)
            make.centerX.equalTo(scrollView)
            make.width.equalTo(screensize.width - 30)
            make.height.equalTo(220)
        }
        
        middleView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.centerX.equalTo(scrollView)
            make.width.equalTo(screensize.width)
            make.height.equalTo(220)
        }
        
        footerView.snp.makeConstraints { make in
            make.top.equalTo(middleView.snp.bottom).offset(-5)
            make.centerX.equalTo(scrollView)
            make.width.equalTo(screensize.width - 30)
            make.height.equalTo(960)
        }
    }
    
    func getlocationData() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func getWeatherData(lat: CLLocationDegrees, lon: CLLocationDegrees, cityName: String? = nil) {
        NetworkManager.shared.performRequest(lat: lat, lon: lon) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let allWearherInfo):
                DispatchQueue.main.async {
                    self.title = cityName ?? self.formatCityName(allWearherInfo.timezone)
                    self.add(childVC: WACurrentVC(WACurrentViewModel(allWearherInfo.current)), to: self.headerView)
                    self.add(childVC: WAHourlyCollectionVC(allWearherInfo.hourly), to: self.middleView)
                    self.add(childVC: WADailyTableVC(allWearherInfo.daily), to: self.footerView)
                }
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    @objc func searchButtonTapped() {
        navigationController?.pushViewController(WASearchTableVC(delegate: self), animated: true)
    }
}

fileprivate var requestAgainForFirstTime = true

extension WAMainVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        guard let location = locations.last else {
            return
        }
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        getWeatherData(lat: lat, lon: lon)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if requestAgainForFirstTime {
            locationManager.requestLocation()
            requestAgainForFirstTime = false
        } else {
            let title       = "Problem with your current location data."
            let message     = "You didn't allow to use your location data. But if you want to know current weather for where you are. Go to Settings and turn on Location Service for this app."
            let buttonText  = "Ok"
            
            let alert       = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action      = UIAlertAction(title: buttonText, style: .default) {_ in
                let tashkentCoordinate = (41.2995, 69.2401)
                self.getWeatherData(lat: tashkentCoordinate.0, lon: tashkentCoordinate.1)
            }
            
            alert.addAction(action)
            present(alert, animated: true)
        }
    }
}


extension WAMainVC: WASearchTableVCDelegate {
    func getCityInfo(for city: City) {
        guard let lat = CLLocationDegrees(city.lat), let lon = CLLocationDegrees(city.lng) else {
            print(WAError.gettingCoordinate)
            return
        }
        getWeatherData(lat: lat, lon: lon, cityName: city.name)
    }
}
