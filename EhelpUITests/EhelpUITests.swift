import XCTest

class EhelpUITests: XCTestCase {
    
    
    static var app: XCUIApplication?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        // Pre-condition
        // if the app has not been launched yet
        // then  launch it then sign up and sign in
        if EhelpUITests.app == nil {
            EhelpUITests.app = XCUIApplication()
            EhelpUITests.app!.launch()
            signUp()
            signIn()
        // if the app has already been launched, then sign in only
        }else{
            signIn()
        }
    }

    // tearDown function runs after each test (Post-condition)
    override func tearDown() {
        // sign out after each test
        signOut()
    }
    
    // test function
    func testSignupButtonsAndFields() {
        
        signOut()
        let app = XCUIApplication()

        // click sign up button
        app.buttons[" Sign Up"].tap()
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
        app.buttons[" Cancel"].tap()
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
        
        // sign in
        signIn()
    }
    
    func testMenu() {

        let app = XCUIApplication()
        // get buttons
        let policeButon = app.buttons["Police"]
        let fireFighterButton = app.buttons["   Fire Fighter"]
        let ambulanceButton = app.buttons["    Ambulance"]
        //test if policeButon exists
        XCTAssertTrue(policeButon.exists)
        //test if fireFighterButton exists
        XCTAssertTrue(fireFighterButton.exists)
        //test if ambulanceButton exists
        XCTAssertTrue(ambulanceButton.exists)
        
        // reference to tab bar
        let tabBarsQuery = app.tabBars
        // report button on tab bar
        let tabBarButton = tabBarsQuery.buttons.count
        XCTAssertEqual(tabBarButton, 2)

    }
    // test if the submission is invalid
    func testInvalidSubmission() {
        
        let emergencyType = "Police"
        let decriptionText = "Invalid"
        
        // get reference to the app
        let app = XCUIApplication()
        
        // reference to tab bar
        let tabBarsQuery = app.tabBars
        
        // menu tab bar
        let menuButton = tabBarsQuery.buttons["Menu"]
        menuButton.tap()
        sleep(1)
        // click on emergency type that we specified above
        app.buttons[emergencyType].tap()
        // sleep for two seconds
        sleep(1)
        app.textViews["descriptionTV"].tap()
        // text view field
        let descriptionTextView = app.textViews["descriptionTV"]
        // type description
        descriptionTextView.typeText(decriptionText)
        // submit button
        let submitButton = app.buttons["Submit"]
        // tap submit button
        submitButton.tap()
        // test if the error alert exsists after typing invalid descritpion
        XCTAssertTrue(app.alerts["Error"].buttons["Message"].exists)
        // click on success message
        app.alerts["Error"].buttons["Message"].tap()
        sleep(1)
        //////////////
        // go back to menu
        app.navigationBars.buttons["Emergency Type"].tap()

    }
    
    func testInitialValidReviwingReport() {
                
        // get reference to the app
        let app = XCUIApplication()
        
        // reference to tab bar
        let tabBarsQuery = app.tabBars
        
        // report button on tab bar
        let reportsButton = tabBarsQuery.buttons["Reports"]
        // tap the report button
        reportsButton.tap()
        sleep(1)
        
        // test if there exist only one report
        let tablesQuery = app.tables
        let cellCount = tablesQuery.cells.count
        XCTAssertEqual(cellCount, 3)
        // menu tab bar
        tabBarsQuery.buttons["Menu"].tap()
        
        // then click on menu tab bar in order to either
        // 1- file another report
        // 2- sign out
        
    }
    
    func testNoneEmptyValidReviwingReport() {

        // submit report before reviwing reports
        // get report detail after submitting a report
        let emergencyType = submittingReport()

        // get reference to the app
        let app = XCUIApplication()

        // reference to tab bar
        let tabBarsQuery = app.tabBars

        // report button on tab bar
        let reportsButton = tabBarsQuery.buttons["Reports"]
        // tap the report button
        reportsButton.tap()
        sleep(1)

        // test if there exist only one report
        let tablesQuery = app.tables
        let cellCount = tablesQuery.cells.count
        XCTAssertEqual(cellCount, 1)

        // tab on recent created report
        app.tables.staticTexts[emergencyType].tap()


        // go back to the report menu
        app.navigationBars["Ehelp.TableCellReportDetailsVC"].buttons["Reports"].tap()
        //

        // click on menu tab bar
        tabBarsQuery.buttons["Menu"].tap()

    }
    
    // this function will triger after sign in function
    func submittingReport() -> String {
        
        let emergencyType = "Fire Fighter"
        let decriptionText = "this is my first report"
        
        // get reference to the app
        let app = XCUIApplication()
        
        // reference to tab bar
        let tabBarsQuery = app.tabBars

        // menu tab bar
        let menuButton = tabBarsQuery.buttons["Menu"]
        menuButton.tap()
        sleep(1)
        // click on emergency type that we specified above
        app.buttons[emergencyType].tap()
        // sleep for two seconds
        sleep(1)
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

        
        return emergencyType
        
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
        app.buttons[" Sign In"].tap()
    }
    
    func signUp(){
        
        let validEmail = "m.4848.m@hotmail.com"
        let validPassword = "123456"
        let validFullName = "Mohammed Alotaibi"
        let validID = "123456"
        let validPhoneNumber = "123456789"
        
        // get reference to the app
        let app = XCUIApplication()
        
        // click sign up button
        app.buttons[" Sign Up"].tap()
        
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
        app.buttons[" Sign Up"].tap()
//        app.buttons[" Cancel"].tap()
    
        
    }
}
