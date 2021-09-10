//
//  Currently.swift
//  WeatherApp
//
//  Created by Domagoj Sutalo on 31.08.2021..
//

import Foundation

struct Currently: Codable {
    var main: Main
    var wind: Wind
    var id: Int
    var name: String
    var weather: [Weather]
    
    struct Main: Codable {
        var temp: Double
        var humidity: Double
        var pressure: Int
        var temp_min: Double
        var temp_max: Double
    }
    
    struct Wind: Codable {
        var speed: Double
    }
    
    struct Weather: Codable {
        var id: Int
    }
    
    static func getDefaultWeather() -> Currently {
        return Currently(main: Main(temp: 20, humidity: 75, pressure: 1000, temp_min: 20, temp_max: 20), wind: Wind(speed: 7.5), id: 2643743, name: "London", weather: [Weather(id: 800)])
    }
}
