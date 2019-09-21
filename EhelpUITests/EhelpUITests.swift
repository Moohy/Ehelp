//
//  EhelpUITests.swift
//  EhelpUITests
//
//  Created by Mohammed on 2/9/19.
//  Copyright © 2019 Mohammed. All rights reserved.
//

import XCTest

class EhelpUITests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        
        
        // sign up bluck which is necessary every time we want to use the app
        // since we are not yet using a database
        // so everything gets deleted when we close the app
        let validEmail = "m.4848.m@hotmail.com"
        let validPassword = "123456"
        let validFullName = "Mohammed Alotaibi"
        let validID = "123456"
        let validPhoneNumber = "0466636990"
        
        // get reference to the app
        let app = XCUIApplication()
        
        // click sign up button
        app.buttons["signup"].tap()
        
        // email field
        let emailTextField = app.textFields["Email"]
        //check if email field exists
        XCTAssertTrue(emailTextField.exists)
        emailTextField.tap()
        // type valid email
        emailTextField.typeText(validEmail)
        // password field
        let passwordTextField = app.textFields["Password"]
        //check if password field exists
        XCTAssertTrue(passwordTextField.exists)
        passwordTextField.tap()
        // type valid password
        passwordTextField.typeText(validPassword)
        // full name field
        let fullNameTextField = app.textFields["Full Name"]
        //check if full name field exists
        XCTAssertTrue(fullNameTextField.exists)
        fullNameTextField.tap()
        // type valid full name
        fullNameTextField.typeText(validFullName)
        // ID field
        let IDTextField = app.textFields["ID"]
        //check if ID field exists
        XCTAssertTrue(IDTextField.exists)
        IDTextField.tap()
        // type valid ID
        IDTextField.typeText(validID)
        // Phone number field
        let phoneNumberTextField = app.textFields["Phone No."]
        //check if Phone number field exists
        XCTAssertTrue(phoneNumberTextField.exists)
        phoneNumberTextField.tap()
        // type valid Phone number
        phoneNumberTextField.typeText(validPhoneNumber)
        
        // sign up
        app.buttons["Sign up"].tap()
        
        
        
        /// log ing
        // email field
//        let emailTextField = app.textFields["Email"]
        //check if email field exists
        XCTAssertTrue(emailTextField.exists)
        emailTextField.tap()
        // type valid email
        emailTextField.typeText(validEmail)
        // password field
//        let passwordTextField = app.textFields["Password"]
        //check if password field exists
        XCTAssertTrue(passwordTextField.exists)
        passwordTextField.tap()
        // type valid password
        passwordTextField.typeText(validPassword)
//        // login
        app.buttons["login"].tap()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
//    func testValidLoginSuccess() {
//
//        let validEmail = "m.4848.m@hotmail.com"
//        let validPassword = "123456"
//
//        // get reference to the app
//        let app = XCUIApplication()
//
//        // email field
//        let emailTextField = app.textFields["Email"]
//        //check if email field exists
//        XCTAssertTrue(emailTextField.exists)
//        emailTextField.tap()
//        // type valid email
//        emailTextField.typeText(validEmail)
//        // password field
//        let passwordTextField = app.textFields["Password"]
//        //check if password field exists
//        XCTAssertTrue(passwordTextField.exists)
//        passwordTextField.tap()
//        // type valid password
//        passwordTextField.typeText(validPassword)
//
//        // login
//        app.buttons["login"].tap()
//
//
//    }
    
    // this function will triger after sign in function
    func testValidSubmittingReport() {
        
        let emergencyType = "Fire Fighter"
//        let decriptionText:String = "this is my first report"
        
        // get reference to the app
        let app = XCUIApplication()
        
        // reference to tab bar
        let tabBarsQuery = app.tabBars

        // menu tab bar
        let menuButton = tabBarsQuery.buttons["Menu"]
        menuButton.tap()
        sleep(10)
        // click on emergency type that we specified above
        app.buttons[emergencyType].tap()
        // sleep for two seconds
        sleep(10)
        // text view field
        let descriptionTextView = app.textViews["descriptionTV"]
        
        
        // type description
        
        descriptionTextView.typeText(decriptionText)
        
        
        // missing chooing a cordinate on the map
        
        // submit button
        let submitButton = app.buttons["Submit"]
        // tap submit button
        submitButton.tap()
        // click on success message
        app.alerts["Message"].buttons["Back"].tap()
        
    }
    
    func testValidReviwingReport() {

        // get reference to the app
        let app = XCUIApplication()
        
        // reference to tab bar
        let tabBarsQuery = app.tabBars
        
        // report button on tab bar
        let reportsButton = tabBarsQuery.buttons["Reports"]
        // tap the report button
        reportsButton.tap()
        // tab on recent created report
//        app.tables.staticTexts["Fire Fighter-23-2-2020"].tap()
        // this need to be modified as we're not dealing with static value // need to get the value from the report class
        
        // go back to the report menu
//        app.navigationBars["Ehelp.TableCellReportDetailsVC"].buttons["Reports"].tap()
//        
        
        // menu tab bar
        tabBarsQuery.buttons["Menu"].tap()
        
        // then click on menu tab bar in order to either
        // 1- file another report
        // 2- sign out
        
    }
    
    func testValidSigningOut() {
        
        // get reference to the app
        let app = XCUIApplication()
        
        // sign out
        app.navigationBars["Emergency Type"].children(matching: .button).element.tap()
    }
}
