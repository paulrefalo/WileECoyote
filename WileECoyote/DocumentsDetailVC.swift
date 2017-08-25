//
//  DocumentsDetailVC.swift
//  WileECoyote
//
//  Created by Paul ReFalo on 8/24/17.
//  Copyright © 2017 QSS. All rights reserved.
//

import UIKit
import CoreData

class DocumentsDetail: UIViewController {
    
    // MARK: - Properties
    
    var moc: NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK:  Core Data Stack and get moc
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        moc = appDelegate.coreDataStack.managedObjectContext
        
        // Remove title from back button
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        
    }

}
