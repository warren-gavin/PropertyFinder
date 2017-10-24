//
//  Property.swift
//  PropertyFinder
//
//  Created by Apokrupto on 24/10/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Foundation

struct Property {
    let id: Identifier
    let title: String
    let subject: String
    
    let thumbnail: URL?
    let largeThumbnail: URL?
    
    let price: Price
    let location: String
    let broker: Broker
    
    let amenities: [Amenities]
    let gps: Location
}
