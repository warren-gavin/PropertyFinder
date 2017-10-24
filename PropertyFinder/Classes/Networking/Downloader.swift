//
//  Downloader.swift
//  PropertyFinder
//
//  Created by Apokrupto on 24/10/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Foundation

public protocol Downloader {
    func download(url: URL, config: HTTP.Config, completion: @escaping (DownloadResult<JSONFormat>) -> Void)
}

public enum DownloadError: Error {
    case unknown
    case invalidContent
    case httpError(Int)
}

public enum DownloadResult<T> {
    case success(T)
    case failure(DownloadError)
}
