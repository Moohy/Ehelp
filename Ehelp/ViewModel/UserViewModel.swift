import Foundation

// user view model
struct UserViewModel {
    
    // initialize user model
    var user: User = User()
    
    // get user email
    func getEmail() -> String {
        return user.getEmail()
    }
    
    // get user password
    func getPassword() -> String {
        return user.getPassword()
    }
    
    // get dictionary of user info
    func getDictionary() -> [String:Any] {
        return user.getDictionary()
    }
    // set user email
    mutating func setEmail(email: String) {
        user.setEmail(email: email)
    }
    
    // set user password
    mutating func setPassword(password: String) {
        user.setPassword(password: password)
    }
    
    // set user name
    mutating func setName(name: String) {
        user.setName(name: name)
    }
    
    // set user ID
    mutating func setID(id: String) {
        user.setID(id: id)
    }
    
    // set user phone number
    mutating func setPhoneNum(phoneNum: String) {
        user.setPhoneNum(phoneNum: phoneNum)
    }
    
    // get true or false values based on the validity of the email
    mutating func getEmailValidity(email: String) -> Bool {
        return user.isValidEmail(email: email)
        
    }
    
    // get true or false values based on the validity of the phone number
    mutating func getPhoneNumberValidity(phoneNumber: String) -> Bool {
        return user.isValidPhoneNumber(phoneNumber: phoneNumber)
    }
    
    // get true or false values based on the validity of the ID
    mutating func getIDValidity(id: String) -> Bool {
        return user.isValidID(id: id)
    }
}
