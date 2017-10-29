//
//  PerformSearchBehavior.swift
//  PropertyFinder
//
//  Created by Apokrupto on 29/10/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import OBehave
import APDownloader

protocol PerformSearchBehaviorDataSource: OBBehaviorDataSource {
    var downloadURL: URL { get }
    var searchParameters: Parameters { get }
    var downloader: Downloader { get }
    
    func resetSearchParameters(for behavior: PerformSearchBehavior)
}

protocol PerformSearchBehaviorDelegate: OBBehaviorDelegate {
    var onDownload: (DownloadResult<SearchResponse>) -> Void { get }

    func resetSearch(for behavior: PerformSearchBehavior)
}

class PerformSearchBehavior: OBBehavior {
    @IBAction func performSearch(_: UIButton) {
        let delegate: PerformSearchBehaviorDelegate? = getDelegate()
        delegate?.resetSearch(for: self)
        
        let dataSource: PerformSearchBehaviorDataSource? = getDataSource()
        dataSource?.resetSearchParameters(for: self)
        
        searchForProperties()
    }
    
    override func setup() {
        super.setup()
        searchForProperties()
    }
}

// MARK: - Private
private extension PerformSearchBehavior {
    func searchForProperties() {
        guard
            let dataSource: PerformSearchBehaviorDataSource = getDataSource(),
            let delegate: PerformSearchBehaviorDelegate = getDelegate()
        else {
            return
        }
        
        let config = HTTP.Config(method: .get, headers: nil, parameters: dataSource.searchParameters)
        
        HTTP.download(url: dataSource.downloadURL,
                      config: config,
                      downloader: dataSource.downloader,
                      completion: delegate.onDownload)
    }
}

// MARK: - DisplaySearchResultsBehaviorDelegate
extension PerformSearchBehavior: DisplaySearchResultsBehaviorDelegate {
    func performSearch(for behavior: DisplaySearchResultsBehavior) {
        searchForProperties()
    }
}
