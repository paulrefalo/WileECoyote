//
//  partsTabVC.swift
//  WileECoyote
//
//  Created by Paul ReFalo on 7/30/17.
//  Copyright © 2017 QSS. All rights reserved.
//


import UIKit

class partsTabVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        // Remove title from back button
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        // Replace back chevron with asset
        navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "gearBackButton")
//        navigationController?.navigationBar.tintColor = UIColor.black
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "gearBackButton")

    }

}
