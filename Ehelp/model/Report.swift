//
//  Report.swift
//  Ehelp
//
//  Created by Mohammed on 6/9/19.
//  Copyright © 2019 Mohammed. All rights reserved.
//

import Foundation

enum Emergency: String {
    case    police = "Police",
            fireFighter = "Fire Fighter",
            ambulance = "Ambulance"
    
//    var emergency: String {
//        switch self{
//        case .police:       return "Police";
//        case .fireFighter:  return "Fire Fighter";
//        case .ambulance:    return "Ambulance";
//        }
//    }
    
}

struct Report {
    var emergencyType:          Emergency?
    var latitude:       Double?
    var longitude:      Double?
    var message:        String?
    var attachent:      String?
    public var date:    String? // TODO: needs to be a class of data
    
    init(){
        
    }
    
    mutating func addEmergency(type: Emergency){
        self.emergencyType = type
    }
    
    mutating func addLocation(lat: Double, long: Double){
        self.latitude = lat
        self.longitude = long
    }
    
    mutating func addMessage(message: String){
        self.message = message
    }
    
    mutating func addAttachment(attach: String){
        self.attachent = attach
    }
}
