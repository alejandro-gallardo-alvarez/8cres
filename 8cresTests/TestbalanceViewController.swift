//
//  Testing.swift
//  8cresTests
//
//  Created by Alejandro Gallardo alvarez on 6/3/21.
//


import XCTest
@testable import _cres

class TestbalanceViewController: XCTestCase {
    var sut:BalanceViewController!

    override func setUpWithError() throws {
        try super.setUpWithError()
        let storyboard = UIStoryboard(name: "Bank", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: "balanceView") as BalanceViewController
            
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
       
    func testBalancePageLabelsAreConnected() throws {
         _ = try XCTUnwrap(sut.checkingAmount, "The checkingAmount Label is not connected")
         _ = try XCTUnwrap(sut.savingsAmount, "The savingsAmount Label is not connected")
    }
    
    func testBalancePageTextFieldsAreConnected() throws {
         _ = try XCTUnwrap(sut.transferFromChecking, "The transferFromChecking UITextField is not connected")
         _ = try XCTUnwrap(sut.transferFromSavings, "The transferFromSavings UITextField is not connected")
    }
    
    func testTransferFromCheckingTextFieldHasNumbersContentTypeSet() throws {
        let transferFromChecking = try XCTUnwrap(sut.transferFromChecking, "The transferFromChecking UITextField is not connected")
        
        XCTAssertEqual(transferFromChecking.keyboardType, UIKeyboardType.numberPad, "The transferFromChecking UITextField does not have a number Content Type set")
    }
    
    func testTransferFromSavingsTextFieldHasNumbersContentTypeSet() throws {
        let transferFromSavings = try XCTUnwrap(sut.transferFromSavings, "The transferFromSavings UITextField is not connected")
        
        XCTAssertEqual(transferFromSavings.keyboardType, UIKeyboardType.numberPad, "The transferFromSavings UITextField does not have a number Content Type set")
    }

        
    func testIfHomeButtonHasActionAssigned() throws{
        let homeButton: UIButton = sut.homeButton
                
        guard homeButton.actions(forTarget: sut, forControlEvent: .touchUpInside) != nil else {
                    XCTFail("UIButton does not have actions assigned for Control Event .touchUpInside")
                    return
            }
    }
    
    func testIfBalanceButtonHasActionAssigned() throws{
        let profileButton: UIButton = sut.profileButton
                
        guard profileButton.actions(forTarget: sut, forControlEvent: .touchUpInside) != nil else {
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
    
    func testIfCheckingTranferButtonHasActionAssigned() throws{
        let checkingTransferButton: UIButton = sut.checkingTransferButton
                
        guard checkingTransferButton.actions(forTarget: sut, forControlEvent: .touchUpInside) != nil else {
                    XCTFail("UIButton does not have actions assigned for Control Event .touchUpInside")
                    return
            }
    }
    
    func testIfSavingsTranferButtonHasActionAssigned() throws{
        let savingsTransferButton: UIButton = sut.savingsTransferButton
                
        guard savingsTransferButton.actions(forTarget: sut, forControlEvent: .touchUpInside) != nil else {
                    XCTFail("UIButton does not have actions assigned for Control Event .touchUpInside")
                    return
            }
    }
    
    func testOverdraftFunctionPositiveBalance() throws {
        let positiveBalance = 100.00
        
        let response = sut.isOverdraftValidation(positiveBalance)
        
        XCTAssertEqual(response, false)
    }
    
    func testOverdraftFunctionNegativeBalance() throws {
        let negativeBalance = -100.00
        
        let response = sut.isOverdraftValidation(negativeBalance)
        
        XCTAssertEqual(response, true)
    }
    
    func testOverdraftFunctionZeroBalance() throws {
        let zeroBalance = 0.00
        
        let response = sut.isOverdraftValidation(zeroBalance)
        
        XCTAssertEqual(response, false)
    }
    
    func testTransferIsNotEmptyIsEmpty() {
        
        let empty = ""
        
        let response = sut.validateTransferIsNotEmpty(empty)
        
        XCTAssertEqual(response, true)
    }
    
    func testTransferFromCheckingIsNotEmptyIsNotEmpty() {
        
        let notEmpty = "Testing"
        
        let response = sut.validateTransferIsNotEmpty(notEmpty)
        
        XCTAssertEqual(response, false)
    }
    
    
}
