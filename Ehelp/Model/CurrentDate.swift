//
//  Date.swift
//  Ehelp
//
//  Created by Mohammed on 16/10/19.
//  Copyright © 2019 Mohammed. All rights reserved.
//

import Foundation

struct CurrentDate {
//
//    var currentDate: String!
    
    init(){
//        setDate()
    }

    
    func setDate() -> String{
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm"
        return formatter.string(from: date)
        
    }
}
