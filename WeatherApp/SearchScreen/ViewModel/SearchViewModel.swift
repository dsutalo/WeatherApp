//
//  SearchViewModel.swift
//  WeatherApp
//
//  Created by Domagoj Sutalo on 03.09.2021..
//

import Foundation

class SearchViewModel{
    var fetchedCities = [City]()
    var selectedCity: City?
    
    // MARK: - User defaults
    func saveCityToUserDefaults(){
        var savedCities = [City]()
        if let loadedCities = loadCitiesFromUserDefaults() {
            savedCities += loadedCities
        }
        
        if let selectedCity = selectedCity {
            savedCities.append(selectedCity)
            savedCities = savedCities.unique
        }
        
        do{
            let data = try JSONEncoder().encode(savedCities)
            UserDefaults.standard.setValue(data, forKey: "savedCitiesNeww")
            
        } catch{
            print("Error while saving cities")
        }
    }
    
    func loadCitiesFromUserDefaults() -> [City]? {
        if let savedCities = UserDefaults.standard.value(forKey: "savedCitiesNeww") as? Data {
            let jsonDecoder = JSONDecoder()
            do{
                let savedCities = try jsonDecoder.decode([City].self, from: savedCities)
                return savedCities
            } catch{
                print("Failed to load savedCities")
            }
        }
        return Cities.getDefaultCities()
    }
    
    // MARK: - Handling api calls
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
    
    func getResponseForSearchedCity(cityNamed: String) -> [City]{
        let response = self.getSearchedCities(cityNamed: cityNamed)
        return response
    }
}
