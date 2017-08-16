//
//  Part+CoreDataClass.swift
//  WileECoyote
//
//  Created by Paul ReFalo on 8/14/17.
//  Copyright © 2017 QSS. All rights reserved.
//

import Foundation
import CoreData


public class Part: NSManagedObject {

    // get a Part with the given name or create it if it does not exist
    class func part(withName number: String, in context: NSManagedObjectContext) -> Part {
        
        let partEntity = NSEntityDescription.entity(forEntityName: "Part", in: context)!
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Part")
        request.predicate = NSPredicate(format: "partNumber = %@", number)
        
        // See if Part already exists, if so retur it
        if let matches = try? context.fetch(request) {
            if matches.count > 0 {
                //   print("found ", number)
                return matches.last as! Part
            }
        }
        
        // No Part found, so create the Part() and return it
        let thisPart = Part(entity: partEntity, insertInto: context)
        thisPart.partNumber = number
        //  print ("add" , number)
        return thisPart
    }
    
}
