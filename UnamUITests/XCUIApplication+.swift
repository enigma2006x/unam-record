//
//  XCUIApplication+.swift
//  UnamUITests
//
//  Created by Jose Antonio Trejo Flores on 22/09/21.
//  Copyright © 2021 Jose Antonio Trejo Flores. All rights reserved.
//

import XCTest

extension XCUIApplication {
    
    func test(){
        launchEnvironment = [Constant.testUI: "true"]
        launch()
    }
}

extension XCTestCase {
    
    func wait(for duration: TimeInterval) {
        let waitExpectation = expectation(description: "Waiting")
        
        let when = DispatchTime.now() + duration
        DispatchQueue.main.asyncAfter(deadline: when) {
            waitExpectation.fulfill()
        }
        
        // We use a buffer here to avoid flakiness with Timer on CI
        waitForExpectations(timeout: duration + 0.5)
    }
}
