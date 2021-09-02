//
//  Location.swift
//  WeatherApp
//
//  Created by Domagoj Sutalo on 02.09.2021..
//

import Foundation
import UIKit
import CoreLocation

class Location: NSObject, CLLocationManagerDelegate {
    var locationManger = CLLocationManager()
    let constants = Constants()
    var currentLocation: CLLocation!
    
    func getCurrenntLocationURL() -> String{
        
        var stringURL = ""
        self.locationManger.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            let currentLocationLatitude = locationManger.location?.coordinate.latitude ?? Constants.latitude
            let currentLocationLongitude = locationManger.location?.coordinate.latitude ?? Constants.longitude
            stringURL = constants.setURL(latitude: currentLocationLatitude, longitude: currentLocationLongitude)
            
        }
        return stringURL
    }
}

