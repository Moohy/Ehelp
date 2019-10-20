import XCTest
@testable import Ehelp

class UserTests: XCTestCase {

    var user: User!
    var userEmail: String!
    var userPhoneNumber: String!
    var userID: String!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // initialize testable mode
        user = User()

        // clear variables
        userEmail = ""
        userPhoneNumber = ""
        userID = ""
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testValidUserData() {
        
        // assign valid data
        userEmail = "m.4848.m@hotmail.com"
        userPhoneNumber = "+61466636990"
        userID = "sss3756190"
        
        // check if isValidEmail will return true on valid email
        XCTAssertTrue(user.isValidEmail(email: userEmail) == true)

        // check if isValidPhoneNumber will return true on valid phone number
        XCTAssertTrue(user.isValidPhoneNumber(phoneNumber: userPhoneNumber) == true)
      
        // check if isValidID will return true on valid ID
        XCTAssertTrue(user.isValidID(id: userID) == true)
    }

    func testInValidUserData() {
        
        // assign valid data
        userEmail = "m.4848.mhotmailcom"
        userPhoneNumber = "61466636990"
        userID = "sss375619012345"
        
        // check if isValidEmail will return false on valid email
        XCTAssertFalse(user.isValidEmail(email: userEmail) == true)
        
        // check if isValidPhoneNumber will return false on valid phone number
        XCTAssertFalse(user.isValidPhoneNumber(phoneNumber: userPhoneNumber) == true)
        
        // check if isValidID will return false on valid ID
        XCTAssertFalse(user.isValidID(id: userID) == true)
    }

}
