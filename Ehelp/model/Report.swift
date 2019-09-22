//
//  Report.swift
//  Ehelp
//
//  Created by Mohammed on 6/9/19.
//  Copyright © 2019 Mohammed. All rights reserved.
//

import Foundation
import MapKit

enum Emergency: String {
    case    police = "Police",
            fireFighter = "Fire Fighter",
            ambulance = "Ambulance"
}

struct Report: Codable {
    var emergencyType:  String! 
    var latitude:       Double!
    var longitude:      Double!
    var message:        String!
    var date:    String!

//    
//    mutating func getEmergency() -> String{
//        return self.emergencyType
//    }
//    
//    
//    mutating func getMessage() -> String{
//        return self.message
//    }
//    
//    mutating func getDate() -> String {
//        return self.date
//    }
//    
//    mutating func setEmergency(type: Emergency){
//        self.emergencyType = type.rawValue
//    }
//    
//    mutating func setLocation(lat: Double, long: Double){
//        self.latitude = lat
//        self.longitude = long
//    }
//    
//    mutating func setMessage(msg: String){
//        self.message = msg
//    }
//    
    mutating func setDate(date: String){
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy:HH:mm"
        self.date = formatter.string(from: date)
    }
}
