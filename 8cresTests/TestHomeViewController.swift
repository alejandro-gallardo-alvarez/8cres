//
//  Testing.swift
//  8cresTests
//
//  Created by Alejandro Gallardo alvarez on 6/3/21.
//


import XCTest
@testable import _cres

class TestHomeViewController: XCTestCase {
    var sut: HomeViewController!

    override func setUpWithError() throws {
        try super.setUpWithError()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: "homepageController") as HomeViewController
            
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testHomePageLabelsAreConnected() throws {
         _ = try XCTUnwrap(sut.savings, "The savings Label is not connected")
         _ = try XCTUnwrap(sut.location, "The location Label is not connected")
         _ = try XCTUnwrap(sut.price, "The price Label is not connected")
         _ = try XCTUnwrap(sut.monthsToGoal, "The monthsToGoal Label is not connected")
         _ = try XCTUnwrap(sut.savedLabel, "The savedLabel Label is not connected")
    }
    
    func testGoalReachNotYetReachOneDollarToReachIt() throws {
        let goal = 1.00
       
        let response = sut.goalReachCheck(goal)
        
        XCTAssertEqual(response, false)
    }
    
    func testGoalReachNotYetReachoneThousandToReachIt() throws {
        let goal = 1000.00
       
        let response = sut.goalReachCheck(goal)
        
        XCTAssertEqual(response, false)
    }
    
    func testGoalReachZeroInputGoalHasBeenReach() throws {
        let goal = 0.00
       
        let response = sut.goalReachCheck(goal)
        
        XCTAssertEqual(response, true)
    }
    
    func testGoalReachNegativeInputGoalHasBeenReach() throws {
        let goal = -1.00
       
        let response = sut.goalReachCheck(goal)
        
        XCTAssertEqual(response, true)
    }
    func testIfProfileButtonHasActionAssigned() throws{
        let profileButton: UIButton = sut.profileButton
                
        guard profileButton.actions(forTarget: sut, forControlEvent: .touchUpInside) != nil else {
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
    
    func testIfPlaidButtonHasActionAssigned() throws{
        let plaidButton: UIButton = sut.plaidButton
                
        guard plaidButton.actions(forTarget: sut, forControlEvent: .touchUpInside) != nil else {
                    XCTFail("UIButton does not have actions assigned for Control Event .touchUpInside")
                    return
            }
    }
}
