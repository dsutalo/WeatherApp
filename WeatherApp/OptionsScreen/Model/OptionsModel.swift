//
//  OptionsModel.swift
//  WeatherApp
//
//  Created by Domagoj Sutalo on 14.09.2021..
//

import Foundation

struct OptionsModel: Codable {
    var useCelsius: Bool
    var useFahrenheit: Bool
    var showHumidity: Bool
    var showPressure: Bool
    var showWind: Bool
    
    static func getDefaultOptions() -> OptionsModel {
        OptionsModel(useCelsius: true, useFahrenheit: false, showHumidity: true, showPressure: true, showWind: true)
    }
}
