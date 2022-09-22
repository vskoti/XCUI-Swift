//
//  SplitoUITests.swift
//  SplitoUITests
//
//  Created by Shahid Latif on 13/04/2022.
//

import XCTest

class SplitoUITests: XCTestCase {
    
    let splitHomePO = SplitHomePO()
    
//    override func setUp() {
//        XCUIApplication().launch()
//       // wait(for: <#T##[XCTestExpectation]#>, timeout: 100)
//    }
//
//    override func tearDown() {
//      //  XCUIApplication().terminate()
//    }
    
    // Sample for your first test case.
    func testWhenApplicationDefaultStateWhenApplicationLaunched() throws {
        
                                        
        XCUIApplication().launch()
    }
}
