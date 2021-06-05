//
//  File.swift
//  test
//
//  Created by Alejandro Gallardo alvarez on 5/25/21.
//

import Foundation

struct ExchangeTokenResponse: Codable {
    let accessToken, itemID: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case itemID = "item_id"
    }
}

extension ExchangeTokenResponse {
    init(data: Data) throws {
        self = try JSONDecoder().decode(ExchangeTokenResponse.self, from: data)
    }
}

