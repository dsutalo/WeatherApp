//
//  OptionsViewController.swift
//  WeatherApp
//
//  Created by Domagoj Sutalo on 02.09.2021..
//

import UIKit

class OptionsViewController: UIViewController {
    private lazy var optionsView = OptionsView()
    var viewModel = OptionsViewModel()
    
    override func loadView() {
        self.view = optionsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addCallbacks()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadOptionsFromUserDefaults()
    }
    
    private func addCallbacks(){

        optionsView.onOptionsChanged = { [weak self] options in
            self?.viewModel.options = options
            self?.viewModel.saveOptionsToUserDefaults()
        }
        
        viewModel.onLoadedOptionsFromUserDefaults = { [weak self] options in
            self?.optionsView.reloadView(newOptions: options)
            
        }
    }
}
