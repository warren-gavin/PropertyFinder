//
//  PropertyViewModel.swift
//  PropertyFinder
//
//  Created by Apokrupto on 25/10/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Foundation

struct PropertyViewModel {
    private static let currencyFormatter: NumberFormatter = {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        
        return currencyFormatter
    }()

    private let property: Property
    
    init(_ property: Property) {
        self.property = property
    }
    
    var title: String {
        return property.subject.capitalized
    }
    
    var subject: String {
        return property.location.capitalized
    }
    
    var thumbnail: URL? {
        return property.thumbnail
    }
    
    var amenities: String {
        return property.amenities.map { $0.description }
                                 .joined(separator: ", ")
    }
    
    var price: String {
        PropertyViewModel.currencyFormatter.currencyCode = property.price.currency.code
        return PropertyViewModel.currencyFormatter.string(from: property.price.value as NSNumber) ?? ""
    }
}
