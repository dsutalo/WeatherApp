//
//  OptionsViewModel.swift
//  WeatherApp
//
//  Created by Domagoj Sutalo on 14.09.2021..
//

import Foundation
import UIKit

class OptionsViewModel {
    var options: OptionsModel?
    var onLoadedOptionsFromUserDefaults: ((OptionsModel) -> Void)?
  
    func saveOptionsToUserDefaults(){
        do{
            let data = try JSONEncoder().encode(options)
            UserDefaults.standard.setValue(data, forKey: "saveddOptions")
            print("Options saved in OptionsViewModel")
        } catch{
            print("Error while saving settings to user defaults")
        }
    }
    
    func loadOptionsFromUserDefaults(){
        if let savedOptions = UserDefaults.standard.value(forKey: "saveddOptions") as? Data {
            let jsonDecoder = JSONDecoder()
            do{
                let savedOptions = try jsonDecoder.decode(OptionsModel.self, from: savedOptions)
                print("Options loaded from user defaults in optionsViewModel")
                onLoadedOptionsFromUserDefaults?(savedOptions)
               
            } catch{
                print("Failed to fetch saved options")
            }
        }
    }
}
