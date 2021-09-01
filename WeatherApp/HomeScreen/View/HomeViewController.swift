//
//  ViewController.swift
//  WeatherApp
//
//  Created by Domagoj Sutalo on 31.08.2021..
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController, CLLocationManagerDelegate, HomeViewModelDelegate {
    
    
    
    @IBOutlet var currentTemperature: UILabel!
    @IBOutlet var currentCityLabel: UILabel!
    @IBOutlet var windSpeed: UILabel!
    @IBOutlet var pressure: UILabel!
    @IBOutlet var humidity: UILabel!
    @IBOutlet var maxTemperature: UILabel!
    @IBOutlet var minTemperature: UILabel!
    @IBOutlet var symbolImageView: UIImageView!
    
    var currentTemp = 0.0
    var minTemp = 0.0
    var maxTemp = 0.0
    var latitude = 0.0
    var longitude = 0.0
    
    var viewModel: HomeViewModel!
    var locationManger = CLLocationManager()
    var currentCityWeather: Currently?
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocationManager()
    }
    
    init(viewModel: HomeViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        viewModel.delegate = self
        
    }

    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getData()
    }
    
    func setLocationManager(){
        self.locationManger.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManger.delegate = self
            locationManger.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManger.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let localValue: CLLocationCoordinate2D = manager.location?.coordinate else {return}
        latitude = localValue.latitude
        longitude = localValue.longitude
        print("locations = \(latitude), \(longitude)")
    }
    

    
    
    func setScreen(){
        guard let homeModel = viewModel.homeModel else{
            fatalError("Couldnt make an instance of currentCity")
        }
        currentCityLabel.text = homeModel.name
        currentTemperature.text = String(homeModel.temp)
        currentTemperature.sizeToFit()
        minTemperature.text = "min \n \(homeModel.temp_min) C"
        maxTemperature.text = "max \n \(homeModel.temp_max)"
        humidity.text = "Humidity\n \(homeModel.humidity)%"
        pressure.text = "Pressure\n \(homeModel.pressure) hpa"
        windSpeed.text = "Wind\n \(homeModel.speed) mph"
        setSymbol()
    }
    
    func setSymbol(){
        guard let homeModel = viewModel.homeModel else{
            fatalError("Couldnt make an instance of currentCity")
        }
        guard let conditionId = homeModel.id else{
            fatalError("Couldnt make conditionId instance")
        }
        var conditionName: String{
            switch conditionId{
            case 200...232:
                return "cloud.bolt"
            case 300...321:
                return "cloud.drizzle"
            case 500...531:
                return "cloud.rain"
            case 600...622:
                return "cloud.snow"
            case 701...781:
                return "cloud.fog"
            case 800:
                return "sun.max"
            case 801...804:
                return "cloud.bolt"
            default:
                return "cloud"
            }
        }
        symbolImageView.image = UIImage(systemName: conditionName)
        print(conditionId)
    }
    
    func reloadView() {
        setScreen()
    }
    
    
}


