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

struct Institution: Codable {
    let name, id: String
    let primaryColour, logo: String?
    var colour: String {
        return (primaryColour == nil || primaryColour! == "#ffffff") ? "#dddddd" : primaryColour!
    }

    enum CodingKeys: String, CodingKey {
        case name, logo
        case id = "institution_id"
        case primaryColour = "primary_color"
    }
}

extension Institution {
    init(data: Data) throws {
        self = try JSONDecoder().decode(Institution.self, from: data)
    }
}

