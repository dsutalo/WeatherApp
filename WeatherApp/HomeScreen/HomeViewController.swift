//
//  ViewController.swift
//  WeatherApp
//
//  Created by Domagoj Sutalo on 31.08.2021..
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet var currentTemperature: UILabel!
    @IBOutlet var currentCityLabel: UILabel!
    @IBOutlet var windSpeed: UILabel!
    @IBOutlet var pressure: UILabel!
    @IBOutlet var humidity: UILabel!
    @IBOutlet var maxTemperature: UILabel!
    @IBOutlet var minTemperature: UILabel!
    @IBOutlet var symbolImageView: UIImageView!
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var currentDegree: UILabel!
    
    var locationManager = Location()
    var currentOptions: OptionsModel!
    var viewModel: HomeViewModel!
    var currentCityWeather: Currently?
    var city: String?
    var homeModel: HomeModel!
    
    init(viewModel: HomeViewModel) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewModel = HomeViewModel(currentWeatherProvider: CurrentWeatherProvider())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.getCurrentLocation()
        locationCallback()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.options = viewModel.fetchOptionsFromUserDefaults()
        optionsCallback()
    }
    
    func locationCallback(){
        locationManager.onLocationChanged = { [weak self] latitude, longitude in
            self?.viewModel.getURLDataForCurrentLocation(latitude: latitude, longitude: longitude)
            self?.viewModel.options = self?.viewModel.fetchOptionsFromUserDefaults()
            self?.optionsCallback()
        }
    }
    
    func optionsCallback() {
        viewModel.onOptionsFetched = { [weak self] homeModel, optinos in
            self?.setScreen(homeModel: homeModel, options: optinos)
        }
    }
    
    func setScreen(homeModel: HomeModel, options: OptionsModel){
        self.homeModel = homeModel
        
        self.homeModel.temp = options.useFahrenheit ? viewModel.convertCelsiusToFahrenheit(celsius: homeModel.temp) : homeModel.temp
        self.homeModel.temp_min = options.useFahrenheit ? viewModel.convertCelsiusToFahrenheit(celsius: homeModel.temp_min) : homeModel.temp_min
        self.homeModel.temp_max = options.useFahrenheit ? viewModel.convertCelsiusToFahrenheit(celsius: homeModel.temp_max) : homeModel.temp_max
        
        let unit = options.useFahrenheit ? "°F" : "°C"
        currentCityLabel.text = homeModel.name
        currentTemperature.text = String(self.homeModel.temp)
        currentDegree.text = unit
        minTemperature.text = "min \n \(self.homeModel.temp_min) " + unit
        maxTemperature.text = "max \n \(self.homeModel.temp_max) " + unit
        humidity.text = "Humidity\n \(homeModel.humidity)%"
        pressure.text = "Pressure\n \(homeModel.pressure) hpa"
        windSpeed.text = "Wind\n \(homeModel.speed) mph"
        setSymbol()
        setNavigationBackButton()
        currentTemperature.sizeToFit()
        currentCityLabel.sizeToFit()
        
        options.showHumidity == true ? stackView.addArrangedSubview(humidity) : humidity.removeFromSuperview()
        options.showPressure == true ? stackView.addArrangedSubview(pressure) : pressure.removeFromSuperview()
        options.showWind == true ? stackView.addArrangedSubview(windSpeed) : windSpeed.removeFromSuperview()
        
    }

    func setSymbol() {
        symbolImageView.image = UIImage(systemName: viewModel.getWeatherSymbol())
    }
    
    func setNavigationBackButton(){
        title = ""
        navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(identifier: "SearchViewController") as? SearchViewController{
            vc.onCityTapped = { [weak self] city in
                DispatchQueue.main.async {
                    self?.viewModel.getURLDataForCityName(cityName: city)
                    self?.viewModel.options = self?.viewModel.fetchOptionsFromUserDefaults()
                    self?.optionsCallback()
                    self?.city = city
                }
            }
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func optionsButtonTapped(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(identifier: "OptionsViewController") as? OptionsViewController{
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}


