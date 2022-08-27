//
//  DiaryItemList+CoreDataProperties.swift
//  multiToDoApp
//
//  Created by Ransi on 2022-08-25.
//
//

import Foundation
import CoreData


extension DiaryItemList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DiaryItemList> {
        return NSFetchRequest<DiaryItemList>(entityName: "DiaryItemList")
    }

    @NSManaged public var id: NSNumber!
    @NSManaged public var createdAt: Date?
    @NSManaged public var diaryDescription: String?
    @NSManaged public var deletedAt: Date?

}

extension DiaryItemList : Identifiable {

}
