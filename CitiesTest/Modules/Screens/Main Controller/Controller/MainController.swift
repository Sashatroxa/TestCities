//
//  MainControllerViewController.swift
//  CitiesTest
//
//  Created by Aleksandr on 03.10.2022.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    func pushToController(controller: UIViewController)
}

final class MainController: UIViewController {
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var searchBar: UISearchBar!
    
    private var cities = [MainModel]()
    private var filteredCities = [MainModel]()
    
    var presenter: MainPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        jsonStartLoading()
    }
}

//MARK: - Private methods
private extension MainController {
    func jsonStartLoading() {
        presenter?.jsonStartedLoading(completion: { [weak self] cities in
            self?.cities = cities
            self?.filteredCities = cities
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        })
    }
}

//MARK: - Setup
private extension MainController {
    func setup() {
        setupTable()
        setupSearchBar()
        filteredCities = cities
    }
    
    func setupTable() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "MainCell", bundle: nil), forCellReuseIdentifier: "MainCell")
    }
    
    func setupSearchBar() {
        self.searchBar.delegate = self
    }
}

//MARK: - TableViewDelegate
extension MainController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let latitude = filteredCities[indexPath.row].coord.lat
        let longitude = filteredCities[indexPath.row].coord.lon
        
        let indexPath = IndexPath(row: indexPath.row, section: indexPath.section)
        let cell = tableView.cellForRow(at: indexPath) as! MainCell
        cell.startAnimateIndicator()
        
        self.presenter?.tableCellPressed(lat: latitude, lon: longitude, completion: { [weak cell] in
            cell?.stopAnimateIndicator()
        })
    }
}

//MARK: - TableViewDataSource
extension MainController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCities.count == 0 ? 15 : filteredCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as? MainCell else { return UITableViewCell() }
        
        if filteredCities.count == 0 {
            cell.isEnableSkeleton(isEnable: true)
        } else {
            cell.isEnableSkeleton(isEnable: false)
            cell.setText(filteredCities[indexPath.row].name)
            
            if indexPath.row % 2 == 0 {
                cell.loadImageFromString("https://infotech.gov.ua/storage/img/Temp3.png")
            } else {
                cell.loadImageFromString("https://infotech.gov.ua/storage/img/Temp1.png")
            }
        }
        
        return cell
    }
}

//MARK: - UISearchBarDelegate
extension MainController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.searchBarTextDidChange(searchText: searchText, cities: cities, completion: { [weak self] result in
            self?.filteredCities = result
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        })
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}

//MARK: - MainViewProtocol
extension MainController: MainViewProtocol {
    func pushToController(controller: UIViewController) {
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}
