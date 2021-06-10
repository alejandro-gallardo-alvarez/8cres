//
//  File.swift
//  test
//
//  Created by Alejandro Gallardo alvarez on 5/25/21.
//
// We used some tutorials and code that we found online at :
// https://github.com/plaid/plaid-link-ios
// https://github.com/jessica-huynh/Knot

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

