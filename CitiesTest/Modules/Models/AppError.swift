//
//  AppError.swift
//  CitiesTest
//
//  Created by Aleksandr on 04.10.2022.
//

import Foundation

struct AppError {
    let message: String

    init(message: String) {
        self.message = message
    }
}

extension AppError: LocalizedError {
    var errorDescription: String? { return message }
}
