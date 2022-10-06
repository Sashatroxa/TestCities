//
//  DescriptionModel.swift
//  CitiesTest
//
//  Created by Aleksandr on 06.10.2022.
//

import Foundation

struct DescriptionModel: Decodable {
    let weather: [Weather]
    let main: Main
    let wind: Wind
}

// MARK: - Main
struct Main: Decodable {
    let temp, tempMin, tempMax: Double
    let humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case humidity
    }
}

// MARK: - Weather
struct Weather: Decodable {
    let main, weatherDescription: String

    enum CodingKeys: String, CodingKey {
        case main
        case weatherDescription = "description"
    }
}

// MARK: - Wind
struct Wind: Decodable {
    let speed: Double
}
