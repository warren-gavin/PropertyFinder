//
//  SearchParameters.swift
//  PropertyFinder
//
//  Created by Apokrupto on 29/10/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import APDownloader

struct SearchParameters {
    let page: Int
    let sort: SortParameters
    
    var encoding: Parameters {
        return [.page:  "\(page)", .order: sort.encoding]
    }
}

// MARK: - Search parameter keys
private extension String {
    static let page  = "page"
    static let order = "order"
}
