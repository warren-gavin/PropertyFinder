//
//  Broker+Parsing.swift
//  PropertyFinder
//
//  Created by Apokrupto on 24/10/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Foundation
import APDownloader

extension Broker: JSONConstructible {
    init?(_ json: JSONFormat) {
        let parser = JSONParser(from: json)
        
        do {
            self.id      = try parser.fetch(.identifier) { Identifier(id: $0) }
            self.name    = try parser.fetch(.name)
            self.address = try parser.fetch(.address)
            self.phone   = try parser.fetch(.phone)
            self.email   = try parser.fetch(.email) { Email($0) }
            
            guard let agent = Agent(json) else {
                return nil
            }
            
            self.agent = agent
        }
        catch {
            return nil
        }
    }
}
