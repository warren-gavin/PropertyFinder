//
//  ReusableView.swift
//  PropertyFinder
//
//  Created by Apokrupto on 25/10/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import UIKit

// Reproduction of my gist at https://gist.github.com/warren-gavin/2480e12f69e915eb127c606f45b088ec


/**
 * Reusable view identifiers based on the view's class name. This removes the issue of stringly typed
 * reuse identifiers.
 *
 * Based on the article at http://alisoftware.github.io/swift/generics/2016/01/06/generic-tableviewcells/
 * but with a few small changes, and leaves out the Nibs.
 */
public protocol ReusableView: class {
    static var reuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}

// MARK: - Table Views
extension UITableViewCell: ReusableView {}

extension UITableView {
    public func cellForReusableView<T: ReusableView>(at indexPath: IndexPath? = nil) -> T {
        if let indexPath = indexPath {
            return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
        }
        
        return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier) as! T
    }
}

// MARK: - Collection Views
extension UICollectionViewCell: ReusableView {}

extension UICollectionView {
    public func cellForReusableView<T: ReusableView>(for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    
    public func register(_ cell: AnyClass) {
        self.register(cell, forCellWithReuseIdentifier: String(describing: cell))
    }
}
