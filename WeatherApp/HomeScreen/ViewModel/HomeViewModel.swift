//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by Domagoj Sutalo on 01.09.2021..
//

import Foundation

class HomeViewModel{
   
    var homeModel: HomeModel?
    let currentWeatherProvider: CurrentWeatherProvider
    init(currentWeatherProvider: CurrentWeatherProvider){
        self.currentWeatherProvider = currentWeatherProvider
    }
    
    func getURLDataForCityName(cityName: String){
        let response = currentWeatherProvider.getWeatherInfoForCityName(cityName: cityName) 
        homeModel = self.getHomeModel(currently: response)
    }

    func getURLDataForCurrentLocation(){
       let response = currentWeatherProvider.getWeatherInfo()
        homeModel = self.getHomeModel(currently: response)
    }
    
    func getHomeModel(currently: Currently) -> HomeModel{
        var homeModel = HomeModel(temp: currently.main.temp, humidity: currently.main.humidity, pressure: currently.main.pressure, temp_min: currently.main.temp_min, temp_max: currently.main.temp_max, name: currently.name, id: currently.weather[0].id, speed: currently.wind.speed)
        
        homeModel.humidity = currently.main.humidity / 100
        homeModel.temp_min = kelvinToCelsius(kelvin: currently.main.temp_min)
        homeModel.temp_max = kelvinToCelsius(kelvin: currently.main.temp_max)
        homeModel.temp = kelvinToCelsius(kelvin: currently.main.temp)
        return homeModel
    }
    
    func kelvinToCelsius(kelvin: Double) -> Double{
        return (kelvin - 273.15).rounded(toPlaces: 1)
    }
    
    func convertCelsiusToFahrenheit(celsius: Double) -> Double {
        return (celsius * 9/5 + 32).rounded(toPlaces: 1)
    }
    
    func getWeatherSymbol() -> String {
        if let homeModel = homeModel {
            switch homeModel.id{
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
        return "cloud"
    }
}
