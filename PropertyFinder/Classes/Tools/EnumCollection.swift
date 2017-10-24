//
//  EnumCollection.swift
//  PropertyFinder
//
//  Created by Apokrupto on 24/10/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Foundation

public protocol EnumCollection {
    static var allCases: [Self] { get }
}

extension EnumCollection where Self: Hashable {
    private static func cases() -> AnySequence<Self> {
        return AnySequence { () -> AnyIterator<Self> in
            var raw = 0

            return AnyIterator {
                let current: Self = withUnsafePointer(to: &raw) {
                    $0.withMemoryRebound(to: Self.self, capacity: 1) {
                        $0.pointee
                    }
                }
                
                guard current.hashValue == raw else {
                    return nil
                }
                
                raw += 1
                return current
            }
        }
    }
    
    public static var allCases: [Self] {
        return Array(self.cases())
    }
    
    public static var count: Int {
        return allCases.count
    }
}
