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

struct Account: Codable, CustomStringConvertible {
    let id, name: String
    let type: AccountType
    let mask, officialName: String?
    let balance: Balance
    
    let dateAdded: Date?
    var institution: Institution { return StorageManager.instance.institutionsByID[self.id]! }
    var accessToken: String { return StorageManager.instance.accessToken(for: self.id)! }
    
    enum CodingKeys: String, CodingKey {
        case name, mask, type, dateAdded
        case id = "account_id"
        case officialName = "official_name"
        case balance = "balances"
    }
    
    enum AccountType: String, Codable, Equatable {
        case investment, credit, depository, loan, other
    }
    
    var description: String {
        return "Account ID: \(id), name: \(name), type: \(type), balance: \(balance.current)"
    }
}

extension Account: Equatable {
    init(data: Data) throws {
        self = try JSONDecoder().decode(Account.self, from: data)
    }
    
    func updateDateAdded() -> Account {
        return Account(
            id: self.id,
            name: self.name,
            type: self.type,
            mask: self.mask,
            officialName: self.officialName,
            balance: self.balance,
            dateAdded: Date())
    }
    
    func updateBalance(balance: Balance) -> Account {
        return Account(
            id: self.id,
            name: self.name,
            type: self.type,
            mask: self.mask,
            officialName: self.officialName,
            balance: balance,
            dateAdded: self.dateAdded)
    }
    
    static func == (lhs: Account, rhs: Account) -> Bool {
        return lhs.id == rhs.id
    }
}


