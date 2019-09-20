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
        
        

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testValidLoginSuccess() {

        let validEmail = "m.4848.m@hotmail.com"
        let validPassword = "123456"

        // get reference to the app
        let app = XCUIApplication()
        
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
        
        // login
        app.buttons["login"].tap()
    }

    

}
