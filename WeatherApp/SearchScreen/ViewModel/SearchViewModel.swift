//
//  SearchViewModel.swift
//  WeatherApp
//
//  Created by Domagoj Sutalo on 03.09.2021..
//

import Foundation

class SearchViewModel{
    
    func getURLData(cityNamed: String) -> [City]{
        let response = self.getSearchedCities(cityNamed: cityNamed)
        return response
    }
    
    func saveToUserDefaults(city: City){
        do {
            let data = try JSONEncoder().encode(city)
            UserDefaults.standard.set(data, forKey: "savedCity")
        } catch{
            print("Unable to Encode city")
        }
    }
    
    func saveToUserDefaults(selectedCity: City?){
        do{
            let data = try JSONEncoder().encode(selectedCity)
            UserDefaults.standard.setValue(data, forKey: "selectedCity")

        } catch{
            print("Error")
        }
    }

    func loadFromUserDefaults() -> City? {
        if let savedCity = UserDefaults.standard.value(forKey: "selectedCity") as? Data {
            let jsonDecoder = JSONDecoder()

            do{
                let savedCity = try jsonDecoder.decode(City.self, from: savedCity)
                print(savedCity.name)
                return savedCity
            } catch{
                print("Failed")
            }
            
        }
        return nil
    }

    func getSearchedCities(cityNamed: String) -> [City]{
             let stringURL = "http://api.geonames.org/searchJSON?q=\(cityNamed)&maxRows=10&username=tgelesic"
             if let url = URL(string: stringURL){
                 if let data = try? Data(contentsOf: url){
                     return parse(json: data)
                 }
             }
            return [City]()
         }

         func parse(json: Data) -> [City]{
             let decoder = JSONDecoder()

             if let jsonCities = try? decoder.decode(Cities.self, from: json){
                return jsonCities.geonames
             }
            return [City]()
         }
}
