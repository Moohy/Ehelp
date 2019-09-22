//
//  UserViewModel.swift
//  Ehelp
//
//  Created by Mohammed on 22/9/19.
//  Copyright © 2019 Mohammed. All rights reserved.
//

import Foundation

struct UserViewModel {
    var user: User = User()
    
    func getEmail() -> String {
        return user.getEmail()
    }
    
    func getPassword() -> String {
        return user.getPassword()
    }
    
    func getDictionary() -> [String:Any] {
        return user.getDictionary()
    }
    
    mutating func setEmail(email: String) {
        user.setEmail(email: email)
    }
    
    mutating func setPassword(password: String) {
        user.setPassword(password: password)
    }
    
    mutating func setName(name: String) {
        user.setName(name: name)
    }
    
    mutating func setID(id: String) {
        user.setID(id: id)
    }
    
    mutating func setPhoneNum(phoneNum: String) {
        user.setPhoneNum(phoneNum: phoneNum)
    }
}
