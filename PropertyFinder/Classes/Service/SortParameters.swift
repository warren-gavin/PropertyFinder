//
//  SortParameters.swift
//  PropertyFinder
//
//  Created by Apokrupto on 24/10/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Foundation

struct SortParameters {
    let criterion: SortCriterion
    let direction: SortDirection
    
    var encoding: String {
        return "\(criterion.encoding)\(direction.encoding)"
    }
}

enum SortCriterion {
    case price
    case bedrooms
    
    var encoding: String {
        switch self {
        case .price:
            return "p"
            
        case .bedrooms:
            return "b"
        }
    }
}

enum SortDirection {
    case ascending
    case descending
    
    var encoding: String {
        switch self {
        case .ascending:
            return "a"
            
        case .descending:
            return "d"
        }
    }
}
