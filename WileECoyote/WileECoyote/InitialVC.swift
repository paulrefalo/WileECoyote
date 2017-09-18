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
        
        let foundContact = searchForContactByName("John", last: "Appleseed")
        if foundContact {
            print("***********  Found Contact is: \(foundContact)")
        } else {
            print("Contact NOT found.  Adding Contact...  *********** ")
            
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func contactsAPI() {
//        let predicate = CNContact.predicateForContacts(matchingName: "john")
//        let toFetch = [CNContactGivenNameKey, CNContactFamilyNameKey]
//        
//        do {
//            let contacts = try store.unifiedContacts(
//                matching: predicate, keysToFetch: toFetch as [CNKeyDescriptor])
//            
//            for contact in contacts{
//                print(contact.givenName)
//                print(contact.familyName)
//                print(contact.identifier)
//            }
//            
//        } catch let err{
//            print(err)
//        }

        
        let contactPickerVC = CNContactPickerViewController()
        
        contactPickerVC.delegate = self
        
        present(contactPickerVC, animated: true, completion: nil)
    
        var selectedContact = CNContact()
        

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
    
    func searchForContactByName(_ first: String, last: String) -> Bool {
//        let predicate = CNContact.predicateForContacts(withIdentifiers: [last])
        let predicate = CNContact.predicateForContacts(matchingName: last)

        let toFetch = [CNContactGivenNameKey, CNContactFamilyNameKey]
        
        do {
            let contacts = try store.unifiedContacts(
                matching: predicate, keysToFetch: toFetch as [CNKeyDescriptor])
            
            for contact in contacts{
                if contact.givenName == first && contact.familyName == last {
                    print(contact.givenName)
                    return true
                }
            }
            
        } catch let err{
            print(err)
        }
        
        return false
    }
    
    func addContact(_ first: String, last: String, company: String, street: String?, city: String?, state: String?, postalCode: String?) {
        let contact = CNMutableContact()
        contact.givenName = first
        contact.familyName = last
        contact.organizationName = company
        
        let workAddress = CNMutablePostalAddress()
        if let streetString = street {
            workAddress.street = streetString
        }
        if let cityString = city {
            workAddress.city = cityString
        }
        if let stateString = state {
            workAddress.state = stateString
        }
        if let postalCodeString = postalCode {
            workAddress.postalCode = postalCodeString
        }
        
        contact.postalAddresses = [CNLabeledValue(label:CNLabelWork, value:workAddress)]

        
        if let img = UIImage(named: "apple"),
            let data = UIImagePNGRepresentation(img){
            contact.imageData = data
        }
        
        //finally save
        let request = CNSaveRequest()
        request.add(contact, toContainerWithIdentifier: nil)
        do {
            try store.execute(request)
            print("Successfully stored the contact")
        } catch let err {
            print("Failed to save the contact. \(err)")
        }
    }

}


