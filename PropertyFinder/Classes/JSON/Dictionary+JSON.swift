//
//  Dictionary+JSON.swift
//  PropertyFinder
//
//  Created by Apokrupto on 24/10/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Foundation

extension Dictionary where Key == String {
    var json: Data? {
        return try? JSONSerialization.data(withJSONObject: self, options: [])
    }
}
