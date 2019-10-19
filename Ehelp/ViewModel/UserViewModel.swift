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
}
