//
//  Network.swift
//  CitiesTest
//
//  Created by Aleksandr on 04.10.2022.
//

import Foundation
import Alamofire

final class Network {
    private func generateUrlComponents(scheme: String, host: String, path: String, queryItem: [URLQueryItem]?) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        
        if let queryItem = queryItem {
            urlComponents.queryItems = queryItem
        }
        
        return urlComponents
    }
    
    private func generateUrlRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        return request
    }
    
    private func generateUrlForCity(lat: Double, lon: Double) -> URL? {
        let latQueryItem = URLQueryItem(name: "lat", value: lat.description)
        let lonQueryItem = URLQueryItem(name: "lon", value: lon.description)
        let appIdQueryItem = URLQueryItem(name: "appid", value: openWeatherAppId)
        let queryItems = [latQueryItem, lonQueryItem, appIdQueryItem]
        let urlComponents = generateUrlComponents(
            scheme: "https",
            host: "api.openweathermap.org",
            path: "/data/2.5/weather",
            queryItem: queryItems
        )
        
        return urlComponents.url
    }
}

//MARK: - Open methods
extension Network {
    func fetchDataCity<T: Decodable>(lat: Double, lon: Double, model: T.Type, completion: @escaping (Result<T, Error>)->Void) {
        guard let url = generateUrlForCity(lat: lat, lon: lon) else {
            let error = AppError(message: "Invalid url")
            completion(.failure(error))
            return
        }
        let request = AF.request(generateUrlRequest(url: url))
        
        request.responseDecodable(of: model) { response in
            if let data = response.value {
                completion(.success(data))
            } else if let error = response.error {
                completion(.failure(error))
            }
        }
    }
}
