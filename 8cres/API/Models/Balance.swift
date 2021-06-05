//
//  File.swift
//  test
//
//  Created by Alejandro Gallardo alvarez on 5/25/21.
//

import Foundation

struct Balance: Codable {
    let current: Double
    let available, limit: Double?
}

extension Balance {
    init(data: Data) throws {
        self = try JSONDecoder().decode(Balance.self, from: data)
    }
}

