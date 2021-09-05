//
//  Coordinator.swift
//  WeatherApp
//
//  Created by Domagoj Sutalo on 04.09.2021..
//

import Foundation
import UIKit

public protocol Coordinator: AnyObject {
    @discardableResult
    func start() -> UIViewController
}
