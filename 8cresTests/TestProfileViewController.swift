//
//  Testing.swift
//  8cresTests
//
//  Created by Alejandro Gallardo alvarez on 6/3/21.
//


import XCTest
@testable import _cres

class TestProfileViewController: XCTestCase {
    var sut:ProfileViewController!

    override func setUpWithError() throws {
        try super.setUpWithError()
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: "profileView") as ProfileViewController
            
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
        
    func testProfilePageLabelsAreConnected() throws {
         _ = try XCTUnwrap(sut.inputName, "The inputName Label is not connected")
         _ = try XCTUnwrap(sut.inputEmail, "The inputEmailLabel is not connected")
         _ = try XCTUnwrap(sut.inputNumber, "The inputNumber Label is not connected")
         _ = try XCTUnwrap(sut.inputIncome, "The inputIncome Label is not connected")
    }
    
    func testIfHomeButtonHasActionAssigned() throws{
        let homeButton: UIButton = sut.homeButton
                
        guard homeButton.actions(forTarget: sut, forControlEvent: .touchUpInside) != nil else {
                    XCTFail("UIButton does not have actions assigned for Control Event .touchUpInside")
                    return
            }
    }
    
    func testIfBalanceButtonHasActionAssigned() throws{
        let balanceButton: UIButton = sut.balanceButton
                
        guard balanceButton.actions(forTarget: sut, forControlEvent: .touchUpInside) != nil else {
                    XCTFail("UIButton does not have actions assigned for Control Event .touchUpInside")
                    return
            }
    }
    
    func testIfLogoutButtonHasActionAssigned() throws{
        let logoutButton: UIButton = sut.logoutButton
                
        guard logoutButton.actions(forTarget: sut, forControlEvent: .touchUpInside) != nil else {
                    XCTFail("UIButton does not have actions assigned for Control Event .touchUpInside")
                    return
            }
    }
    
    func testIfDeleteButtonHasActionAssigned() throws{
        let deleteButton: UIButton = sut.deleteAccountButton
                
        guard deleteButton.actions(forTarget: sut, forControlEvent: .touchUpInside) != nil else {
                    XCTFail("UIButton does not have actions assigned for Control Event .touchUpInside")
                    return
            }
    }
}
