//
//  DetailController.swift
//  CitiesTest
//
//  Created by Aleksandr on 06.10.2022.
//

import UIKit
import GoogleMaps

protocol DetailViewProtocol: AnyObject {
    
}

final class DetailController: UIViewController {
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var tableView: UITableView!
    
    private var cityData: DescriptionModel?
    var presenter: DetailPresenterProtocol?
    
    init(cityData: DescriptionModel) {
        self.cityData = cityData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
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
        setupMap()
        setupMarker()
    }
    
    func setupMap() {
        let camera = GMSCameraPosition.camera(withLatitude: cityData?.coord.lat ?? 0, longitude: cityData?.coord.lon ?? 0, zoom: 10.0)
        mapView.camera = camera
    }
    
    func setupMarker() {
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: cityData?.coord.lat ?? 0, longitude: cityData?.coord.lon ?? 0)
        marker.title = cityData?.name ?? ""
        marker.snippet = cityData?.sys.country ?? ""
        marker.map = mapView
    }
    
    func setupTable() {
        
    }
}

//MARK: - DetailViewProtocol
extension DetailController: DetailViewProtocol {
    
}
