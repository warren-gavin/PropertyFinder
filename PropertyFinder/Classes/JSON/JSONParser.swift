//
//  JSONParser.swift
//  PropertyFinder
//
//  Created by Apokrupto on 24/10/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

// Copy of Soroush Khanlou's JSON parser, with some small modifications for Swift 3 and renaming
//
// Code is part of the blog post http://khanlou.com/2016/04/decoding-json/

enum JSONError: Error {
    case keyNotFound
    case wrongKey(Any.Type)
    case transformFailed
}

public struct JSONParser {
    private let dictionary: JSONFormat
    
    public init(from dictionary: JSONFormat) {
        self.dictionary = dictionary
    }
    
    public func fetch<T>(_ key: String) throws -> T {
        let fetchedOptional = dictionary[key]
        
        guard let fetched = fetchedOptional else  {
            throw JSONError.keyNotFound
        }
        
        guard let typed = fetched as? T else {
            throw JSONError.wrongKey(type(of: fetched))
        }

        return typed
    }
    
    public func fetch<T, U>(_ key: String, transformation: (T) -> (U?)) throws -> U {
        let fetched: T = try fetch(key)
        
        guard let transformed = transformation(fetched) else {
            throw JSONError.transformFailed
        }
        
        return transformed
    }
    
    public func fetchOptional<T>(_ key: String) throws -> T? {
        let fetchedOptional = dictionary[key]
        
        guard let fetched = fetchedOptional else {
            return nil
        }
        
        guard let typed = fetched as? T else {
            throw JSONError.wrongKey(type(of: fetched))
        }
        
        return typed
    }
    
    public func fetchOptional<T, U>(_ key: String, transformation: (T) -> (U?)) throws -> U? {
        guard let fetchedOptional: T = try fetchOptional(key) else {
            return nil
        }
        
        return transformation(fetchedOptional)
    }
}
