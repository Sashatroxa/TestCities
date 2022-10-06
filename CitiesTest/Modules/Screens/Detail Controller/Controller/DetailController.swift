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
    func generateRows(section: Sections) -> [Rows] {
        switch section {
        case .weather: return [.description, .currentTemp, .minTemp, .maxTemp, .humidity, .windSpeed]
        }
    }
}

//MARK: - Setup
private extension DetailController {
    func setup() {
        setupUI()
        setupMap()
        setupMarker()
        setupTable()
    }
    
    func setupUI() {
        navigationController?.isNavigationBarHidden = false
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
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "DetailCell", bundle: nil), forCellReuseIdentifier: "DetailCell")
    }
}

//MARK: - UITableViewDelegate
extension DetailController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

//MARK: - UITableViewDataSource
extension DetailController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Sections.allCases.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return generateRows(section: Sections(rawValue: section) ?? .weather).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell") as? DetailCell else { return UITableViewCell() }
        
        let row = generateRows(section: Sections(rawValue: indexPath.section) ?? .weather)[indexPath.row]
        let celsiusText = NSString(format:"%@C", "\u{00B0}") as String
        switch row {
        case .description:
            cell.setText(row.rawValue + ": " + (cityData?.weather.first?.weatherDescription ?? ""))
        case .currentTemp:
            cell.setText(row.rawValue + ": " + (Int((cityData?.main.temp ?? 0) - 273)).description + " " + celsiusText)
        case .minTemp:
            cell.setText(row.rawValue + ": " + (Int((cityData?.main.tempMin ?? 0) - 273)).description + " " + celsiusText)
        case .maxTemp:
            cell.setText(row.rawValue + ": " + (Int((cityData?.main.tempMax ?? 0) - 273)).description + " " + celsiusText)
        case .humidity:
            cell.setText(row.rawValue + ": " + (cityData?.main.humidity.description ?? "") + "%")
        case .windSpeed:
            cell.setText(row.rawValue + ": " + (cityData?.wind.speed.description ?? "") + "m/s")
        }
        
        return cell
    }
}

//MARK: - Enums
private extension DetailController {
    enum Sections: Int, CaseIterable {
        case weather
    }
    
    enum Rows: String {
        case description = "Description"
        case currentTemp = "Current temperature"
        case minTemp = "Minimum temperature"
        case maxTemp = "Maximum temperature"
        case humidity = "Humidity"
        case windSpeed = "Wind speed"
    }
}

//MARK: - DetailViewProtocol
extension DetailController: DetailViewProtocol {
    
}
