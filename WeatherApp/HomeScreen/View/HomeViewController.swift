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
    
    var viewModel: HomeViewModel!
    var currentCityWeather: Currently?
    var city: String?
    
    init(viewModel: HomeViewModel) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewModel = HomeViewModel(currentWeatherProvider: CurrentWeatherProvider())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getURLDataForCurrentLocation()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if city == nil {
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000), execute: {
                self.viewModel.getURLDataForCurrentLocation()
                self.reloadView()
            })
        }
    }
    
    func reloadView() {
        setScreen()
    }
    
    func setScreen(){
        guard let homeModel = viewModel.homeModel else{
            fatalError("Couldnt make an instance of currentCity")
        }
        currentCityLabel.text = homeModel.name
        currentTemperature.text = String(homeModel.temp)
        minTemperature.text = "min \n \(homeModel.temp_min) C"
        maxTemperature.text = "max \n \(homeModel.temp_max) C"
        humidity.text = "Humidity\n \(homeModel.humidity)%"
        pressure.text = "Pressure\n \(homeModel.pressure) hpa"
        windSpeed.text = "Wind\n \(homeModel.speed) mph"
        setSymbol()
    }
    
    func setSymbol(){
        symbolImageView.image = UIImage(systemName: viewModel.getWeatherSymbol())
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(identifier: "SearchViewController") as? SearchViewController{
            vc.onCityTapped = { [weak self] city in
                DispatchQueue.main.async {
                    self?.viewModel.getURLDataForCityName(cityName: city)
                    self?.reloadView()
                    self?.city = city
                }
            }
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}


