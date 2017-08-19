//
//  AcmeBomb.swift
//  WileECoyote
//
//  Created by Paul ReFalo on 8/8/17.
//  Copyright © 2017 QSS. All rights reserved.
//

import UIKit
import CoreData

class AcmeBomb: UIViewController {
    
    // MARK: - Properties
    
    var moc: NSManagedObjectContext?
    var fetchedResultsController : NSFetchedResultsController<Part>!
    
    @IBOutlet weak var button1: UIButtonX!
    @IBOutlet weak var button2: UIButtonX!
    @IBOutlet weak var button3: UIButtonX!
    @IBOutlet weak var button4: UIButtonX!
    var buttonsArray = [UIButtonX]()
    
    var selectedPartNumber = String()
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK:  Core Data Stack and get moc
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        moc = appDelegate.coreDataStack.managedObjectContext
        
        // Remove title from back button
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        configureButtons()
        
    }
    
    func configureButtons() {
        buttonsArray.append(button1)
        buttonsArray.append(button2)
        buttonsArray.append(button3)
        buttonsArray.append(button4)

        for button in buttonsArray {
            switch button.tag {
            case 1:
                button.name = "58-2662-41"
            case 2:
                button.name = "58-2662-42"
            case 3:
                button.name = "58-2662-43"
            case 4:
                button.name = "58-2662-44"
            default:
                print("Unknown part")
                return
            }
            


        }
    }
    
    @IBAction func partButtonPressed(_ sender: Any) {
        guard let button = sender as? UIButtonX else {
            return
        }
        
        print("Button pressed: \(button.name)")
//        
//        let fetchRequest = NSFetchRequest<Part>(entityName: "Part")
//        fetchRequest.predicate = NSPredicate(format: "partNumber == %@", button.name)
        
        do {
            let fetchRequest = NSFetchRequest<Part>(entityName: "Part")
            fetchRequest.predicate = NSPredicate(format: "partNumber == %@", button.name)
            let fetchedResults = try moc?.fetch(fetchRequest)
            print(fetchedResults ?? "No fetched results available")
            if fetchedResults?.count == 1 {
                print("Unique part number found!")
                let fetchedPart = fetchedResults?.first
                print(fetchedPart?.partDescription)
                dump(fetchedPart)
            }
            
        }
        catch {
            print ("fetch task failed", error)
        }
        
    }
    

    
}
