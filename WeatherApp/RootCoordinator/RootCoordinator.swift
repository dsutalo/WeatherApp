//
//  RootCoordinator.swift
//  WeatherApp
//
//  Created by Domagoj Sutalo on 04.09.2021..
//

import Foundation
import UIKit

class RootCoordinator: Coordinator{
    var childCoordinator: Coordinator?
   
    func start() -> UIViewController {
        let vc = createHomeVC()
        
        
        return vc
    }
    private func createHomeVC() -> UIViewController{
        let homeCoordinator = HomeCoordinator()
        childCoordinator = homeCoordinator
        return homeCoordinator.start()
    }
    
}
