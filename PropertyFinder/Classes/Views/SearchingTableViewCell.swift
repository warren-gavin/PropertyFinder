//
//  SearchingTableViewCell.swift
//  PropertyFinder
//
//  Created by Apokrupto on 29/10/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import UIKit

class SearchingTableViewCell: UITableViewCell {
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    var animating: Bool = true {
        didSet {
            animating ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        }
    }
}
