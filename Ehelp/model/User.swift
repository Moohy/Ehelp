//
//  User.swift
//  Ehelp
//
//  Created by Mohammed on 18/9/19.
//  Copyright © 2019 Mohammed. All rights reserved.
//

import Foundation

//codable will help if planning to encode info
//to json inorder to use them for an online service backend
struct User: Codable {
    private var email:          String!
    private var password:       String!
    private var name:           String!
    private var id:             String!
    private var phoneNum:    String!
    
    var dict: [String: Any] {
        return ["email": email!,
                "password": password!,
                "name": name!,
                "id": id!,
                "phoneNum":phoneNum!]
    }
    
    func getEmail() -> String {
        return self.email
    }
    
    func getPassword() -> String {
        return self.password
    }
    
    func getDictionary() -> [String:Any] {
        return self.dict
    }
    
    mutating func setEmail(email: String) {
        self.email = email
    }
    
    mutating func setPassword(password: String) {
        self.password = password
    }
    
    mutating func setName(name: String) {
        self.name = name
    }
    
    mutating func setID(id: String) {
        self.id = id
    }
    
    mutating func setPhoneNum(phoneNum: String) {
        self.phoneNum = phoneNum
    }
}
