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

        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        // clear variables
        userEmail = ""
        userPhoneNumber = ""
        userID = ""
        
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
    
    func testLenghtAndNotNilValues() {
        
        // assign valid data
        userEmail = "m.4848.mhotmailcom"
        userPhoneNumber = "+61466636990"
        userID = "sss3756190"
        
        // check if user email doesn't equal nil
        XCTAssertNotNil(userEmail)
        
        // check if user phone number doesn't equal nil
        XCTAssertNotNil(userPhoneNumber)
        
        // check if user ID doesn't equal nil
        XCTAssertNotNil(userID)
        
        // check if phone number length equal 12
        XCTAssertEqual(userPhoneNumber.count, 12)
        
        // check if ID length equal 10
        XCTAssertEqual(userID.count, 10)
        

    }

}
