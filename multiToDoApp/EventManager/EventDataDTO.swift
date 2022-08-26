//
//  Event.swift
//  multiToDoApp
//
//  Created by Deshan Wattegama on 2022-08-25.
//

import Foundation

class EventDataDTO
{
    var title: String
    var eventDescription: String
    var url: String
    var date: String
    var identifier: String

    init(title: String, eventDescription: String, url: String, date: String, identifier: String) {
        self.title = title
        self.eventDescription = eventDescription
        self.url = url
        self.date = date
        self.identifier = identifier

    }
    

}
