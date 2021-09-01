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
    
    var currentTemp = 0.0
    var minTemp = 0.0
    var maxTemp = 0.0
    var latitude = 0.0
    var longitude = 0.0
    
    let apiKey = "e00d892445a45c9e8ac52763295ae025"
    var locationManger = CLLocationManager()
    var currentCityWeather: Currently?
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocationManager()
        
        setURL()
        convertTemperatures()
        setScreen()
        
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
    

    func setURL(){
        let stringURL = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)"
        if let url = URL(string: stringURL){
            if let data = try? Data(contentsOf: url){
                parse(json: data)
            }
        }
        print("U seturlu \(latitude) \(longitude)")
    }
    
    func parse(json: Data){
        let decoder = JSONDecoder()
        
        if let jsonWeather = try? decoder.decode(Currently.self, from: json){
            currentCityWeather = jsonWeather
            print(jsonWeather.main.temp)
            
        }
    }
    
    func setScreen(){
        guard let currentCity = currentCityWeather else{
            fatalError("Couldnt make an instance of currentCity")
        }
        currentCityLabel.text = currentCity.name
        currentTemperature.text = String(currentTemp)
        currentTemperature.sizeToFit()
        minTemperature.text = "min \n \(minTemp) C"
        maxTemperature.text = "max \n \(maxTemp)"
        humidity.text = "Humidity\n \(currentCity.main.humidity)%"
        pressure.text = "Pressure\n \(currentCity.main.pressure) hpa"
        windSpeed.text = "Wind\n \(currentCity.wind.speed) mph"
        setSymbol()
    }
    
    func setSymbol(){
        guard let currentCity = currentCityWeather else{
            fatalError("Couldnt make an instance of currentCity")
        }
        guard let conditionId = currentCity.weather[0].id else{
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
    
    func kelvinToCelsius(kelvin: Double) -> Double{
        return (kelvin - 273.15).rounded(toPlaces: 1)
    }
    
    func convertTemperatures(){
        guard let currentCity = currentCityWeather else {return}
        currentTemp = kelvinToCelsius(kelvin: currentCity.main.temp)
        minTemp = kelvinToCelsius(kelvin: currentCity.main.temp_min)
        maxTemp = kelvinToCelsius(kelvin: currentCity.main.temp_max)
    }
    
    
}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
