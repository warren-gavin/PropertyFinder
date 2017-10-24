//
//  JSONParser+Apokrupto.swift
//  PropertyFinder
//
//  Created by Apokrupto on 24/10/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Foundation

/**
 Bloomlife additions to Khanlou's JSON Parser
 */
public protocol JSONParseable {
    init?(_ json: JSONFormat)
}

public protocol JSONSignalEventIntervalParseable {
    init?(_ json: JSONFormat, startTime: Date)
}

extension JSONParser {
    /**
     Generic parser for a JSON list of elements, which will create an array of parsed types
     
     This is similar to fetchArray, except it applies to a dictionary rather than an array. This method
     would be used for e.g. Firebase JSON which returns dictionaries rather than arrays.
     
     The use is as follows, given a standard JSON response using arrays
     
     "A": [
         "B-1": {
            //...
         },
         "B-2": {
            //...
         }
     ]
     
     This would be encoded using dictionaries by adding a new key "B" to
     
     "A": {
         "B": {
             "B-1": {
                //...
             },
             "B-2": {
                //...
             }
         }
     }
     
     Any "B-n" object would be created normally B(_:)
     A "A" object would be created using the dictionary value keyed on "B"
     
     Our model is
     
     public struct A {
        let blist: [B]
     }
     
     public struct B {
        //...
     }
     
     let blist = list(json, key: "B") { (key, value) in
        B(value)
     }

     let a = A(blist: blist)
     
     This will get the dictionaries keyed on "B" and pass them to the transform, which returns objects of type B.
     
     Because dictionaries do not guarantee an order, the parsed result is unlikely to have the same order
     as the JSON text.
     */
    public func list<T>(_ json: JSONFormat, key: String, transformation: (String, Any) throws -> T?) -> [T]? {
        do {
            let data: JSONFormat = try fetch(key)
            return list(data, transformation: transformation)
        }
        catch {
            return nil
        }
    }
    
    public func list<T>(_ json: JSONFormat, transformation: (String, Any) throws -> T?) -> [T]? {
        do {
            let list = try json.flatMap(transformation)
            
            if list.isEmpty {
                return nil
            }
            
            return list
        }
        catch {
            return nil
        }
    }
    
    /// A sorted version of the keyed list<T> method.
    ///
    /// - Parameters:
    ///   - json: Incoming dictionary data
    ///   - key: Name of the parent node containing the list data
    ///   - sorter: comparator closure
    ///   - transformation: closure for transforming the incoming dictionary data into the
    ///                     required data type returned as T
    /// - Returns: Sorted array of objects of type T as created in the transform
    public func sorted<T>(_ json: JSONFormat,
                          key: String,
                          by sorter: (T, T) -> Bool,
                          transformation: (String, Any) throws -> T?) -> [T]? where T: Comparable {
        return list(json, key: key, transformation: transformation)?.sorted(by: sorter)
    }
    
    /// A sorted version of the list<T> method
    ///
    /// - Parameters:
    ///   - json: Incoming dictionary data
    ///   - sorter: comparator closure
    ///   - transformation: closure for transforming the incoming dictionary data into the
    ///                     required data type returned as T
    /// - Returns: Sorted array of objects of type T as created in the transform
    public func sorted<T>(_ json: JSONFormat,
                          by sorter: (T, T) -> Bool,
                          transformation: (String, Any) throws -> T?) -> [T]? where T: Comparable {
        return list(json, transformation: transformation)?.sorted(by: sorter)
    }
}
