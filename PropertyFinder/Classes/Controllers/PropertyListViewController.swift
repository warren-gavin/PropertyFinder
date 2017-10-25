//
//  PropertyListViewController.swift
//  PropertyFinder
//
//  Created by Apokrupto on 24/10/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import UIKit
import OBehave
import APDownloader

class PropertyListViewController: UIViewController {
    @IBOutlet var emptyStateView: UIView!
}

// MARK: - OBEmptyStateBehaviorDataSource
extension PropertyListViewController: OBEmptyStateBehaviorDataSource {
    func viewToDisplayOnEmpty(for behavior: OBEmptyStateBehavior?) -> UIView? {
        return emptyStateView
    }
}
