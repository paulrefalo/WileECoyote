//
//  SelectedPart.swift
//  WileECoyote
//
//  Created by Paul ReFalo on 8/19/17.
//  Copyright © 2017 QSS. All rights reserved.
//

import Foundation

struct AssemblyPart {

    var description: String?
    var number: String?
    var quantity: Int16
    var serviceBulletin: Bool
    var vendor: String?
    var priceUSD: Int16
    var partSB: NSSet?
    
    init() {
        description = ""
        number = ""
        quantity = 0
        serviceBulletin = false
        vendor = ""
        priceUSD = 0
        partSB = NSSet()
    }
    
    init(initDescription: String?, initNumber: String?, initQuantity: Int16, initServiceBulletin: Bool,
         initVendor: String?, initPriceUSD: Int16, initSB: NSSet?) {
        description = initDescription ?? ""
        number = initNumber ?? ""
        quantity = initQuantity 
        serviceBulletin = initServiceBulletin 
        priceUSD = initPriceUSD 
        partSB = initSB ?? NSSet()
    }

}
