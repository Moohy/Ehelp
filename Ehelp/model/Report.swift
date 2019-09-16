//
//  Report.swift
//  Ehelp
//
//  Created by Mohammed on 6/9/19.
//  Copyright © 2019 Mohammed. All rights reserved.
//

import Foundation


struct CustomDate {
    // Marked as optional as invalid construction data will produce a nil value
    private (set) var date:Date?
    
    init(day:Int, month:Int, year:Int, hour:Int = 0, minute:Int = 0,
         timeZone:TimeZone = .current) {
        
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.timeZone = timeZone
        dateComponents.minute = minute
        let userCalnedar = Calendar.current
        
        date = userCalnedar.date(from: dateComponents)
    }
}


enum Emergency: String {
    case    police = "Police",
            fireFighter = "Fire Fighter",
            ambulance = "Ambulance"
    
}

struct Report {
    var emergencyType:  Emergency?
    var latitude:       Double?
    var longitude:      Double?
    var message:        String?
    var attachment:     String?
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
    
    mutating func addMessage(msg: String){
        self.message = msg
    }
    
    mutating func addAttachment(attach: String){
        self.attachment = attach
    }
}
