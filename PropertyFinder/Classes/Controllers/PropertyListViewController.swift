//
//  PropertyListViewController.swift
//  PropertyFinder
//
//  Created by Apokrupto on 24/10/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import UIKit
import OBehave

class PropertyListViewController: UIViewController, DisplaySearchResultsBehaviorDataSource {
    @IBOutlet var emptyStateView: UIView!
    
    private var sort = SortParameters(criterion: .bedrooms, direction: .descending)
    private var page = 0
    
    // MARK: DisplaySearchResultsBehaviorDataSource
    var downloadURL = URL.baseURL
    var downloader: Downloader = NetworkDownloader()
    var searchParameters: Parameters {
        return [.page:  "\(page)", .order: sort.encoding]
    }
}

// MARK: - OBEmptyStateBehaviorDataSource
extension PropertyListViewController: OBEmptyStateBehaviorDataSource {
    func viewToDisplayOnEmpty(for behavior: OBEmptyStateBehavior?) -> UIView? {
        return emptyStateView
    }
}

private extension String {
    static let page  = "page"
    static let order = "order"
}
