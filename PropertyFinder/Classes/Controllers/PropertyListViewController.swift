//
//  PropertyListViewController.swift
//  PropertyFinder
//
//  Created by Apokrupto on 24/10/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import UIKit

class PropertyListViewController: UIViewController {
    var serviceUrl = URL(string: "https://www.propertyfinder.ae/mobileapi?page=0&order=pa")!
    var downloader = NetworkDownloader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchForProperties()
    }
}

private extension PropertyListViewController {
    func searchForProperties() {
        let config = HTTP.Config(method: .get)
        HTTP.download(url: serviceUrl, config: config, downloader: downloader) { (result: DownloadResult<SearchResponse>) in
            switch result {
            case .success(let response):
                response.properties.forEach {
                    print($0.subject)
                }
                
            case .failure(_):
                fatalError("Totally failed to get this to work")
            }
        }
    }
}
