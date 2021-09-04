//
//  OptionsViewController.swift
//  WeatherApp
//
//  Created by Domagoj Sutalo on 02.09.2021..
//

import UIKit

class OptionsViewController: UIViewController {
    private lazy var optionsView = OptionsView()
    
    override func loadView() {
        self.view = optionsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
