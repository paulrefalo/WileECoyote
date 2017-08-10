//
//  AcmeBomb.swift
//  WileECoyote
//
//  Created by Paul ReFalo on 8/8/17.
//  Copyright © 2017 QSS. All rights reserved.
//

import UIKit

class AcmeBomb: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Remove title from back button
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
    }
    
}
