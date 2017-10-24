//
//  Email.swift
//  PropertyFinder
//
//  Created by Apokrupto on 24/10/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Foundation

public struct Email {
    private struct ValidationRules {
        static let invalidInput = try! NSRegularExpression(pattern: "^[A-Z0-9._%+-@]{6,254}$", options: .caseInsensitive)
        static let validFormat = try! NSRegularExpression(pattern: "^[A-Z0-9._%+-]+@[A-Z0-9-]+[A-Z0-9.-]+\\.[A-Z]{2,63}$", options: .caseInsensitive)
    }
    
    public let address: String
    
    public init?(_ string: String) {
        let range = NSMakeRange(0, string.characters.count)
        let matchingOptions = NSRegularExpression.MatchingOptions(rawValue: 0)
        
        // Quick check that the input string doesn't contain invalid chars and is within the allowed minimum and maximum lengths
        if ValidationRules.invalidInput.numberOfMatches(in: string, options: matchingOptions, range: range) == 0 {
            return nil
        }
        
        if ValidationRules.validFormat.numberOfMatches(in: string, options: matchingOptions, range: range) == 0 {
            return nil
        }
        
        self.address = string
    }

    /// Helper to validate an email.
    ///
    /// - Parameter text: A string representing an email.
    /// - Returns: A boolean indicating whether an email is valid or not.
    public static func isValid(_ text: String?) -> Bool {
        guard let email = text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines), email.characters.count != 0 else {
            return false
        }
        
        return Email(email) != nil
    }
}
