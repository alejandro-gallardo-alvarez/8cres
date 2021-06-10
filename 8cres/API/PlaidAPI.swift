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
import Moya

enum PlaidAPI {
    static let clientID = PlaidManager.instance.clientID
    static let secret = PlaidManager.instance.secret
    static let environment = PlaidManager.instance.environment
    
    static var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }
    
    case createLinkToken
    case exchangeTokens(publicToken: String)
    case getAccounts(accessToken: String, accountIDs: [String]? = nil)
    case getTransactions(accessToken: String, startDate: Date, endDate: Date, accountIDs: [String]? = nil)
    case getInstitution(institutionID: String)
}

extension PlaidAPI: TargetType {
    public var baseURL: URL {
        return URL(string: "https://\(PlaidAPI.environment).plaid.com")!
    }

    public var path: String {
        switch self {
        case .createLinkToken:
            return "/link/token/create"
        case .exchangeTokens:
            return "/item/public_token/exchange"
        case .getAccounts:
            return "/accounts/balance/get"
        case .getTransactions:
            return "/transactions/get"
        case .getInstitution:
            return "/institutions/get_by_id"
        }
    }

    public var method: Moya.Method {
        return .post
    }

    public var sampleData: Data {
        return Data()
    }

    public var task: Task {
        switch self {
        case .createLinkToken:
            return .requestParameters(
                parameters: [
                    "client_id": PlaidAPI.clientID,
                    "secret": PlaidAPI.secret,
                    "client_name": (Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String),
                    "language": "en",
                    "country_codes": ["CA", "US"],
                    "user": ["client_user_id": "me"],
                    "products": ["transactions"]],
                encoding: JSONEncoding.default)
        case .exchangeTokens(let publicToken):
            return .requestParameters(
                parameters: [
                    "client_id": PlaidAPI.clientID,
                    "secret": PlaidAPI.secret,
                    "public_token": publicToken],
                encoding: JSONEncoding.default)
            
        case .getAccounts(let accessToken, let accountIDs):
            return .requestParameters(
            parameters: [
                "client_id": PlaidAPI.clientID,
                "secret": PlaidAPI.secret,
                "access_token": accessToken,
                "options": [
                    "account_ids": accountIDs as Any]],
            encoding: JSONEncoding.default)
            
        case .getTransactions(let accessToken, let startDate, let endDate, let accountIDs):
            return .requestParameters(
            parameters: [
                "client_id": PlaidAPI.clientID,
                "secret": PlaidAPI.secret,
                "access_token": accessToken,
                "start_date": PlaidAPI.dateFormatter.string(from: startDate),
                "end_date": PlaidAPI.dateFormatter.string(from: endDate),
                "options": [
                    "count": 250,
                    "offset": 100,
                    "account_ids": accountIDs as Any]],
            encoding: JSONEncoding.default)
        case .getInstitution(let institutionID):
            return .requestParameters(
            parameters: [
                "institution_id": institutionID,
                "client_id": PlaidAPI.clientID,
                "secret": PlaidAPI.secret,
                "country_codes": ["CA", "US"],
                "options": ["include_optional_metadata": true]],
            encoding: JSONEncoding.default)
        }
    }

    public var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }

    public var validationType: ValidationType {
        return .successCodes
    }
}

