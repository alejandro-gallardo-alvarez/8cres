//
//  File.swift
//  test
//
//  Created by Alejandro Gallardo alvarez on 5/25/21.
//

import Foundation
import UIKit

struct GetTransactionsResponse: Codable {
    let transactions: [Transaction]
}

extension GetTransactionsResponse {
    init(data: Data) throws {
        self = try JSONDecoder().decode(GetTransactionsResponse.self, from: data)
    }
}
