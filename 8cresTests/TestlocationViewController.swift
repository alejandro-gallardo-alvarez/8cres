//
//  Testing.swift
//  8cresTests
//
//  Created by Alejandro Gallardo alvarez on 6/3/21.
//


import XCTest
@testable import _cres

class TestlocationViewController: XCTestCase {
    var sut:LocationViewController!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = LocationViewController()
            
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testLocationTextfieldCorrectInputOneWord() throws {
        let location = "Testing"

        let response = sut.isValidLocationInput(location)

        XCTAssertEqual(response, true)
    }
    
    func testLocationTextfieldCorrectInputNoCommaTwoWords() throws {
        let location = "Testing Testing"

        let response = sut.isValidLocationInput(location)

        XCTAssertEqual(response, true)
    }
    
    func testLocationTextfieldCorrectInputWithComma() throws {
        let location = "Testing, Testing"

        let response = sut.isValidLocationInput(location)

        XCTAssertEqual(response, true)
    }
    
    func testLocationTextfieldIncorrectEmptyInput() throws {
        let location = ""

        let response = sut.isValidLocationInput(location)

        XCTAssertEqual(response, false)
    }
    
    func testLocationTextfieldIncorrectInputNumbersOnly() throws {
        let location = "0123456789"

        let response = sut.isValidLocationInput(location)

        XCTAssertEqual(response, false)
    }
    
    func testLocationTextfieldIncorrectInputNumbersAndLetters() throws {
        let location = "Abc0123456789"

        let response = sut.isValidLocationInput(location)

        XCTAssertEqual(response, false)
    }
}
