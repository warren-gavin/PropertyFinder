//
//  Amenities.swift
//  PropertyFinder
//
//  Created by Apokrupto on 24/10/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Foundation

/// Not all amenities from the list, but enough for example code
enum Amenities: String {
    case maidsRoom       = "MR"
    case centralAC       = "AC"
    case balcony         = "BA"
    case privateGarden   = "PG"
    case privatePool     = "PP"
    case sharedPool      = "SP"
    case security        = "SE"
    case coveredParking  = "CP"
    case builtInWardrobe = "BW"
    case waterView       = "VW"
    case petsAllowed     = "PA"
    case networked       = "AN"
    case concierge       = "CS"
    
    var description: String {
        switch self {
        case .maidsRoom:
            return NSLocalizedString("Maids Room", comment: "")

        case .centralAC:
            return NSLocalizedString("Central A/C", comment: "")
            
        case .balcony:
            return NSLocalizedString("Balcony", comment: "")

        case .privateGarden:
            return NSLocalizedString("Private garden", comment: "")

        case .privatePool:
            return NSLocalizedString("Private pool", comment: "")

        case .sharedPool:
            return NSLocalizedString("Shared pool", comment: "")

        case .security:
            return NSLocalizedString("Security", comment: "")

        case .coveredParking:
            return NSLocalizedString("Covered parking", comment: "")

        case .builtInWardrobe:
            return NSLocalizedString("Built in wardrobes", comment: "")

        case .waterView:
            return NSLocalizedString("View of water", comment: "")

        case .petsAllowed:
            return NSLocalizedString("Pets allowed", comment: "")
            
        case .networked:
            return NSLocalizedString("Networked", comment: "")
            
        case .concierge:
            return NSLocalizedString("Concierge", comment: "")
        }
    }
}
