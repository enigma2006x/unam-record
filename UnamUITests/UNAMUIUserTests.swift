//
//  UNAMUIUserTests.swift
//  UnamUITests
//
//  Created by Jose Antonio Trejo Flores on 22/09/21.
//  Copyright © 2021 Jose Antonio Trejo Flores. All rights reserved.
//

import XCTest
@testable import Unam

final class UNAMUIUserTests: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUp()  {
        app = XCUIApplication()
        app.test()
    }
    
    override func tearDown()  {
        app = nil
    }
    
    func testProfileView() {
        
        let webViewsQuery = XCUIApplication().webViews.webViews.webViews
   
        let userTextField = webViewsQuery.textFields["Usuario"]
        userTextField.tap()
     
        let nipSecureTextField = webViewsQuery/*@START_MENU_TOKEN@*/.secureTextFields["NIP"]/*[[".otherElements[\"UNAM \/ DGAE \/ SIAE ~ Sistema Integral de Administración Escolar\"].secureTextFields[\"NIP\"]",".secureTextFields[\"NIP\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        nipSecureTextField.tap()
       
        webViewsQuery/*@START_MENU_TOKEN@*/.buttons["Acceder"]/*[[".otherElements[\"UNAM \/ DGAE \/ SIAE ~ Sistema Integral de Administración Escolar\"].buttons[\"Acceder\"]",".buttons[\"Acceder\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()


        let bienvenidStaticText = app.staticTexts["Bienvenid@"]
        if bienvenidStaticText.waitForExistence(timeout: 5) {
            XCTAssertTrue(bienvenidStaticText.exists)
        } else {
            XCTFail()
        }
        
        let userStaticText = app.staticTexts["Scarlett Marie"]
        if userStaticText.waitForExistence(timeout: 5) {
            XCTAssertTrue(userStaticText.exists)
        } else {
            XCTFail()
        }
        
    }
    
    func testAcademicTrajectory() {
        
        let webViewsQuery = XCUIApplication().webViews.webViews.webViews
        webViewsQuery/*@START_MENU_TOKEN@*/.buttons["Acceder"]/*[[".otherElements[\"UNAM \/ DGAE \/ SIAE ~ Sistema Integral de Administración Escolar\"].buttons[\"Acceder\"]",".buttons[\"Acceder\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tabBar = app.tabBars["Tab Bar"]
        tabBar.buttons["Trayectoria"].tap()
        
        let userStaticText = app.staticTexts["Scarlett Marie"]
        if userStaticText.waitForExistence(timeout: 5) {
            XCTAssertTrue(userStaticText.exists)
        } else {
            XCTFail()
        }
        
        let trajectoryStaticText = app.staticTexts["Trayectoria Académica"]
        if trajectoryStaticText.waitForExistence(timeout: 5) {
            XCTAssertTrue(trajectoryStaticText.exists)
        } else {
            XCTFail()
        }
        app.swipeUp()
        wait(for: 3)
    }
    
    func testAcademicRecord() {
        
        let webViewsQuery = XCUIApplication().webViews.webViews.webViews
        webViewsQuery/*@START_MENU_TOKEN@*/.buttons["Acceder"]/*[[".otherElements[\"UNAM \/ DGAE \/ SIAE ~ Sistema Integral de Administración Escolar\"].buttons[\"Acceder\"]",".buttons[\"Acceder\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tabBar = app.tabBars["Tab Bar"]
        tabBar.buttons["Trayectoria"].tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Enp Area I Fisico-Mat Y Las Ing "]/*[[".cells[\"Enp Area I Fisico-Mat Y Las Ing , Plantel 0027, Carrera -\"].staticTexts[\"Enp Area I Fisico-Mat Y Las Ing \"]",".staticTexts[\"Enp Area I Fisico-Mat Y Las Ing \"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let planStaticText = app.staticTexts["Nombre del Plan de Estudio"]
        if planStaticText.waitForExistence(timeout: 5) {
            XCTAssertTrue(planStaticText.exists)
        } else {
            XCTFail()
        }
        app.swipeUp()
        wait(for: 3)
    }
    
    func testNews() {
        
        let webViewsQuery = XCUIApplication().webViews.webViews.webViews
        webViewsQuery/*@START_MENU_TOKEN@*/.buttons["Acceder"]/*[[".otherElements[\"UNAM \/ DGAE \/ SIAE ~ Sistema Integral de Administración Escolar\"].buttons[\"Acceder\"]",".buttons[\"Acceder\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tabBar = app.tabBars["Tab Bar"]
        tabBar.buttons["Noticias"].tap()
        
        let newsStaticText = app.staticTexts["Noticias"]
        if newsStaticText.waitForExistence(timeout: 5) {
            XCTAssertTrue(newsStaticText.exists)
        } else {
            XCTFail()
        }
        
        app.swipeUp()
        wait(for: 3)
    }
}


