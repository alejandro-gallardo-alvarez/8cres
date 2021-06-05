//
//  File.swift
//  test
//
//  Created by Alejandro Gallardo alvarez on 5/25/21.
//

import Foundation

struct CreateLinkTokenResponse: Codable {
    let linkToken: String
    
    enum CodingKeys: String, CodingKey {
        case linkToken = "link_token"
    }
}

extension CreateLinkTokenResponse {
    init(data: Data) throws {
        self = try JSONDecoder().decode(CreateLinkTokenResponse.self, from: data)
    }
}

