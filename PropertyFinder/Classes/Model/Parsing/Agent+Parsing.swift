//
//  Agent+Parsing.swift
//  PropertyFinder
//
//  Created by Apokrupto on 24/10/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Foundation

extension Agent: JSONConstructible {
    init?(_ json: JSONFormat) {
        let parser = JSONParser(from: json)
        
        do {
            self.name = try parser.fetch(.agentName)
            self.id   = try parser.fetch(.identifier) { Identifier(id: $0) }
        }
        catch {
            return nil
        }
    }
}
