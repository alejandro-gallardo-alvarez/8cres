//
//  test.swift
//  8cresTests
//
//  Created by Alejandro Gallardo alvarez on 6/3/21.
//

import XCTest
@testable import _cres

class TestingNewUserViewController: XCTestCase {

    var sut: NewUserViewController!

    override func setUpWithError() throws {
      try super.setUpWithError()
      sut = NewUserViewController()
        
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testFirstNameFunctionCorrectFirstName() throws {
        let first = "Testing"
        
        let response = sut.isValidFirstName(first)
        
        XCTAssertEqual(response, true)
    }
    
    func testFirstNameFunctionCorrectFirstNameWithSpaceAndMiddleName() throws {
        let first = "Testing Testing"
        
        let response = sut.isValidFirstName(first)
        
        XCTAssertEqual(response, true)
    }
    
    func testFirstNameFunctionBlankFirstName() throws {
        let first = ""
        
        let response = sut.isValidFirstName(first)
        
        XCTAssertEqual(response, false)
    }
    
    func testFirstNameFunctionIncorrectFirstName() throws {
        let first = "12!3$*"
        
        let response = sut.isValidFirstName(first)
        
        XCTAssertEqual(response, false)
    }
    
    func testLastNameFunctionCorrectLastName() throws {
        let last = "Testing"
        
        let response = sut.isValidLastName(last)
        
        XCTAssertEqual(response, true)
    }
    
    func testLastNameFunctionCorrectMultipleLastNames() throws {
        let last = "Testing Testing"
        
        let response = sut.isValidLastName(last)
        
        XCTAssertEqual(response, true)
    }
    
    func testLastNameFunctionBlankLastName() throws {
        let last = ""
        
        let response = sut.isValidLastName(last)
        
        XCTAssertEqual(response, false)
    }
    
    func testLastNameFunctionIncorrectLastName() throws {
        let last = "12!3$*"
        
        let response = sut.isValidLastName(last)
        
        XCTAssertEqual(response, false)
    }
    
    func testPhoneNumberValidationFunctionCorrectInput() throws {
        let phoneNumber = "111-222-3333"
        
        let response = sut.isValidPhoneNumber(phoneNumber)
        
        XCTAssertEqual(response, true)
    }
    
    func testPhoneNumberValidationFunctionMissingNumbers() throws {
        let phoneNumber = "111-222-333"
        
        let response = sut.isValidPhoneNumber(phoneNumber)
        
        XCTAssertEqual(response, false)
    }
    
    func testPhoneNumberValidationFunctionMissingDsshes() throws {
        let phoneNumber = "111-2223333"
        
        let response = sut.isValidPhoneNumber(phoneNumber)
        
        XCTAssertEqual(response, false)
    }
    
    func testPhoneNumberValidationFunctionWrongFormat() throws {
        let phoneNumber = "(111)222-3333"
        
        let response = sut.isValidPhoneNumber(phoneNumber)
        
        XCTAssertEqual(response, false)
    }
    
//    func testemailFunction() throws {
//        let username = "lalala@la.com"
//
//        let response = sut.returnEmail()
//
//        XCTAssertEqual(response, username)
//    }
}
