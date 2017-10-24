//
//  SearchResponse+Parsing.swift
//  PropertyFinder
//
//  Created by Apokrupto on 24/10/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Foundation

extension SearchResponse: JSONConstructible {
    init?(_ json: JSONFormat) {
        let parser = JSONParser(from: json)
        
        do {
            self.properties = try parser.fetch(.residences) { (results: [JSONFormat]) in
                results.flatMap(Property.init)
            }
        }
        catch {
            return nil
        }
    }
}
