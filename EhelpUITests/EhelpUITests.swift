import XCTest

class EhelpUITests: XCTestCase {
    
    
    static var app: XCUIApplication?
    var date: String?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        // Pre-condition
        // if the app has not been launched yet
        // then  launch it then sign up and sign in
        
        if EhelpUITests.app == nil {
            EhelpUITests.app = XCUIApplication()
            EhelpUITests.app!.launch()
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
        app.buttons[" Sign Up"].doubleTap()
        // sleep for 2 seconds
        sleep(2)
        // email field
        let emailTextField = app.textFields["Email"]
        //test if email field exists
        XCTAssertTrue(emailTextField.exists)
        // password field
        let passwordTextField = app.secureTextFields["Password"]
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
        // test if numbers of fields = 5
        XCTAssertEqual(textFieldsCount + app.secureTextFields.count, 5)

        // get count for number of buttons
        let buttonCount = app.buttons.count
        // test if numbers of buttons = 2
        XCTAssertEqual(buttonCount, 2)
        // wait for 1 second
        sleep(1)
        app.buttons[" Cancel"].tap()
        // always sign in since we always sign out after each method runs
        signIn()
        // sleep for 3 seconds
        sleep(3)
        
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
        let passwordTextField = app.secureTextFields["Password"]
        //test if password field exists
        XCTAssertTrue(passwordTextField.exists)
        
        // get count for text fields
        let textFieldsCount = app.textFields.count
        // test if numbers of buttons = 2
        XCTAssertEqual(textFieldsCount + app.secureTextFields.count, 2)
        // get count for number of buttons
        let buttonCounts = app.buttons.count
        // test if numbers of buttons = 2
        XCTAssertEqual(buttonCounts, 2)
        
        // sign in
        signIn()
        // sleep for 3 seconds
        sleep(2)
    }
    
    // test menue
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
        
        // initialize variables
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
        
        // sleep for 2 seconds
        sleep(2)
        
        // test if the error alert exsists after typing invalid descritpion
        XCTAssertTrue(app.alerts["Error"].buttons["OK"].exists)
        // click on success message
        app.alerts["Error"].buttons["OK"].doubleTap()
        
        // sleep for 2 seconds
        sleep(2)

        // go back to menu
        app.navigationBars.buttons["Emergency Type"].tap()

    }


    func testNoneEmptyValidReviwingReport() {

        // get reference to the app
        let app = XCUIApplication()
        
        // test if there exist only one report
        let tablesQuery = app.tables
        let cellCount = tablesQuery.cells.count
        
        // submit report before reviwing reports
        submittingReport()
        
        // reference to tab bar
        let tabBarsQuery = app.tabBars

        // report button on tab bar
        let reportsButton = tabBarsQuery.buttons["Reports"]
        // tap the report button
        reportsButton.tap()
        sleep(1)

        let cellCountAfterAddingNewReport = app.tables.cells.count
        
        // check if cell is not empty
        XCTAssertNotEqual(cellCount, cellCountAfterAddingNewReport)

        // menu tab bar
        tabBarsQuery.buttons["Menu"].tap()
    }
    
    
    func testReportDeletion() {
        
        let app = XCUIApplication()
        // submit report before reviwing reports

        submittingReport()
        
        // reference to tab bar
        let tabBarsQuery = app.tabBars
        
        // menu tab bar
        tabBarsQuery.buttons["Reports"].tap()
        
        // test if there exist only one report
        let tablesQuery = app.tables
        let cellCount = tablesQuery.cells.count
        
        // sleep for 1 second
        sleep(1)
        
        // delete first element
        tablesQuery.cells.allElementsBoundByIndex.first!.swipeLeft()
        tablesQuery.buttons["Delete"].tap()

        // sleep for 1 second
        sleep(1)
        
        let cellCountAfterDeletion = app.tables.cells.count
        
        // check if cell is not empty
        XCTAssertNotEqual(cellCount, cellCountAfterDeletion)
        
        // menu tab bar
        tabBarsQuery.buttons["Menu"].tap()
        
    }
    
    
    
    
    // this function will triger after sign in function
    func submittingReport() -> String {
        
        let emergencyType = "   Fire Fighter"
        let decriptionText = "this is my first report"
        
        // get reference to the app
        let app = XCUIApplication()
        
        // click on emergency type that we specified above
        app.buttons[emergencyType].doubleTap()
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
        
        date = setDate()

        sleep(3)
        // click on success message
        app.alerts["Seccussfull Submission"].buttons["OK"].doubleTap()
        // sleep for 1 second
        sleep(1)
        // go back to the menu
        app.navigationBars["Ehelp.SubmissionVC"].buttons["Emergency Type"].tap()


        return emergencyType
        
    }
    
    // sign out function
    func signOut() {
        
        // get reference to the app
        let app = XCUIApplication()
        
        // sign out
        app.navigationBars["Emergency Type"].children(matching: .button).element.doubleTap()
        // sleep for 2 seconds
        sleep(2)
    }
    
    // sign in function
    func signIn(){
        
        // initialize email and password
        let validEmail = "a@a.com"
        let validPassword = "123123"
        
        // get reference to the app
        let app = XCUIApplication()
        
        // email field
        let emailTextField = app.textFields["Email"]
        // tap email field
        emailTextField.doubleTap()
        // type valid email
        emailTextField.typeText(validEmail)
        // password field
        UIPasteboard.general.string = validPassword
        app.secureTextFields["Password"].doubleTap()
        app.menuItems["Paste"].tap()
        
        // login
        app.buttons[" Sign In"].doubleTap()
        // sleep for 2 seconds
        sleep(2)
        
    }
    
    // set date function to set the current date
    func setDate() -> String{
        // call Date object
        let date = Date()
        // call date formatter object
        let formatter = DateFormatter()
        // set the desired format
        formatter.dateFormat = "dd-MM-yyyy HH:mm"
        // return the current date in the desired format
        return formatter.string(from: date)
        
    }
    
}
