//
//  Cities.swift
//  WeatherApp
//
//  Created by Domagoj Sutalo on 03.09.2021..
//

import Foundation

struct Cities: Codable{
    var geonames: [City]
    
    static func getDefaultCities() -> [City] {
        return [City(name: "Zagreb", countryName: "Croatia")]
    }
}


