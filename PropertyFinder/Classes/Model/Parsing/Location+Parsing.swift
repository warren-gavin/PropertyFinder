//
//  Location+Parsing.swift
//  PropertyFinder
//
//  Created by Apokrupto on 24/10/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Foundation
import APDownloader

extension Location: JSONConstructible {
    init?(_ json: JSONFormat) {
        let parser = JSONParser(from: json)
        
        do {
            self.latitude  = try parser.fetch(.latitude)
            self.longitude = try parser.fetch(.longitude)
        }
        catch {
            return nil
        }
    }
}
