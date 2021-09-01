//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by Domagoj Sutalo on 01.09.2021..
//

import Foundation

protocol HomeViewModelDelegate {
    func reloadView()
}

class HomeViewModel{
    var delegate: HomeViewModelDelegate!
    
    var homeModel: HomeModel?
    let currentWeatherProvider: CurrentWeatherProvider
    init(currentWeatherProvider: CurrentWeatherProvider){
        self.currentWeatherProvider = currentWeatherProvider
    }
    
    func getData(){
        let response = currentWeatherProvider.getWeatherInfo(latitude: Constants.latitude, longitude: Constants.longitude)
        homeModel = self.getHomeModel(currently: response!)
        delegate.reloadView()
        
    }
    
    func getHomeModel(currently: Currently) -> HomeModel{
        var homeModel = HomeModel(temp: currently.main.temp, humidity: currently.main.humidity, pressure: currently.main.pressure, temp_min: currently.main.temp_min, temp_max: currently.main.temp_max, name: currently.name, speed: currently.wind.speed)
        
        homeModel.temp_min = kelvinToCelsius(kelvin: currently.main.temp_min)
        homeModel.temp_max = kelvinToCelsius(kelvin: currently.main.temp_max)
        homeModel.temp = kelvinToCelsius(kelvin: currently.main.temp)
        
        return homeModel
    }
    
    func kelvinToCelsius(kelvin: Double) -> Double{
        return (kelvin - 273.15).rounded(toPlaces: 1)
    }
    
    
}
