//
//  OptionsView.swift
//  WeatherApp
//
//  Created by Domagoj Sutalo on 02.09.2021..
//

import Foundation
import UIKit

class OptionsView: UIView {
    var onOptionsChanged: ((OptionsModel) -> Void)?

    private lazy var backgroundImage = UIImageView()
    private lazy var celsiusCheck = Checkbox(defaultValue: true)
    private lazy var fahrenheitCheck = Checkbox(defaultValue: false)
    private lazy var celsiusLabel = UILabel()
    private lazy var fahrenheitLabel = UILabel()
    private lazy var humidityImage = UIImageView()
    private lazy var pressureImage = UIImageView()
    private lazy var windImage = UIImageView()
    private lazy var humidityCheck = Checkbox(defaultValue: true)
    private lazy var pressureCheck = Checkbox(defaultValue: true)
    private lazy var windCheck = Checkbox(defaultValue: true)
    
    private let checkBoxWidthHeight: CGFloat = 35
    private let checkBoxLeadingConstraint: CGFloat = 70
    private let bottomConstant: CGFloat = -150
    private let spaceBetweenCheckBox: CGFloat = 80
    private let spaceBetweenImageAndCheckBox: CGFloat = 20
    private let settingsImageHeightWidth: CGFloat = 75
    private let spaceBetweenFahrenheitAndImage: CGFloat = 190
    private let degreesLeft: CGFloat = 30
    private let spaceBetweenDegrees: CGFloat = 30
    private let labelHeight: CGFloat = 30
    private let labelWidth: CGFloat = 100
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
   
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadView(newOptions: OptionsModel){
        celsiusCheck.isChecked = newOptions.useCelsius
        fahrenheitCheck.isChecked = newOptions.useFahrenheit
        humidityCheck.isChecked = newOptions.showHumidity
        pressureCheck.isChecked = newOptions.showPressure
        windCheck.isChecked = newOptions.showWind
    }
    
    func setupView(){
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.image = UIImage(named: "background")
        backgroundImage.contentMode = .scaleAspectFill
        self.addSubview(backgroundImage)
        
        celsiusCheck.setOpposite(fahrenheitCheck)
        self.addSubview(celsiusCheck)
        
        celsiusLabel.translatesAutoresizingMaskIntoConstraints = false
        celsiusLabel.text = "Celsius"
        celsiusLabel.font = UIFont.systemFont(ofSize: 30)
        celsiusLabel.sizeToFit()
        addSubview(celsiusLabel)
        
        fahrenheitCheck.setOpposite(celsiusCheck)
        self.addSubview(fahrenheitCheck)
        
        fahrenheitLabel.translatesAutoresizingMaskIntoConstraints = false
        fahrenheitLabel.text = "Fahrenheit"
        fahrenheitLabel.font = UIFont.systemFont(ofSize: 30)
        fahrenheitLabel.sizeToFit()
        addSubview(fahrenheitLabel)
        
        humidityImage.translatesAutoresizingMaskIntoConstraints = false
        humidityImage.image = UIImage(named: "humidity")
        humidityImage.contentMode = .scaleAspectFit
        self.addSubview(humidityImage)
        
        pressureImage.translatesAutoresizingMaskIntoConstraints = false
        pressureImage.image = UIImage(named: "pressure")
        humidityImage.contentMode = .scaleAspectFit
        self.addSubview(pressureImage)
        
        windImage.translatesAutoresizingMaskIntoConstraints = false
        windImage.image = UIImage(named: "wind")
        windImage.contentMode = .scaleAspectFit
        self.addSubview(windImage)
        
        humidityCheck.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(humidityCheck)
        pressureCheck.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(pressureCheck)
        windCheck.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(windCheck)
        
        celsiusCheck.addTarget(self, action: #selector(celsiusBoxTapped), for: .touchUpInside)
        fahrenheitCheck.addTarget(self, action: #selector(fahrenheitBoxTapped), for: .touchUpInside)
        humidityCheck.addTarget(self, action: #selector(humidityBoxTapped), for: .touchUpInside)
        pressureCheck.addTarget(self, action: #selector(pressureBoxTapped), for: .touchUpInside)
        windCheck.addTarget(self, action: #selector(windBoxTapped), for: .touchUpInside)

    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            backgroundImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            backgroundImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            backgroundImage.widthAnchor.constraint(equalTo: self.widthAnchor),
            backgroundImage.heightAnchor.constraint(equalTo: self.heightAnchor),
            
            celsiusCheck.widthAnchor.constraint(equalToConstant: checkBoxWidthHeight),
            celsiusCheck.heightAnchor.constraint(equalToConstant: checkBoxWidthHeight),
            celsiusCheck.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,constant: degreesLeft),
            celsiusCheck.bottomAnchor.constraint(equalTo: fahrenheitCheck.topAnchor, constant: -spaceBetweenDegrees),
            
            celsiusLabel.centerYAnchor.constraint(equalTo: celsiusCheck.centerYAnchor),
            celsiusLabel.leadingAnchor.constraint(equalTo: celsiusCheck.trailingAnchor,constant: spaceBetweenImageAndCheckBox),
            
            fahrenheitCheck.widthAnchor.constraint(equalToConstant: checkBoxWidthHeight),
            fahrenheitCheck.heightAnchor.constraint(equalToConstant: checkBoxWidthHeight),
            fahrenheitCheck.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,constant:degreesLeft),
            fahrenheitCheck.bottomAnchor.constraint(equalTo: humidityImage.topAnchor, constant: -spaceBetweenFahrenheitAndImage),
            
            fahrenheitLabel.centerYAnchor.constraint(equalTo: fahrenheitCheck.centerYAnchor),
            fahrenheitLabel.leadingAnchor.constraint(equalTo: fahrenheitCheck.trailingAnchor,constant: spaceBetweenImageAndCheckBox),

            humidityImage.widthAnchor.constraint(equalToConstant: settingsImageHeightWidth),
            humidityImage.heightAnchor.constraint(equalToConstant: settingsImageHeightWidth),
            humidityImage.centerXAnchor.constraint(equalTo: humidityCheck.centerXAnchor),
            humidityImage.bottomAnchor.constraint(equalTo: humidityCheck.topAnchor, constant: -spaceBetweenImageAndCheckBox),
            
            humidityCheck.widthAnchor.constraint(equalToConstant: checkBoxWidthHeight),
            humidityCheck.heightAnchor.constraint(equalToConstant: checkBoxWidthHeight),
            humidityCheck.rightAnchor.constraint(equalTo: pressureCheck.leftAnchor,constant: -checkBoxLeadingConstraint),
            humidityCheck.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: bottomConstant),
            
            pressureImage.widthAnchor.constraint(equalToConstant: settingsImageHeightWidth),
            pressureImage.heightAnchor.constraint(equalToConstant: settingsImageHeightWidth),
            pressureImage.centerXAnchor.constraint(equalTo: pressureCheck.centerXAnchor),
            pressureImage.bottomAnchor.constraint(equalTo: pressureCheck.topAnchor, constant: -spaceBetweenImageAndCheckBox),
            
            pressureCheck.widthAnchor.constraint(equalToConstant: checkBoxWidthHeight),
            pressureCheck.heightAnchor.constraint(equalToConstant: checkBoxWidthHeight),
            pressureCheck.centerXAnchor.constraint(equalTo: centerXAnchor),
            pressureCheck.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: bottomConstant),
            
            windImage.widthAnchor.constraint(equalToConstant: settingsImageHeightWidth),
            windImage.heightAnchor.constraint(equalToConstant: settingsImageHeightWidth),
            windImage.centerXAnchor.constraint(equalTo: windCheck.centerXAnchor),
            windImage.bottomAnchor.constraint(equalTo: windCheck.topAnchor, constant: -spaceBetweenImageAndCheckBox),
            
            windCheck.widthAnchor.constraint(equalToConstant: checkBoxWidthHeight),
            windCheck.heightAnchor.constraint(equalToConstant: checkBoxWidthHeight),
            windCheck.leftAnchor.constraint(equalTo: pressureCheck.rightAnchor,constant: spaceBetweenCheckBox),
            windCheck.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: bottomConstant),
        ])
    }
    
    @objc func celsiusBoxTapped() {
        onOptionsChanged?(self.getCurrentOptios())

    }

    @objc func fahrenheitBoxTapped(){
        onOptionsChanged?(self.getCurrentOptios())

    }

    @objc func humidityBoxTapped(){
        onOptionsChanged?(self.getCurrentOptios())

    }

    @objc func pressureBoxTapped(){
        onOptionsChanged?(self.getCurrentOptios())

    }

    @objc func windBoxTapped(){
        onOptionsChanged?(self.getCurrentOptios())

    }
    
    func getCurrentOptios() -> OptionsModel {
        OptionsModel(useCelsius: celsiusCheck.isChecked, useFahrenheit: fahrenheitCheck.isChecked, showHumidity: humidityCheck.isChecked, showPressure: pressureCheck.isChecked, showWind: windCheck.isChecked)
    }
}
