//
//  JsonParser.swift
//  CitiesTest
//
//  Created by Aleksandr on 04.10.2022.
//

import Foundation

final class JsonParser {
    static let shared = JsonParser()
    
    func loadJson<T: Decodable>(filename fileName: String, model: T.Type, completion: @escaping (Result<T, Error>)->Void ) {
        DispatchQueue.global(qos: .userInteractive).async {
            if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode(model, from: data)
                    completion(.success(jsonData))
                } catch {
                    completion(.failure(error))
                }
            } else {
                let error = AppError(message: "Invalid json url")
                completion(.failure(error))
            }
        }
    }
}
