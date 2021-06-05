//
//  Testing.swift
//  8cresTests
//
//  Created by Alejandro Gallardo alvarez on 6/3/21.
//


import XCTest
@testable import _cres

class TestIncomeViewController: XCTestCase {
    var sut: IncomeViewController!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = IncomeViewController()
            
        sut.loadViewIfNeeded()
    }

        override func tearDownWithError() throws {
            sut = nil
            try super.tearDownWithError()
        }
        
    func testIncomeTextFieldCorrectInput() throws {
        let incomeInput = "0123456789"

        let response = sut.isValidIncomeInput(incomeInput)

        XCTAssertEqual(response, true)
    }
    
    func testIncomeTextFieldEmptyInput() throws {
        let incomeInput = ""

        let response = sut.isValidIncomeInput(incomeInput)

        XCTAssertEqual(response, false)
    }
    
    func testIncomeTextFieldWrongInput() throws {
        let incomeInput = "Testing"

        let response = sut.isValidIncomeInput(incomeInput)

        XCTAssertEqual(response, false)
    }
}
