//
//  EmptyStateBehaviorDataSource.swift
//  PropertyFinder
//
//  Created by Apokrupto on 26/10/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import OBehave

class EmptyStateBehaviorDataSource: OBBehavior, OBEmptyStateBehaviorDataSource {
    @IBOutlet var emptyStateView: UIView!

    func viewToDisplayOnEmpty(for behavior: OBEmptyStateBehavior?) -> UIView? {
        return emptyStateView
    }
}
