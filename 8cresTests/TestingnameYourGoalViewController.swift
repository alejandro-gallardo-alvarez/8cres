//
//  Testing.swift
//  8cresTests
//
//  Created by Alejandro Gallardo alvarez on 6/3/21.
//


import XCTest
@testable import _cres

class TestingnameYourGoalViewController: XCTestCase {
    var sut: NameYourGoalViewController!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = NameYourGoalViewController()
            
        sut.loadViewIfNeeded()
    }

        override func tearDownWithError() throws {
            sut = nil
            try super.tearDownWithError()
        }
        
    func testHomePropertyGoalInputCorrect() throws {
        let homeGoal = "testing testing testing"

        let response = sut.isValidHomeGoal(homeGoal)

        XCTAssertEqual(response, true)
    }
    
    func testHomePropertyGoalInputEmpty() throws {
        let homeGoal = ""

        let response = sut.isValidHomeGoal(homeGoal)

        XCTAssertEqual(response, false)
    }
    
    func testHomePropertyGoalWrongInputNumbers() throws {
        let homeGoal = "12321"

        let response = sut.isValidHomeGoal(homeGoal)

        XCTAssertEqual(response, false)
    }
    
}
