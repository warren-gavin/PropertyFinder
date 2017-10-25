//
//  Currency.swift
//  PropertyFinder
//
//  Created by Apokrupto on 24/10/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Foundation

enum Currency: String {
    case aed    = "AED"
    case euro   = "EUR"
    case dollar = "USD"
    case pound  = "GBP"
    
    var code: String {
        return rawValue
    }
}
