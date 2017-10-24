//
//  Data+JSON.swift
//  PropertyFinder
//
//  Created by Apokrupto on 24/10/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Foundation

extension Data {
    var json: JSONFormat? {
        return (try? JSONSerialization.jsonObject(with: self)) as? JSONFormat
    }
}
