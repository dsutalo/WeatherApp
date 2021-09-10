//
//  CurrentWeatherProvider.swift
//  WeatherApp
//
//  Created by Domagoj Sutalo on 01.09.2021..
//

import Foundation
import UIKit

class CurrentWeatherProvider {
    let constants = Constants()
    let currentLocation = Location()
    
    func getWeatherInfo() -> Currently{
        let stringURL = currentLocation.getCurrenntLocationURL()
        if let url = URL(string: stringURL){
            if let data = try? Data(contentsOf: url){
                return parse(json: data)
            }
        }
        return Currently.getDefaultWeather()
    }
    
    func parse(json: Data) -> Currently{
        let decoder = JSONDecoder()
        if let jsonWeather = try? decoder.decode(Currently.self, from: json){
            return jsonWeather
        }
        return Currently.getDefaultWeather()
    }
    
    func getWeatherInfoForCityName(cityName: String) -> Currently{
        let stringURL = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(Constants.apiKey)"
        if let url = URL(string: stringURL){
            if let data = try? Data(contentsOf: url){
                return parse(json: data)
            }
        }
        return Currently.getDefaultWeather()
    }
        
}
