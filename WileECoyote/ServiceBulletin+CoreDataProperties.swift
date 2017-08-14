//
//  ServiceBulletin+CoreDataProperties.swift
//  WileECoyote
//
//  Created by Paul ReFalo on 8/13/17.
//  Copyright © 2017 QSS. All rights reserved.
//

import Foundation
import CoreData


extension ServiceBulletin {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ServiceBulletin> {
        return NSFetchRequest<ServiceBulletin>(entityName: "ServiceBulletin")
    }

    @NSManaged public var textSB: String?
    @NSManaged public var uniqueSBNumber: Int16
    @NSManaged public var partToSB: Part?

}
