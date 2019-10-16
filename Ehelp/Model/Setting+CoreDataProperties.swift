//
//  Setting+CoreDataProperties.swift
//  
//
//  Created by Mohammed on 16/10/19.
//
//

import Foundation
import CoreData


extension Setting {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Setting> {
        return NSFetchRequest<Setting>(entityName: "Setting")
    }

    @NSManaged public var faceId: Bool

}
