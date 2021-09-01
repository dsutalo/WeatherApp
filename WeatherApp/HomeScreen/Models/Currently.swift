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
}
