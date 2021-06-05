//
//  TestpriceViewController.swift
//  8cresTests
//
//  Created by Alejandro Gallardo alvarez on 6/3/21.
//

import XCTest
@testable import _cres

class TestpriceViewController: XCTestCase {
    var sut: PriceViewController!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = PriceViewController()
            
        sut.loadViewIfNeeded()
    }

        override func tearDownWithError() throws {
            sut = nil
            try super.tearDownWithError()
        }
        
    func testPriceTextFieldCorrectInput() throws {
        let priceInput = "1234567"

        let response = sut.isValidPriceInput(priceInput)

        XCTAssertEqual(response, true)
    }
    
    func testPriceTextFieldEmptyInput() throws {
        let priceInput = ""

        let response = sut.isValidPriceInput(priceInput)

        XCTAssertEqual(response, false)
    }
    
    func testPriceTextFieldWrongInput() throws {
        let priceInput = "Testing"

        let response = sut.isValidPriceInput(priceInput)
        XCTAssertEqual(response, false)
    }
}
