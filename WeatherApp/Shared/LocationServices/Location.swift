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
    var onLocationChanged:((Double,Double) -> Void)?
      
    var latitude = Double()
    var longitude = Double()
    
    var didRecieveLocation: ((Double, Double) -> Void)?
    
    func getCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = locations.last{
            latitude = currentLocation.coordinate.latitude
            longitude = currentLocation.coordinate.longitude
            locationManager.stopUpdatingLocation()
            
            if latitude != 0.0, longitude != 0.0 {
                onLocationChanged?(latitude,longitude)
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
