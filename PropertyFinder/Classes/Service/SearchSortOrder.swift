//
//  SearchSortOrder.swift
//  PropertyFinder
//
//  Created by Apokrupto on 24/10/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Foundation

struct SearchSortOrder {
    let criterion: SortCriterion
    let direction: SortDirection
    
    var code: String {
        return "\(criterion.code)\(direction.code)"
    }
}

enum SortCriterion {
    case price
    case bedrooms
    
    var code: String {
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
    
    var code: String {
        switch self {
        case .ascending:
            return "a"
            
        case .descending:
            return "d"
        }
    }
}
