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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch CNContactStore.authorizationStatus(for: .contacts){
        case .authorized:
            contactsAPI()
        case .notDetermined:
            store.requestAccess(for: .contacts){succeeded, err in
                guard err == nil && succeeded else {
                    return
                }
                self.contactsAPI()  // move
            }
        default:
            print("Not handled")
        }

        addContact("Marvin", last: "the Martian", company: "Mars Inc", street: "888 Mars Drive", city: "Fourth Rock", state: "Mars", postalCode: "80808", imageName: "Marvin")
        addContact("Yosemite", last: "Sam", company: "Rootin' Tootin'", street: "49ers Way", city: "Dallas", state: "Texas", postalCode: "50778", imageName: "YosemiteSam")
        addContact("Bugs", last: "Bunny", company: "Looney Toones", street: "What's up, Doc?", city: "Los Angeles", state: "California", postalCode: "70513", imageName: "BugsBunny")
        addContact("Wile", last: "E Coyote", company: "Genius", street: "111 Desert Way", city: "Gulch", state: "Arizaon", postalCode: "45572", imageName: "Wile")
    }

    // move start
    func contactsAPI() {
        let contactPickerVC = CNContactPickerViewController()
        contactPickerVC.delegate = self
        present(contactPickerVC, animated: true, completion: nil)
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        // You can fetch selected name and number in the following way
        print("didSelect Contact")
        print(contact)
    }

    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        print("Cat for Cancel")
    }
    // move end
    
    func searchForContactByName(_ first: String, last: String) -> Bool {
        let predicate = CNContact.predicateForContacts(matchingName: last)
        let toFetch = [CNContactGivenNameKey, CNContactFamilyNameKey]
        
        do {
            let contacts = try store.unifiedContacts(matching: predicate, keysToFetch: toFetch as [CNKeyDescriptor])
            
            for contact in contacts {
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
    
    func addContact(_ first: String, last: String, company: String, street: String?, city: String?, state: String?, postalCode: String?, imageName: String) {
        
        let foundContact = searchForContactByName(first, last: last)

        guard foundContact == false else {
            print("***********  Contact found.  Guard against Duplicates")
            return
        }
        
        print("Contact NOT found.  Adding Contact...  *********** ")
        
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

        
        if let img = UIImage(named: imageName),
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


