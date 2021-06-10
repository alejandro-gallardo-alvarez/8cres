//
//  _cresTests.swift
//  8cresTests
//
//  Created by Alejandro Gallardo alvarez on 6/1/21.
//

import XCTest
@testable import _cres

class TestingCreateAccountUIFieldProperties: XCTestCase {
    var sut: CreateAccountViewController!

    override func setUpWithError() throws {
      try super.setUpWithError()
      sut = CreateAccountViewController()
        
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testEmailFunctionCorrectContentType() throws {
        let emailTextFiel = "Test@test.com"
        
        let response = sut.isValidEmail(emailTextFiel)
        
        XCTAssertEqual(response, true)
    }
    
    func testEmailFunctionEmptyContent() throws {
        let emailTextFiel = ""
        
        let response = sut.isValidEmail(emailTextFiel)
        
        XCTAssertEqual(response, false)
    }
    
    func testEmailFunctionMissingAtSymbol() throws {
        let emailTextFiel = "Testingtesting.com"
        
        let response = sut.isValidEmail(emailTextFiel)
        
        XCTAssertEqual(response, false)
    }
    
    func testEmailFunctionMissingDot() throws {
        let emailTextFiel = "Testing@testingcom"
        
        let response = sut.isValidEmail(emailTextFiel)
        
        XCTAssertEqual(response, false)
    }
    
    func testPasswordFunctionCorrect() throws {
        let password = "Ab1#$&4"
        
        let respond = sut.isValidPassword(password)
        
        XCTAssertEqual(respond, true)
    }
    
    func testPasswordFunctionblank() throws {
        let password = ""
        
        let respond = sut.isValidPassword(password)
        
        XCTAssertEqual(respond, false)
    }
    
    func testPasswordFunctionLessThanSixCharacters() throws {
        let password = "1Af$"
        
        let respond = sut.isValidPassword(password)
        
        XCTAssertEqual(respond, false)
    }
}

