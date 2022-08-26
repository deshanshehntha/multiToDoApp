//
//  EventEntity+CoreDataProperties.swift
//  multiToDoApp
//
//  Created by Deshan Wattegama on 2022-08-25.
//
//

import Foundation
import CoreData


extension EventEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EventEntity> {
        return NSFetchRequest<EventEntity>(entityName: "EventEntity")
    }

    @NSManaged public var identifier: String?
    @NSManaged public var date: String?
    @NSManaged public var url: String?
    @NSManaged public var eventDescription: String?
    @NSManaged public var title: String?

}

extension EventEntity : Identifiable {

}
