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
    var onCityTapped: ((String) -> Void)?
    let backgroundImage = UIImage(named: "background")

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewModel = SearchViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let loadedCities = viewModel.loadCitiesFromUserDefaults() {
            viewModel.fetchedCities = loadedCities
        }
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setScreen()
    }
    
    func searchButtonTapped(){
        if let locationString = searchField.text, !locationString.isEmpty{
            viewModel.fetchedCities = viewModel.getResponseForSearchedCity(cityNamed: locationString)
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
        return viewModel.fetchedCities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for: indexPath)
        cell.backgroundColor = .clear
        cell.textLabel?.text = viewModel.fetchedCities[indexPath.row].name
        cell.detailTextLabel?.text = viewModel.fetchedCities[indexPath.row].countryName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectedCity = viewModel.fetchedCities[indexPath.row]
        guard let selectedCity = viewModel.selectedCity else {
            fatalError("selectedCity is nil")
        }
        viewModel.fetchedCities.append(selectedCity)
        viewModel.saveCityToUserDefaults()
        onCityTapped?(selectedCity.name)
        navigationController?.popViewController(animated: true)
        }
    }

