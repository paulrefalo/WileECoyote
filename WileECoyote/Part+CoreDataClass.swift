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

    // get a pigment with the given name. creates if DNE
    class func part(withName number: String, in context: NSManagedObjectContext) -> Part {
        
        
        let partEntity = NSEntityDescription.entity(forEntityName: "Part", in: context)!
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Part")
        request.predicate = NSPredicate(format: "partNumber = %@", number)
        if let matches = try? context.fetch(request) {
            if matches.count > 0 {
                //   print("found ", number)
                return matches.last as! Part
            }
            
        }
        let thisPart = Part(entity: partEntity, insertInto: context)
        thisPart.partNumber = number
        //  print ("add" , number)
        return thisPart
    }
    
}
