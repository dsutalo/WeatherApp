//
//  Constants.swift
//  WeatherApp
//
//  Created by Domagoj Sutalo on 01.09.2021..
//

import Foundation

struct Constants{
    let apiKey = "e00d892445a45c9e8ac52763295ae025"
    func setURL(latitude: Double, longitude: Double) -> String{
        "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)"
    }
    static let latitude = 45.18
    static let longitude = 18.5
    
    
}
