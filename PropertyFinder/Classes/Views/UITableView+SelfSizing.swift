//
//  UITableView+SelfSizing.swift
//  PropertyFinder
//
//  Created by Apokrupto on 29/10/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import UIKit

extension UITableView {
    func setSelfSizing(estimatedHeight height: CGFloat) {
        rowHeight = UITableViewAutomaticDimension
        estimatedRowHeight = height
    }
}
