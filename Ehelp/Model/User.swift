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
    
    // get user's email
    func getEmail() -> String {
        return self.email
    }
    // get user's password
    func getPassword() -> String {
        return self.password
    }
    // get dictionary
    func getDictionary() -> [String:Any] {
        return self.dict
    }
    // set user's email
    mutating func setEmail(email: String) {
        self.email = email
    }
    // set user's password
    mutating func setPassword(password: String) {
        self.password = password
    }
    // set user's name
    mutating func setName(name: String) {
        self.name = name
    }
    // set user's ID
    mutating func setID(id: String) {
        self.id = id
    }
    // set user's phone number
    mutating func setPhoneNum(phoneNum: String) {
        self.phoneNum = phoneNum
    }
}
