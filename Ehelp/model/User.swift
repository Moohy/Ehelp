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
    var email:          String!
    var password:       String!
    var name:           String!
    var id:             String!
    var phoneNum:    String!
    
    var dict: [String: Any] {
        return ["email": email!,
                "password": password!,
                "name": name!,
                "id": id!,
                "phoneNum":phoneNum!]
    }
}
