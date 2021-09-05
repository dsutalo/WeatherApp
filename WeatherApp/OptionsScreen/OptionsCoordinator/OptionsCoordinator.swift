//
//  OptionsCoordinator.swift
//  WeatherApp
//
//  Created by Domagoj Sutalo on 05.09.2021..
//

import Foundation
import UIKit

class OptionsCoordinator: Coordinator {
    
    func start() -> UIViewController {
        let vc = createOptionsVC()
        return vc
    }
    
    private func createOptionsVC() -> UIViewController {
        let vc = OptionsViewController()
        let vm = OptionsViewModel()
        
        vc.viewModel = vm
        
        return vc
    }
}
