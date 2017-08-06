//
//  RocketSledVC.swift
//  WileECoyote
//
//  Created by Paul ReFalo on 8/4/17.
//  Copyright © 2017 QSS. All rights reserved.
//

import UIKit

class rocketSledVC: UIViewController {
    
    var scalarX: Float = 0.0
    var scalarY: Float = 0.0
    var originalWidth: Float = 0.0
    var originalHeight: Float = 0.0
    var buttons = [UIButtonX]()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var buttonA: UIButtonX!
    @IBOutlet weak var buttonB: UIButtonX!
    @IBOutlet weak var buttonC: UIButtonX!
    @IBOutlet weak var buttonD: UIButtonX!
    
    @IBOutlet weak var buttonE: UIButtonX!
    
    @IBOutlet weak var buttonF: UIButtonX!
    
    @IBOutlet weak var buttonG: UIButtonX!
    
    
    override func loadView() {
        super.loadView()
        let prewidth = imageView.frame.size.width
        let preheight = imageView.frame.size.height
        print("loadView", prewidth, preheight)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        originalWidth = Float(imageView.frame.width)
        originalHeight = Float(imageView.frame.height)
        print("viewDidLoad", originalWidth, originalHeight)
        
        buttons.append(buttonA)
        buttons.append(buttonB)
        buttons.append(buttonC)
        buttons.append(buttonD)
        buttons.append(buttonE)
        buttons.append(buttonF)
        buttons.append(buttonG)

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let postWidth = Float(imageView.frame.width)
        let postHeight = Float(imageView.frame.height)
        print("viewDidAppear", postWidth, postHeight)
        scalarX = postWidth / originalWidth
        scalarY = postHeight / originalHeight
        
        for button in buttons {
            moveButton(scalarX: scalarX, scalarY: scalarY, button: button)
        }
        
//        let buttonX = Float(buttonA.frame.origin.x)
//        let buttonCenter = buttonA.center
////        let buttonY = Float(buttonA.frame.origin.y)
//        
//        let scaleX = CGFloat(Float(buttonCenter.x) * scalarX)
//        let scaleY = CGFloat(Float(buttonCenter.y) * scalarY)
//        
//        
//        let deltaX = CGFloat(scaleX - buttonCenter.x)
//        let deltaY = CGFloat(scaleY - buttonCenter.y)
//        
//        
//        
//        UIView.animate(withDuration: 0.3) {
////            self.buttonA.transform.translatedBy(x: deltaX, y: deltaY)
//            self.buttonA.transform.tx += CGFloat(deltaY)
//            self.buttonA.transform.ty += CGFloat(deltaX)
//        }
    }
    
    func moveButton(scalarX: Float, scalarY: Float, button: UIButtonX) {
        let buttonCenter = button.center
        
        let scaleX = CGFloat(Float(buttonCenter.x) * scalarX)
        let scaleY = CGFloat(Float(button.frame.origin.y + 3) * scalarY)
        
        
        let deltaX = CGFloat(scaleX - buttonCenter.x)
        let deltaY = CGFloat(scaleY - buttonCenter.y)
        

//        UIView.animate(withDuration: 0.8) {
//            button.transform.tx += CGFloat(deltaY)
//            button.transform.ty += CGFloat(deltaX)
//        }
        
        UIView.animate(withDuration: 0.3, delay: 0, animations: {
                button.transform.tx += CGFloat(deltaX)
                button.transform.ty += CGFloat(deltaY)
        })
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
