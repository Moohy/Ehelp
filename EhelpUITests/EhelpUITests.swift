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
    
    // test function
    func testSignupButtonsAndFields() {
        
        signOut()
        let app = XCUIApplication()

        // click sign up button
        app.buttons["signup"].tap()
        // sleep for 2 seconds
        sleep(2)
        // email field
        let emailTextField = app.textFields["Email"]
        //test if email field exists
        XCTAssertTrue(emailTextField.exists)
        // password field
        let passwordTextField = app.textFields["Password"]
        //test if password field exists
        XCTAssertTrue(passwordTextField.exists)
        // full name field
        let fullNameTextField = app.textFields["Full Name"]
        //test if full name field exists
        XCTAssertTrue(fullNameTextField.exists)
        // ID field
        let IDTextField = app.textFields["ID"]
        //test if ID field exists
        XCTAssertTrue(IDTextField.exists)
        // Phone number field
        let phoneNumberTextField = app.textFields["Phone No."]
        //test if Phone number field exists
        XCTAssertTrue(phoneNumberTextField.exists)
        
        // get count for text fields
        let textFieldsCount = app.textFields.count
        // test if numbers of buttons = 5
        XCTAssertEqual(textFieldsCount, 5)
        // get count for number of buttons
        let buttonCount = app.buttons.count
        // test if numbers of buttons = 2
        XCTAssertEqual(buttonCount, 2)
        // wait for 1 second
        sleep(1)
        app.buttons["Cancel"].tap()
        // always sign in since we always sign out after each method runs
        signIn()
    }
    
    // test function
    func testLoginButtonsAndFields() {
        
        signOut()
        let app = XCUIApplication()
        
        // email field
        let emailTextField = app.textFields["Email"]
        //test if email field exists
        XCTAssertTrue(emailTextField.exists)
        // password field
        let passwordTextField = app.textFields["Password"]
        //test if password field exists
        XCTAssertTrue(passwordTextField.exists)
        
        // get count for text fields
        let textFieldsCount = app.textFields.count
        // test if numbers of buttons = 2
        XCTAssertEqual(textFieldsCount, 2)
        // get count for number of buttons
        let buttonCounts = app.buttons.count
        // test if numbers of buttons = 2
        XCTAssertEqual(buttonCounts, 2)
        
        
        signIn()
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
        // tap email field
        emailTextField.tap()
        // type valid email
        emailTextField.typeText(validEmail)
        // password field
        let passwordTextField = app.textFields["Password"]
        // tap password field
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
        emailTextField.tap()
        // type valid email
        emailTextField.typeText(validEmail)
        // password field
        let passwordTextField = app.textFields["Password"]
        passwordTextField.tap()
        // type valid password
        passwordTextField.typeText(validPassword)
        // full name field
        let fullNameTextField = app.textFields["Full Name"]
        fullNameTextField.tap()
        // type valid full name
        fullNameTextField.typeText(validFullName)
        // ID field
        let IDTextField = app.textFields["ID"]
        IDTextField.tap()
        // type valid ID
        IDTextField.typeText(validID)
        // Phone number field
        let phoneNumberTextField = app.textFields["Phone No."]
        phoneNumberTextField.tap()
        // type valid Phone number
        phoneNumberTextField.typeText(validPhoneNumber)
        
        // sign up
        app.buttons["Sign up"].tap()
    }
}
