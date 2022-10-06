//
//  DescriptionModel.swift
//  CitiesTest
//
//  Created by Aleksandr on 06.10.2022.
//

import Foundation

struct DescriptionModel: Decodable {
    let coord: Coord
    let weather: [Weather]
    let sys: Sys
    let main: Main
    let wind: Wind
    let name: String
}

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

struct Sys: Codable {
    let country: String
}

struct Weather: Decodable {
    let main, weatherDescription: String

    enum CodingKeys: String, CodingKey {
        case main
        case weatherDescription = "description"
    }
}

struct Wind: Decodable {
    let speed: Double
}
