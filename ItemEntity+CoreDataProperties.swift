//
//  ItemEntity+CoreDataProperties.swift
//  TodoList App
//
//  Created by admin on 18/12/2021.
//
//

import Foundation
import CoreData


extension ItemEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemEntity> {
        return NSFetchRequest<ItemEntity>(entityName: "ItemEntity")
    }

    @NSManaged public var title: String?
    @NSManaged public var note: String?
    @NSManaged public var date: Date?
    @NSManaged public var isChecked: Bool

}

extension ItemEntity : Identifiable {

}
