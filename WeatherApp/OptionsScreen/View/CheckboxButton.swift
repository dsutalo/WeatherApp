//
//  CheckboxButton.swift
//  WeatherApp
//
//  Created by Domagoj Sutalo on 02.09.2021..
//

import UIKit

class Checkbox: UIButton {
    var isChecked: Bool! {
        didSet {
            updateImage()
        }
    }
    
    private weak var oppositeCheckbox: Checkbox?
    
    required init(defaultValue: Bool) {
        self.isChecked = defaultValue
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.backgroundColor = UIColor.white.cgColor
        self.addTarget(self, action: #selector(onCheckboxTap), for: .touchUpInside)
        updateImage()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setOpposite(_ opposite: Checkbox) {
        self.oppositeCheckbox = opposite
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
