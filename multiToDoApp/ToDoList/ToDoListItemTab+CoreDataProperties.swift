//
//  ToDoListItemTab+CoreDataProperties.swift
//  multiToDoApp
//
//  Created by user219465 on 8/24/22.
//
//

import Foundation
import CoreData


extension ToDoListItemTab {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoListItemTab> {
        return NSFetchRequest<ToDoListItemTab>(entityName: "ToDoListItemTab")
    }

    @NSManaged public var note: String?
    @NSManaged public var createdAt: Date?
    @NSManaged public var plannedDate: Date?
    @NSManaged public var noteDescription: String?
    @NSManaged public var status: String?

}

extension ToDoListItemTab : Identifiable {

}
