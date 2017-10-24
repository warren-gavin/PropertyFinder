//
//  JSONConstructible.swift
//  PropertyFinder
//
//  Created by Apokrupto on 24/10/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Foundation

public typealias JSONFormat = [String: Any]

public protocol JSONConstructible {
    init?(_ json: JSONFormat)
}
