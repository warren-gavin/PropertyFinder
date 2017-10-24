//
//  Price+Parsing.swift
//  PropertyFinder
//
//  Created by Apokrupto on 24/10/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Foundation

extension Price: JSONConstructible {
    init?(_ json: JSONFormat) {
        let parser = JSONParser(from: json)
        
        do {
            self.value = try parser.fetch(.price) { (price: String) in
                let formatter = NumberFormatter()
                formatter.numberStyle = .decimal
                formatter.locale = Locale(identifier: "en_GB")
                
                guard let num = formatter.number(from: price) else {
                    return nil
                }
                
                return num.intValue
            }
            self.currency = try parser.fetch(.currency, transformation: Currency.init(rawValue:))
        }
        catch {
            return nil
        }
    }
}
