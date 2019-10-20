import Foundation

//codable will help if planning to encode info
//to json inorder to use them for an online service backend

// user model
struct User: Codable {
    // define users' attributes
    private var email:          String!
    private var password:       String!
    private var name:           String!
    private var id:             String!
    private var phoneNum:    String!
    
    // add user attributes to a dictionary
    var dict: [String: Any] {
        return ["email": email!,
                "password": password!,
                "name": name!,
                "id": id!,
                "phoneNum":phoneNum!]
    }
    
    /*
     *
     * check validity of the email and return true/false based on that
     *
     */
    func isValidEmail(email:String) -> Bool {
        // email regular expression
        let emailRegEx = "^[\\w\\.-]+@([\\w\\-]+\\.)+[A-Z]{1,4}$"
        // test if email is valid
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        // return either true or false
        return emailTest.evaluate(with: email)
    }
    
    /*
     *
     * check validity of the phone number and return true/false based on that
     *
     */
    func isValidPhoneNumber(phoneNumber:String) -> Bool {
        // phone number regular expression
        let phoneRegEx = "^\\+[\\d]{11}$"
        // test if phone number is valid
        let phoneTest = NSPredicate(format:"SELF MATCHES[c] %@", phoneRegEx)
        // return either true or false
        return phoneTest.evaluate(with: phoneNumber)
    }
    
    /*
     *
     * check validity of the ID and return true/false based on that
     *
     */
    func isValidID(id:String) -> Bool {
        // phone number regular expression
        let idEx = "^[\\w]{10}$"
        // test if phone number is valid
        let idTest = NSPredicate(format:"SELF MATCHES[c] %@", idEx)
        // return either true or false
        return idTest.evaluate(with: id)
    }
    
    /*
     *
     * getters
     *
     */
    
    // get user's email
    func getEmail() -> String {
        return self.email
    }
    // get user's password
    func getPassword() -> String {
        return self.password
    }
    // get user's phone number
    func getPhoneNum() -> String {
        return self.phoneNum
    }
    // get user's name
    func getName() -> String {
        return self.name
    }
    
    // get user's ID
    func getID() -> String {
        return self.id
    }
    
    // get dictionary
    func getDictionary() -> [String:Any] {
        return self.dict
    }

    /*
     *
     * setters
     *
     */
    
    // set user's email
    mutating func setEmail(email: String) {
        // check if email is valid before adding it to the database
        if (isValidEmail(email: email) == true) {
            self.email = email
        }
    }
    
    // set user's password
    mutating func setPassword(password: String) {
        self.password = password
        
    }
    
    // set user's phone number
    mutating func setPhoneNum(phoneNum: String) {
        // check if phone number is valid before adding it to the database
        if (isValidPhoneNumber(phoneNumber:phoneNum) == true) {
            self.phoneNum = phoneNum
        }
    }
    // set user's name
    mutating func setName(name: String) {
        self.name = name
    }
    // set user's ID
    mutating func setID(id: String) {
        // check if ID is valid before adding it to the database
        if (isValidID(id:id) == true) {
            self.id = id
        }
        
    }

}
