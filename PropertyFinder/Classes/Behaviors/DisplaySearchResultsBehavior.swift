//
//  DisplaySearchResultsBehavior.swift
//  PropertyFinder
//
//  Created by Apokrupto on 24/10/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import OBehave
import APDownloader

protocol DisplaySearchResultsBehaviorDelegate: OBBehaviorDelegate {
    func performSearch(for behavior: DisplaySearchResultsBehavior)
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
            tableView.setSelfSizing(estimatedHeight: 200)
            
            if let _ = searchView {
                adjustTableViewDisplay()
            }
        }
    }
    
    private var properties: [Property] = []
}

extension DisplaySearchResultsBehavior: PerformSearchBehaviorDelegate {
    var onDownload: (DownloadResult<SearchResponse>) -> Void {
        return { [unowned self] (result: DownloadResult<SearchResponse>) in
            switch result {
            case .success(let response):
                self.properties.append(contentsOf: response.properties)
                
                DispatchQueue.main.async { [unowned self] in
                    self.insert(response.properties.count, indicesStartingAt: self.properties.count - response.properties.count)
                }
                
            case .failure(_):
                fatalError("Totally failed to get this to work")
            }
        }
    }
    
    func resetSearch(for behavior: PerformSearchBehavior) {
        properties.removeAll()
        tableView.reloadData()
    }
}

private extension DisplaySearchResultsBehavior {
    func adjustTableViewDisplay() {
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: searchView.bounds.size.height, right: 0)
    }
    
    func insert(_ count: Int, indicesStartingAt index: Int) {
        guard index != 0 else {
            tableView.reloadData()
            return
        }
        
        print("Inserting \(count) rows, starting at index \(index)")

        let indices = (index ..< index + count).map {
            IndexPath(row: $0, section: 0)
        }
        
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: indices, with: .automatic)
        self.tableView.setContentOffset(self.tableView.contentOffset, animated: false)
        self.tableView.endUpdates()
    }
}

extension DisplaySearchResultsBehavior: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard !properties.isEmpty else {
            return 0
        }
        
        return properties.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case (0 ..< properties.count):
            let cell: PropertyTableViewCell = tableView.cellForReusableView()
            cell.setProperty(properties[indexPath.row])
            
            return cell

        case properties.count:
            let cell: SearchingTableViewCell = tableView.cellForReusableView()
            cell.animating = true
            return cell
            
        default:
            fatalError("Internal consistency error, property lookup OOB")
        }
    }
}

extension DisplaySearchResultsBehavior: UITableViewDelegate {
    /// Infinite scrolling is provided by getting the next page once we get close to the bottom of the table
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if properties.count - indexPath.row == .triggerSearchThreshold {
            let delegate: DisplaySearchResultsBehaviorDelegate? = getDelegate()
            delegate?.performSearch(for: self)
        }
    }
}

private extension Int {
    static let triggerSearchThreshold = 5
}
