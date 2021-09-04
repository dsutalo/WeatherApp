//
//  CheckboxButton.swift
//  WeatherApp
//
//  Created by Domagoj Sutalo on 02.09.2021..
//

import UIKit

class Checkbox: UIButton {

    private var userDefaultsKey: String!
    var isChecked: Bool!
    
    private weak var oppositeCheckbox: Checkbox?

    required init() {
        self.isChecked = false
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.backgroundColor = UIColor.white.cgColor
        self.addTarget(self, action: #selector(onCheckboxTap), for: .touchUpInside)
        
        updateImage()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func onCheckboxTap(sender: UIButton) {
        flipState()
        oppositeCheckbox?.flipState()
    }

    private func flipState() {
        isChecked.toggle()
        updateImage()
    }
    
    private func updateImage() {
        if isChecked {
            self.setImage(UIImage(named: "check")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        } else {
            self.setImage(.none, for: .normal)
        }
    }
    
}
