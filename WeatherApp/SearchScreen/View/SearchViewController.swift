//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by Domagoj Sutalo on 03.09.2021..
//

import UIKit
import CoreLocation

class SearchViewController: UITableViewController {
    @IBOutlet var searchView: UIView!
    @IBOutlet var searchField: UITextField!
    
    var viewModel: SearchViewModel!
    var savedCities = [City]()
    let backgroundImage = UIImage(named: "background")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setScreen()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewModel = SearchViewModel()
    }
    
    func searchButtonTapped(){
        if let locationString = searchField.text, !locationString.isEmpty{
            let cityName = locationString
            savedCities = viewModel.getURLData(cityNamed: cityName)
            print(savedCities.count)
            tableView.reloadData()
        }
    }

    func setScreen(){
        let backgroundImageView = UIImageView(image: backgroundImage)
        backgroundImageView.frame = self.tableView.frame
        self.tableView.backgroundView = backgroundImageView
        searchField.backgroundColor = .lightText
        searchField.alpha = 0.7
        self.tableView.backgroundView?.contentMode = .scaleAspectFill
    }
    
    @IBAction func searchTapped(_ sender: Any) {
        searchButtonTapped()
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedCities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for: indexPath)
        cell.backgroundColor = .clear
        cell.textLabel?.text = savedCities[indexPath.row].name
        cell.detailTextLabel?.text = savedCities[indexPath.row].countryName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCity = savedCities[indexPath.row]
        viewModel.saveToUserDefaults(city: selectedCity)
        let savedCity = viewModel.loadFromUserDefaults()
        savedCities.removeAll()
        savedCities.append(savedCity!)
        print(savedCities)
        }
    }

