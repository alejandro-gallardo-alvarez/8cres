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

