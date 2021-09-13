//
//  Array+Extension.swift
//  WeatherApp
//
//  Created by Domagoj Sutalo on 08.09.2021..
//

import Foundation

extension Array where Element: Equatable {
    var unique: [Element] {
        var uniqueValues: [Element] = []
        forEach { item in
            guard !uniqueValues.contains(item) else { return }
            uniqueValues.append(item)
        }
        return uniqueValues
    }
}
