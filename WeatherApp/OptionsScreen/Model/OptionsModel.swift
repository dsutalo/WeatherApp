//
//  Options.swift
//  WeatherApp
//
//  Created by Domagoj Sutalo on 05.09.2021..
//

import Foundation

struct OptionsModel: Codable{
    var isCelsius : Bool
    var isFarenheit : Bool
    var showHumidity : Bool
    var showPressure : Bool
    var showWind : Bool
}
