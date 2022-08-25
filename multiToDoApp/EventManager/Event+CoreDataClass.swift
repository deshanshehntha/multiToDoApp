//
//  Event+CoreDataClass.swift
//  multiToDoApp
//
//  Created by Deshan Wattegama on 2022-08-25.
//
//

import Foundation
import CoreData

@objc(EventData)
public class EventData: NSManagedObject {

    convenience init(title: String, eventDescription: String, url: String, date: String, identifier: String, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        
        self.init(context: context)
        
        self.title = title
        self.eventDescription = eventDescription
        self.url = url
        self.date = date
        self.identifier = identifier
      
    }
}
