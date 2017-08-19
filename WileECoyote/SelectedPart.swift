//
//  SelectedPart.swift
//  WileECoyote
//
//  Created by Paul ReFalo on 8/19/17.
//  Copyright © 2017 QSS. All rights reserved.
//

import Foundation

struct SelectedPart {

    var partDescription: String?
    var partNumber: String?
    var partQuantity: Int16
    var partServiceBulletin: Bool
    var partVendor: String?
    var partPriceUSD: Int16
    var partSB: NSSet?
    var uniqueOrder: Order?
    
//    init(partNumber: String) {
//        temperature = temp
//    }
}
