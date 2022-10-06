//
//  MainModel.swift
//  CitiesTest
//
//  Created by Aleksandr on 04.10.2022.
//

struct MainModel: Decodable {
    let id: Int
    let name, state, country: String
    let coord: Coord
}

struct Coord: Decodable {
    let lon, lat: Double
}
