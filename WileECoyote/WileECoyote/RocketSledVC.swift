//
//  RocketSledVC.swift
//  WileECoyote
//
//  Created by Paul ReFalo on 8/4/17.
//  Copyright © 2017 QSS. All rights reserved.
//

import UIKit

class rocketSledVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // Action for buttons
    
    @IBAction func partButtonPressed(_ sender: Any) {
        guard let button = sender as? UIButtonX else {
            return
        }
        
//        switch button.tag {
//        case 1:
//        // Change to English
//        case 2:
//        // Change to Spanish
//        case 3:
//        // Change to French, etc
//        default:
//            print("Unknown language")
//            return
//        }
        
        print("Button pressed: \(button.tag)")
    }
    
    
}
