//
//  DisplaySearchResultsBehavior.swift
//  PropertyFinder
//
//  Created by Apokrupto on 24/10/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import OBehave

protocol DisplaySearchResultsBehaviorDataSource: OBBehaviorDataSource {
    var downloadURL: URL { get }
    var searchParameters: Parameters { get }
    var downloader: Downloader { get }
}

class DisplaySearchResultsBehavior: OBBehavior {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
        }
    }
    
    private var properties: [Property] = [] {
        didSet {
            DispatchQueue.main.async { [unowned self] in
                self.tableView.reloadData()
            }
        }
    }
    
    override func setup() {
        super.setup()
        searchForProperties()
    }
}

private extension DisplaySearchResultsBehavior {
    func searchForProperties() {
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
                
            case .failure(_):
                fatalError("Totally failed to get this to work")
            }
        }
    }
}

extension DisplaySearchResultsBehavior: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return properties.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        
        let property = properties[indexPath.row]
        cell.textLabel?.text = property.location
        
        return cell
    }
}
