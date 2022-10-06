//
//  MainPresenter.swift
//  CitiesTest
//
//  Created by Aleksandr on 03.10.2022.
//

import UIKit

protocol MainPresenterProtocol: AnyObject {
    func jsonStartedLoading(completion: @escaping ([MainModel])->())
    func searchBarTextDidChange(searchText: String, cities: [MainModel], completion: @escaping ([MainModel])->())
    func tableCellPressed(lat: Double, lon: Double)
}

final class MainPresenter {
    private weak var view: MainViewProtocol?
    private lazy var network = Network()
    
    init(view: MainViewProtocol) {
        self.view = view
    }
}

//MARK: - MainPresenterProtocol
extension MainPresenter: MainPresenterProtocol {
    func jsonStartedLoading(completion: @escaping ([MainModel]) -> ()) {
        JsonParser.shared.loadJson(filename: "city_list", model: [MainModel].self) { result in
            switch result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func searchBarTextDidChange(searchText: String, cities: [MainModel], completion: @escaping ([MainModel])->()) {
        let filteredCities = searchText.isEmpty ? cities : cities.filter({ (model: MainModel) -> Bool in
            return model.name.range(of: searchText, options: .caseInsensitive) != nil
        })
        completion(filteredCities)
    }
    
    func tableCellPressed(lat: Double, lon: Double) {
        self.network.fetchDataCity(lat: lat, lon: lon, model: DescriptionModel.self) { [weak self] result in
            switch result {
            case .success(let data):
                let detailController = DetailController(cityData: [data])
                detailController.modalPresentationStyle = .fullScreen
                let presenter = DetailPresenter(view: detailController)
                detailController.presenter = presenter
                
                self?.view?.presentController(controller: detailController)
            case .failure(let error):
                print(error)
            }
        }
    }
}
