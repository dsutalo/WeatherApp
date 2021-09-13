//
//  Location.swift
//  WeatherApp
//
//  Created by Domagoj Sutalo on 02.09.2021..
//

import Foundation
import UIKit
import CoreLocation

class Location: NSObject, CLLocationManagerDelegate{
    var constants = Constants()
    var locationManager: CLLocationManager!
      
    var latitude = Double()
    var longitude = Double()
    
    var didRecieveLocation: ((Double, Double) -> Void)?
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = locations.last{
            latitude = currentLocation.coordinate.latitude
            longitude = currentLocation.coordinate.longitude
            locationManager.stopUpdatingLocation()
        }
    }
    func getCurrenntLocationURL() -> String {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        return constants.setURL(latitude: latitude, longitude: longitude)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }

}
