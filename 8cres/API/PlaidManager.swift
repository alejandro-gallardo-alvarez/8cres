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
import LinkKit
import Keys
import Moya

class PlaidManager {
    static let instance = PlaidManager()
    let provider = MoyaProvider<PlaidAPI>()
    let storageManager = StorageManager.instance
    
    let clientID: String, secret: String, environment: Environment
    
    enum Environment: String {
        case sandbox, development
        
        var linkKitValue: PLKEnvironment {
            switch self {
            case .sandbox: return .sandbox
            case .development: return .development
            }
        }
    }
    
    private init() {
        let keys = _8cresKeys() // Keys function is import it has to have same name as project
        clientID = keys.clientID
        environment = .development // Change Plaid environment from here
        secret = (environment == .sandbox) ? keys.secret_sandbox : keys.secret_development
    }
    
    // MARK: - API request helper function
    func request(for endpoint: PlaidAPI, onSuccess: @escaping (Response) throws -> Void) {
        provider.request(endpoint) {
            result in
            
            switch result {
            case .success(let response):
                do {
                    try onSuccess(response)
                } catch {
                    print("Error: \(error)")
                }
                
            case .failure(let error):
                print("Network request failed: \(error)")
                print(try! error.response!.mapJSON())
            }
        }
    }
    
    // MARK: - Linked Account Setup
    func handleSuccessWithToken(_ publicToken: String, metadata: [String : Any]?) {
        NotificationCenter.default.post(name: .successfulLinking, object: self)
        
        request(for: .exchangeTokens(publicToken: publicToken)) {
            [weak self] response in
            guard let self = self else { return }
            
            let exchangeTokenResponse = try ExchangeTokenResponse(data: response.data)
            
            if let data = try? JSONSerialization.data(
                withJSONObject: metadata!["institution"]!,
                options: []) {
                do {
                    let partialInstitutionData = try Institution(data: data)
                    
                    self.request(for: .getInstitution(institutionID: partialInstitutionData.id)) {
                        [weak self] institutionResponse in
                        guard let self = self else { return }
                        
                        let institutionResponse = try GetInstitutionResponse(data: institutionResponse.data)
                        self.storageManager.addAccounts(using: exchangeTokenResponse.accessToken, for: institutionResponse.institution)
                    }
            
                } catch {
                    print("Could not parse JSON: \(error)")
                }
            }
        }
    }
    
    // MARK: - Helper functions to fetch transactions
    func getAllTransactions(startDate: Date, endDate: Date, completionHandler: @escaping ([Transaction]) -> Void) {
        var transactions: [Transaction] = []
        let dispatch = DispatchGroup()
        
        for (accessToken, accountIDs) in storageManager.accessTokens {
            dispatch.enter()
            
            request(for: .getTransactions(accessToken: accessToken, startDate: startDate, endDate: endDate, accountIDs: accountIDs)) {
                response in
                
                let response = try GetTransactionsResponse(data: response.data)
                
                transactions.append(contentsOf: response.transactions)
                dispatch.leave()
                
                }
        }
        
        dispatch.notify(queue: .main) {
            transactions.sort(by: >)
            completionHandler(transactions)
        }
    }
    
    func getTransactions(for accounts: [Account],
                         startDate: Date,
                         endDate: Date,
                         completionHandler: @escaping ([Transaction]) -> Void) {
        var transactions: [Transaction] = []
        let dispatch = DispatchGroup()
        
        for account in accounts {
            dispatch.enter()
            
            request(for: .getTransactions(accessToken: account.accessToken, startDate: startDate, endDate: endDate, accountIDs: [account.id])) {
                response in
                
                let response = try GetTransactionsResponse(data: response.data)
                
                transactions.append(contentsOf: response.transactions)
                dispatch.leave()
                
                }
        }
        
        dispatch.notify(queue: .main) {
            transactions.sort(by: >)
            completionHandler(transactions)
        }
    }
}

// MARK: - Notification Names
extension Notification.Name {
    static let successfulLinking = Notification.Name("successfulLinking")
}

