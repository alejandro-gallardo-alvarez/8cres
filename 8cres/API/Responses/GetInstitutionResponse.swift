//
//  File.swift
//  test
//
//  Created by Alejandro Gallardo alvarez on 5/25/21.
//

import Foundation

struct GetInstitutionResponse: Codable {
    let institution: Institution
}

extension GetInstitutionResponse {
    init(data: Data) throws {
        self = try JSONDecoder().decode(GetInstitutionResponse.self, from: data)
    }
}
