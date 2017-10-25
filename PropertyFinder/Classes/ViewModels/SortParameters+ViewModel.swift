//
//  SortParameters+ViewModel.swift
//  PropertyFinder
//
//  Created by Apokrupto on 25/10/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Foundation

protocol CustomTextConvertible {
    var text: String { get }
}

extension SortCriterion: CustomTextConvertible {
    var text: String {
        switch self {
        case .price:
            return NSLocalizedString("Price", comment: "")
            
        case .bedrooms:
            return NSLocalizedString("Beds", comment: "")
        }
    }
}

extension SortDirection: CustomTextConvertible {
    var text: String {
        switch self {
        case .ascending:
            return NSLocalizedString("Ascending", comment: "")
            
        case .descending:
            return NSLocalizedString("Descending", comment: "")
        }
    }
}
