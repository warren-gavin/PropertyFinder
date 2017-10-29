//
//  SearchBehaviorDataSource.swift
//  PropertyFinder
//
//  Created by Apokrupto on 25/10/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import OBehave
import APDownloader

class SearchBehaviorDataSource: OBBehavior, DisplaySearchResultsBehaviorDataSource {
    @IBOutlet var directionSegment: UISegmentedControl? {
        didSet {
            initialize(segmentControl: directionSegment, with: sortDirection, startingIndex: directionIndex)
        }
    }
    
    @IBOutlet var sortCriteriaSegment: UISegmentedControl? {
        didSet {
            initialize(segmentControl: sortCriteriaSegment, with: sortCriteria, startingIndex: sortIndex)
        }
    }
    
    private let sortCriteria: [SortCriterion]  = SortCriterion.allCases
    private let sortDirection: [SortDirection] = SortDirection.allCases
    
    private var sortIndex = 0
    private var directionIndex = 0
    private var page = 0
    
    // MARK: DisplaySearchResultsBehaviorDataSource
    var downloadURL = URL.baseURL
    var downloader: Downloader = NetworkDownloader()
    var searchParameters: Parameters {
        defer {
            page += 1
        }
        
        let sort = SortParameters(criterion: sortCriteria[sortIndex], direction: sortDirection[directionIndex])
        return [.page:  "\(page)", .order: sort.encoding]
    }
}

private extension SearchBehaviorDataSource {
    func initialize(segmentControl: UISegmentedControl?, with titles: [CustomTextConvertible], startingIndex: Int) {
        zip(titles, (0 ..< titles.count)).forEach {
            segmentControl?.setTitle($0.text, forSegmentAt: $1)
        }
        
        segmentControl?.selectedSegmentIndex = startingIndex
    }
}

extension SearchBehaviorDataSource: DisplaySearchResultsBehaviorDelegate {
    func resetSearch(for behavior: DisplaySearchResultsBehavior) {
        sortIndex = sortCriteriaSegment?.selectedSegmentIndex ?? 0
        directionIndex = directionSegment?.selectedSegmentIndex ?? 0
        page = 0
    }
}

private extension String {
    static let page  = "page"
    static let order = "order"
}
