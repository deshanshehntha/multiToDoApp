//
//  Event+CoreDataProperties.swift
//  multiToDoApp
//
//  Created by Deshan Wattegama on 2022-08-25.
//
//

import Foundation
import CoreData


extension EventData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EventData> {
//        return NSFetchRequest<Event>(entityName: "Event")
                return NSFetchRequest(entityName: "EventData")

    }
    
    @NSManaged public var title: String?
    @NSManaged public var eventDescription: String?
    @NSManaged public var url: String?
    @NSManaged public var date: String?
    @NSManaged public var identifier: String?


}

extension EventData : Identifiable {

}
