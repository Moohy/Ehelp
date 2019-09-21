//
//  EhelpUITests.swift
//  EhelpUITests
//
//  Created by Mohammed on 2/9/19.
//  Copyright © 2019 Mohammed. All rights reserved.
//

import XCTest

class EhelpUITests: XCTestCase {
    
    
    static var app: XCUIApplication?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()

        if EhelpUITests.app == nil {
            EhelpUITests.app = XCUIApplication()
            EhelpUITests.app!.launch()
            signUp()
            signIn()
        }else{
            signIn()
        }
    }

    override func tearDown() {
        // sign out after each test
        signOut()
    }

    
    // this function will triger after sign in function
    func submittingReport() {
        
        let emergencyType = "Fire Fighter"
        let decriptionText = "this is my first report"
        
        // get reference to the app
        let app = XCUIApplication()
        
        // reference to tab bar
        let tabBarsQuery = app.tabBars

        // menu tab bar
        let menuButton = tabBarsQuery.buttons["Menu"]
        menuButton.tap()
        sleep(2)
        // click on emergency type that we specified above
        app.buttons[emergencyType].tap()
        // sleep for two seconds
        sleep(2)
        app.textViews["descriptionTV"].tap()
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
        sleep(1)
        
    }
    
    func testValidReviwingReport() {
        
        // submit report before reviwing reports
        submittingReport()

        // get reference to the app
        let app = XCUIApplication()
        
        // reference to tab bar
        let tabBarsQuery = app.tabBars
        
        // report button on tab bar
        let reportsButton = tabBarsQuery.buttons["Reports"]
        // tap the report button
        reportsButton.tap()
        sleep(1)
        // tab on recent created report
        app.tables.staticTexts["Fire Fighter-23-2-2020"].tap()
        // this need to be modified as we're not dealing with static value // need to get the value from the report class
        
        // go back to the report menu
        app.navigationBars["Ehelp.TableCellReportDetailsVC"].buttons["Reports"].tap()
//
        
        // menu tab bar
        tabBarsQuery.buttons["Menu"].tap()
        
        // then click on menu tab bar in order to either
        // 1- file another report
        // 2- sign out
        
    }
    
    func signOut() {
        
        // get reference to the app
        let app = XCUIApplication()
        
        // sign out
        app.navigationBars["Emergency Type"].children(matching: .button).element.tap()
    }
    
    func signIn(){
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
    
    func signUp(){
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
    }
}
