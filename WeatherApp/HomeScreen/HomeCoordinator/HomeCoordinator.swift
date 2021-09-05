//
//  HomeCoordinator.swift
//  WeatherApp
//
//  Created by Domagoj Sutalo on 04.09.2021..
//

import Foundation
import UIKit

class HomeCoordinator: Coordinator {
    let currentWeatherProvider = CurrentWeatherProvider()
    let navigationController = UINavigationController()
    

    func start() -> UIViewController {
        let vc = createHomeVC()
        
        //add navigationController settings
        navigationController.showAsRoot()
        navigationController.pushViewController(vc, animated: true)
        print("inside start function of HomeCoordinator")
        return navigationController
    }
    
    private func createHomeVC() -> UIViewController{
        let vc = HomeViewController()
        let vm = HomeViewModel(currentWeatherProvider: currentWeatherProvider)
        
        
        vm.optionsPressed = { [weak self] in
            self?.showOptionsVC()
            print("HomeCoordinator options pressed")
            
        }
        
        vc.viewModel = vm
        return vc
    }
    
    private func showOptionsVC(){
        let coordinator = OptionsCoordinator()
        let vc = coordinator.start()
        navigationController.pushViewController(vc, animated: true)
    }
}
