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

struct GetInstitutionResponse: Codable {
    let institution: Institution
}

extension GetInstitutionResponse {
    init(data: Data) throws {
        self = try JSONDecoder().decode(GetInstitutionResponse.self, from: data)
    }
}
