//
//  DisplaySearchResultsBehavior.swift
//  PropertyFinder
//
//  Created by Apokrupto on 24/10/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import OBehave
import APDownloader

protocol DisplaySearchResultsBehaviorDataSource: OBBehaviorDataSource {
    var downloadURL: URL { get }
    var searchParameters: Parameters { get }
    var downloader: Downloader { get }
}

protocol DisplaySearchResultsBehaviorDelegate: OBBehaviorDelegate {
    func resetSearch(for behavior: DisplaySearchResultsBehavior)
}

class DisplaySearchResultsBehavior: OBBehavior {
    @IBOutlet var searchView: UIView! {
        didSet {
            if let _ = tableView {
                adjustTableViewDisplay()
            }
        }
    }
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate   = self
            
            if let _ = searchView {
                adjustTableViewDisplay()
            }
        }
    }
    
    @IBAction func performSearch(_: UIButton) {
        let delegate: DisplaySearchResultsBehaviorDelegate? = getDelegate()
        delegate?.resetSearch(for: self)
        
        properties.removeAll()
        tableView.reloadData()
        
        searchForProperties(searchAgain: true)
    }
    
    private var properties: [Property] = []
    
    override func setup() {
        super.setup()
        searchForProperties(searchAgain: true)
    }
}

private extension DisplaySearchResultsBehavior {
    func searchForProperties(searchAgain: Bool) {
        guard let delegate: DisplaySearchResultsBehaviorDataSource = getDataSource() else {
            return
        }

        let config = HTTP.Config(method: .get, headers: nil, parameters: delegate.searchParameters)

        HTTP.download(url: delegate.downloadURL,
                      config: config,
                      downloader: delegate.downloader) { [unowned self] (result: DownloadResult<SearchResponse>) in
            switch result {
            case .success(let response):
                self.properties.append(contentsOf: response.properties)
                
                if searchAgain {
                    self.searchForProperties(searchAgain: false)
                }

                DispatchQueue.main.async { [unowned self] in
                    self.tableView.reloadData()
                }

            case .failure(_):
                fatalError("Totally failed to get this to work")
            }
        }
    }
    
    func adjustTableViewDisplay() {
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: searchView.bounds.size.height, right: 0)
    }
}

extension DisplaySearchResultsBehavior: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return properties.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard (0 ..< properties.count) ~= indexPath.row else {
            fatalError("Internal consistency error, property lookup OOB")
        }
        
        let cell: PropertyTableViewCell = tableView.cellForReusableView()
        cell.setProperty(properties[indexPath.row])
        
        return cell
    }
}

extension DisplaySearchResultsBehavior: UITableViewDelegate {
    /// Infinite scrolling is provided by getting the next page once we get close to the bottom of the table
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if properties.count - indexPath.row < 5 {
            searchForProperties(searchAgain: false)
        }
    }
}
