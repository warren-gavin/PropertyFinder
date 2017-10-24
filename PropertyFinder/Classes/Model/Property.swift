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

extension Property: JSONConstructible {
    init?(_ json: JSONFormat) {
        let parser = JSONParser(from: json)
        
        do {
            self.id             = try parser.fetch(.identifier) { Identifier(id: $0) }
            self.title          = try parser.fetch(.title)
            self.subject        = try parser.fetch(.subject)
            self.thumbnail      = try parser.fetchOptional(.thumbnail,  transformation: URL.init(string:))
            self.largeThumbnail = try parser.fetchOptional(.largeThumb, transformation: URL.init(string:))
            self.location       = try parser.fetch(.location)
            self.amenities      = try parser.fetch(.amenities) { (keys: [String]) in
                keys.flatMap(Amenities.init(rawValue:))
            }
            
            guard
                let price = Price(json),
                let brokerJson = json[.broker] as? JSONFormat,
                let broker = Broker(brokerJson),
                let gps = Location(json)
            else {
                return nil
            }

            self.broker = broker
            self.price  = price
            self.gps    = gps
        }
        catch {
            return nil
        }
    }
}
