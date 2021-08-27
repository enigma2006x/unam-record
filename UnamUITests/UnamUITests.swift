//
//  UnamUITests.swift
//  UnamUITests
//
//  Created by Jose Antonio Trejo Flores on 26/08/21.
//  Copyright © 2021 Jose Antonio Trejo Flores. All rights reserved.
//

import XCTest

final class UnamUITests: XCTestCase {

    private var app: XCUIApplication!
    
    override func setUp()  {
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown()  {
        app = nil
    }

    func testValidLoginView() {

        let webViewsQuery = XCUIApplication().webViews.webViews.webViews
   
        let userTextField = webViewsQuery.textFields["Usuario"]
        userTextField.tap()
        
        let nipSecureTextField = webViewsQuery/*@START_MENU_TOKEN@*/.secureTextFields["NIP"]/*[[".otherElements[\"UNAM \/ DGAE \/ SIAE ~ Sistema Integral de Administración Escolar\"].secureTextFields[\"NIP\"]",".secureTextFields[\"NIP\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        nipSecureTextField.tap()
        nipSecureTextField.tap()
        webViewsQuery/*@START_MENU_TOKEN@*/.textFields["Captcha"]/*[[".otherElements[\"UNAM \/ DGAE \/ SIAE ~ Sistema Integral de Administración Escolar\"].textFields[\"Captcha\"]",".textFields[\"Captcha\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        webViewsQuery/*@START_MENU_TOKEN@*/.buttons["Acceder"]/*[[".otherElements[\"UNAM \/ DGAE \/ SIAE ~ Sistema Integral de Administración Escolar\"].buttons[\"Acceder\"]",".buttons[\"Acceder\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        XCTAssertNotNil(webViewsQuery)
        XCTAssertNotNil(nipSecureTextField)
        XCTAssertNotNil(userTextField)
    }
    
    func testInvalidLoginView() {
        
        let webViewsQuery = XCUIApplication().webViews.webViews.webViews
        let userTextField = webViewsQuery.textFields["UsuarioWrong"]
        let nipSecureTextField = webViewsQuery.secureTextFields["NIPWrong"]
        webViewsQuery/*@START_MENU_TOKEN@*/.textFields["Captcha"]/*[[".otherElements[\"UNAM \/ DGAE \/ SIAE ~ Sistema Integral de Administración Escolar\"].textFields[\"Captcha\"]",".textFields[\"Captcha\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        webViewsQuery/*@START_MENU_TOKEN@*/.buttons["Acceder"]/*[[".otherElements[\"UNAM \/ DGAE \/ SIAE ~ Sistema Integral de Administración Escolar\"].buttons[\"Acceder\"]",".buttons[\"Acceder\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        XCTAssertNotNil(webViewsQuery)
        XCTAssertFalse(nipSecureTextField.exists)
        XCTAssertFalse(userTextField.exists)
    }
    
    func testCaptchaExistsInLoginView()  {
 
        let webViewsQuery = XCUIApplication().webViews.webViews.webViews
   
        let captchaTextField = webViewsQuery.textFields["Captcha"]
        wait(for: 3)
        
        XCTAssertTrue(captchaTextField.exists)
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
