//
//  AcmeBomb.swift
//  WileECoyote
//
//  Created by Paul ReFalo on 8/8/17.
//  Copyright © 2017 QSS. All rights reserved.
//

import UIKit
import CoreData
import Contacts
import ContactsUI

class AcmeBomb: UIViewController, CNContactPickerDelegate {
    
    // MARK: - Properties
    var store = CNContactStore()

    var moc: NSManagedObjectContext?
    var fetchedResultsController : NSFetchedResultsController<Part>!
    
    @IBOutlet weak var dimView: UIView!
    
    
    // Order Popup
    @IBOutlet var orderPopupView: UIViewX!
    
    
    @IBOutlet weak var button1: UIButtonX!
    @IBOutlet weak var button2: UIButtonX!
    @IBOutlet weak var button3: UIButtonX!
    @IBOutlet weak var button4: UIButtonX!
    var buttonsArray = [UIButtonX]()
    
    var selectedPartNumber = String()
    
    @IBOutlet weak var docButton1: UIButtonX!
    @IBOutlet weak var docButton2: UIButtonX!
    @IBOutlet weak var docButton3: UIButtonX!
    @IBOutlet weak var docButton4: UIButtonX!
    
    var docsButtonsArray = [UIButtonX]()
    
    @IBOutlet weak var addPartButton: UIButtonX!
    var fetchedParts = [AssemblyPart]()
    var selectedPart = AssemblyPart()
    
    @IBOutlet weak var partDescription: UILabelX!
    @IBOutlet weak var price: UILabelX!
    @IBOutlet weak var partNumber: UILabelX!
    @IBOutlet weak var referenceDocuments: UILabelX!
    @IBOutlet weak var addToOrder: UIButtonX!
    
    let pdfTitle = "PR Resume Simple 2017"
    
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
        // Inactivate Add button until a part is selected
        addPartButton.isEnabled = false
        addPartButton.alpha = 0.6
        
        buttonsArray.append(button1)
        buttonsArray.append(button2)
        buttonsArray.append(button3)
        buttonsArray.append(button4)

        // From .tag assign custom .name button property
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
            
            fetchPartAndStore(number: button.name, button: button)
        }
        
        docsButtonsArray.append(docButton1)
        docsButtonsArray.append(docButton2)
        docsButtonsArray.append(docButton3)
        docsButtonsArray.append(docButton4)
        
        for button in docsButtonsArray {
            button.isHidden = true
        }
        
    }
    
    
    func fetchPartAndStore(number: String, button: UIButtonX) {
        // Use core data to retrieve unique Part entity with custom button name property
        // Once retrieved, store part as in fetchedParts struct array
        do {
            let fetchRequest = NSFetchRequest<Part>(entityName: "Part")
            fetchRequest.predicate = NSPredicate(format: "partNumber == %@", number)
            let fetchedResults = try moc?.fetch(fetchRequest)
//            print(fetchedResults ?? "No fetched results available")
            if fetchedResults?.count == 1 {
                print("Unique part number found!")
                let fetchedPart = fetchedResults?.first

                let thisPart = AssemblyPart(initDescription: fetchedPart?.partDescription, initNumber: fetchedPart?.partNumber, initQuantity: (fetchedPart?.partQuantity)!, initServiceBulletin: (fetchedPart?.partServiceBulletin)!, initVendor: fetchedPart?.partVendor, initPriceUSD: (fetchedPart?.partPriceUSD)!, initPartDocs: (fetchedPart?.partDocs)!) // removed initSB: fetchedPart?.partSB
                
                
                if thisPart.serviceBulletin == true {
                    // change button border color to red
                    button.borderColor = UIColor.red
                }
                
                fetchedParts.append(thisPart)
            }
        }
        catch {
            print ("fetch task failed", error)
        }
    }
    
    @IBAction func partButtonPressed(_ sender: Any) {
        
        guard let button = sender as? UIButtonX else {
            return
        }
        
        // Loop through fetchedParts array to find the part
        for part in fetchedParts {
            if part.number == button.name {
                selectedPart = part
                addPartButton.isEnabled = true
                addPartButton.alpha = 1.0
            }
        }
        
        for btn in buttonsArray {
            btn.backgroundColor = UIColor.clear
            btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        }
        
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColor.blue, for: UIControlState.normal)
        
        
        // set bottom label text fields
        partDescription.text = selectedPart.description
        price.text = "$ \(selectedPart.priceUSD)"
        partNumber.text = selectedPart.number
        referenceDocuments.text = "Docs:"
        
        for button in docsButtonsArray {    // reset and hide docs buttons when new button is selected
            button.isHidden = true
        }
        
        if selectedPart.partDocs != nil && selectedPart.partDocs != "" {
            if let docsArray = selectedPart.partDocs?.components(separatedBy: ",") {
                var i = 0
                for doc in docsArray {
                    if doc.matches("^SB") {
                        docsButtonsArray[i].borderColor = UIColor.red
                    } else {
                        docsButtonsArray[i].borderColor = UIColor.white
                    }
                    docsButtonsArray[i].setTitle(doc, for: .normal)
                    docsButtonsArray[i].isHidden = false
                    i = i + 1
                }
            }
        }
        
    }
    
    @IBAction func pdfButtonPressed(_ sender: Any) {
        
        if let url = Bundle.main.url(forResource: pdfTitle, withExtension: "pdf") {
            let webView = UIWebView(frame: self.view.frame)
            let urlRequest = URLRequest(url: url)
            webView.loadRequest(urlRequest as URLRequest)
            
            let pdfVC = UIViewController()
            pdfVC.view.addSubview(webView)
            
            pdfVC.edgesForExtendedLayout = [] // This ensures your view is below the navigation bar

            pdfVC.title = pdfTitle
            self.navigationController?.pushViewController(pdfVC, animated: true)
            
        }
    }
    
    
    
    @IBAction func addButtonPressed(_ sender: Any) {
        
        print("Add this part")
        if selectedPart.number != "" {
            print(selectedPart)
            
            orderPopupView.center = view.center
            orderPopupView.alpha = 1
            
            orderPopupView.transform = CGAffineTransform(scaleX: 0.8, y: 1.2)
            
            view.addSubview(orderPopupView)
            
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: [], animations: {
                self.dimView.alpha = 0.7
                self.orderPopupView.transform = .identity
            })
        }
    }
    
    @IBAction func closeOderPopup(_ sender: Any) {
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: [], animations: {
            self.dimView.alpha = 0
            self.orderPopupView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        }) { (success) in
            self.orderPopupView.removeFromSuperview()
        }
    }
    
    // Contacts Section
    func contactPickerAPI() {
        let contactPickerVC = CNContactPickerViewController()
        contactPickerVC.delegate = self
        present(contactPickerVC, animated: true, completion: nil)
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        // You can fetch selected name and number in the following way
        print("didSelect Contact: \(contact.givenName) \(contact.familyName)")
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        print("Did for Cancel")
    }
    
    func searchForContactByName(_ first: String, last: String) -> CNContact? {
        let predicate = CNContact.predicateForContacts(matchingName: last)
        let toFetch = [CNContactGivenNameKey, CNContactFamilyNameKey]
        
        do {
            let contacts = try store.unifiedContacts(matching: predicate, keysToFetch: toFetch as [CNKeyDescriptor])
            
            for contact in contacts {
                if contact.givenName == first && contact.familyName == last {
                    print(contact.givenName)
                    return contact
                }
            }
            
        } catch let err {
            print(err)
        }
        return nil
    }
}

