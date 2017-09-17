//
//  ViewController.swift
//  WileECoyote
//
//  Created by Paul ReFalo on 7/26/17.
//  Copyright © 2017 QSS. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

class InitialVC: UIViewController, CNContactPickerDelegate {
    
    // MARK: Outlets
    var store = CNContactStore()

    
//    @IBOutlet weak var partsDiagram: UIButtonX!
//    @IBOutlet weak var orderQueue: UIButtonX!
//    @IBOutlet weak var orderHistory: UIButtonX!

    @IBOutlet weak var filterView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch CNContactStore.authorizationStatus(for: .contacts){
        case .authorized:
            contactsAPI()
        case .notDetermined:
            store.requestAccess(for: .contacts){succeeded, err in
                guard err == nil && succeeded else{
                    return
                }
                self.contactsAPI()
            }
        default:
            print("Not handled")
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func contactsAPI() {
        let predicate = CNContact.predicateForContacts(matchingName: "john")
        let toFetch = [CNContactGivenNameKey, CNContactFamilyNameKey]
        
        do{
            let contacts = try store.unifiedContacts(
                matching: predicate, keysToFetch: toFetch as [CNKeyDescriptor])
            
            for contact in contacts{
                print(contact.givenName)
                print(contact.familyName)
                print(contact.identifier)
            }
            
        } catch let err{
            print(err)
        }
        
//        let controller = CNContactPickerViewController()
//        
//        controller.delegate = self
//        
//        navigationController?.present(controller, animated: true, completion: nil)
        
        let contactPickerVC = CNContactPickerViewController()
        
//        contactPickerViewController.predicateForEnablingContact = NSPredicate(format: "birthday != nil")
        
        contactPickerVC.delegate = self
        
        present(contactPickerVC, animated: true, completion: nil)
    
        var selectedContact = CNContact()
        

        
//        func contactPicker(picker: CNContactPickerViewController, didSelectContact contact: CNContact) {
////            delegate.didFetchContacts([contact])
//            contactPickerVC.delegate?.contactPicker!(contactPickerVC, didSelect: contact)
//            navigationController?.popViewController(animated: true)
//        }
        
        /*
        func contactPicker(picker: CNContactPickerViewController,
                           didSelectContact contact: CNContact) {
            
            print("Selected a contact")
            selectedContact = contact
            print(selectedContact)
            contactPickerDidCancel(picker: contactPickerViewController)
            
            if contact.isKeyAvailable(CNContactPhoneNumbersKey){
                //this is an extension I've written on CNContact
//                contact.printPhoneNumbers()
                print(contact.phoneNumbers)
            } else {
                /*
                 TOOD: partially fetched, use what you've learnt in this chapter to
                 fetch the rest of this contact
                 */
                print("No phone numbers are available")
            }
            
        }
        */

    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        // You can fetch selected name and number in the following way
        print("Monkey")
        // user name
        let userName:String = contact.givenName

        // user phone number
        let userPhoneNumbers:[CNLabeledValue<CNPhoneNumber>] = contact.phoneNumbers
        let firstPhoneNumber:CNPhoneNumber = userPhoneNumbers[0].value

        // user phone number string
        let primaryPhoneNumberStr:String = firstPhoneNumber.stringValue
        
        print(contact)
    }

    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        print("Cat")
    }

}


