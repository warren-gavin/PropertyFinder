//
//  Price+Parsing.swift
//  PropertyFinder
//
//  Created by Apokrupto on 24/10/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Foundation
import APDownloader

private let numberFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    
    return formatter
}()

extension Price: JSONConstructible {
    init?(_ json: JSONFormat) {
        let parser = JSONParser(from: json)
        
        do {
            self.value = try parser.fetch(.price) { (price: String) in
                guard let num = numberFormatter.number(from: price) else {
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
