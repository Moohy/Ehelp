//
//  Report+CoreDataProperties.swift
//  
//
//  Created by Mohammed on 16/10/19.
//
//

import Foundation
import CoreData


extension Report {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Report> {
        return NSFetchRequest<Report>(entityName: "Report")
    }

    @NSManaged public var date: String?
    @NSManaged public var emergencyType: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var message: String?

}
