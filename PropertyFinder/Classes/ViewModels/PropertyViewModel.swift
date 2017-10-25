//
//  PropertyViewModel.swift
//  PropertyFinder
//
//  Created by Apokrupto on 25/10/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Foundation

struct PropertyViewModel {
    private let property: Property
    
    init(_ property: Property) {
        self.property = property
    }
    
    var title: String {
        return "\(property.title), \(property.location)".capitalized
    }
    
    var subject: String {
        return property.subject.capitalized
    }
    
    var thumbnail: URL? {
        return property.thumbnail
    }
    
    var amenities: String {
        return property.amenities.map { $0.description }
                                 .joined(separator: ", ")
    }
    
    var price: String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.currencyCode = property.price.currency.code
        currencyFormatter.numberStyle = .currency
        
        let value = property.price.value as NSNumber
        return currencyFormatter.string(from: value) ?? ""
    }
}
