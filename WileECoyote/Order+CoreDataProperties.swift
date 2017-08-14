//
//  Order+CoreDataProperties.swift
//  WileECoyote
//
//  Created by Paul ReFalo on 8/13/17.
//  Copyright © 2017 QSS. All rights reserved.
//

import Foundation
import CoreData


extension Order {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Order> {
        return NSFetchRequest<Order>(entityName: "Order")
    }

    @NSManaged public var created: NSDate?
    @NSManaged public var deliveryCity: String?
    @NSManaged public var deliveryCompany: String?
    @NSManaged public var deliveryState: String?
    @NSManaged public var deliveryStreet: String?
    @NSManaged public var deliveryZipCode: String?
    @NSManaged public var fullNameFSE: String?
    @NSManaged public var uniqueOrderID: String?
    @NSManaged public var items: NSSet?

}

// MARK: Generated accessors for items
extension Order {

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: Part)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: Part)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSSet)

}
