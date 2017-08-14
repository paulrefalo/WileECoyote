//
//  Part+CoreDataProperties.swift
//  WileECoyote
//
//  Created by Paul ReFalo on 8/13/17.
//  Copyright © 2017 QSS. All rights reserved.
//

import Foundation
import CoreData


extension Part {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Part> {
        return NSFetchRequest<Part>(entityName: "Part")
    }

    @NSManaged public var partDescription: String?
    @NSManaged public var partNumber: String?
    @NSManaged public var partQuantity: Int16
    @NSManaged public var partServiceBulletin: Bool
    @NSManaged public var partVendor: String?
    @NSManaged public var partSB: NSSet?
    @NSManaged public var uniqueOrder: Order?

}

// MARK: Generated accessors for partSB
extension Part {

    @objc(addPartSBObject:)
    @NSManaged public func addToPartSB(_ value: ServiceBulletin)

    @objc(removePartSBObject:)
    @NSManaged public func removeFromPartSB(_ value: ServiceBulletin)

    @objc(addPartSB:)
    @NSManaged public func addToPartSB(_ values: NSSet)

    @objc(removePartSB:)
    @NSManaged public func removeFromPartSB(_ values: NSSet)

}
