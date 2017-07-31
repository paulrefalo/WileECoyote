//
//  ViewController.swift
//  WileECoyote
//
//  Created by Paul ReFalo on 7/26/17.
//  Copyright © 2017 QSS. All rights reserved.
//

import UIKit

class InitialVC: UIViewController {
    
    // MARK: Outlets
    
    
    @IBOutlet weak var partsDiagram: UIButtonX!
    @IBOutlet weak var orderQueue: UIButtonX!
    @IBOutlet weak var orderHistory: UIButtonX!

    @IBOutlet weak var filterView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        configureUI()
    }
    
    func configureUI() {
        // move buttons to the top layer
        partsDiagram.layer.zPosition = 5
        orderQueue.layer.zPosition = 5
        orderHistory.layer.zPosition = 5
        
        filterView.layer.zPosition = 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

