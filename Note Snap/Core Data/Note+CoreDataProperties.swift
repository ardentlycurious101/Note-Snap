//
//  Note+CoreDataProperties.swift
//  
//
//  Created by Elina Lua Ming on 2/10/20.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var languages: [String]?
    @NSManaged public var content: String?
    @NSManaged public var dateCreated: Date?
    @NSManaged public var attribute: NSObject?

}
