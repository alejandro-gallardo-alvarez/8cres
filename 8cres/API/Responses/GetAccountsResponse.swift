//
//  File.swift
//  test
//
//  Created by Alejandro Gallardo alvarez on 5/25/21.
//

import Foundation

struct GetAccountsResponse: Codable {
    let accounts: [Account]
}

extension GetAccountsResponse {
    init(data: Data) throws {
        self = try JSONDecoder().decode(GetAccountsResponse.self, from: data)
    }
}
