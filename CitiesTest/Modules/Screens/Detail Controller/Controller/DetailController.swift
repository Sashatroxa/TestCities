//
//  DetailController.swift
//  CitiesTest
//
//  Created by Aleksandr on 06.10.2022.
//

import UIKit

protocol DetailViewProtocol: AnyObject {
    
}

final class DetailController: UIViewController {
    private var cityData = [DescriptionModel]()
    
    var presenter: DetailPresenterProtocol?
    
    init(cityData: [DescriptionModel]) {
        super.init(nibName: nil, bundle: nil)
        self.cityData = cityData
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
}

//MARK: - Private methods
private extension DetailController {
}

//MARK: - Setup
private extension DetailController {
    func setup() {
        
    }
    
    func setupTable() {
        
    }
}

//MARK: - DetailViewProtocol
extension DetailController: DetailViewProtocol {
    
}
