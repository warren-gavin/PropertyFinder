//
//  HTTP.swift
//  PropertyFinder
//
//  Created by Apokrupto on 24/10/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Foundation

public typealias Parameters = [String: Any]
public typealias Headers    = [String: String]
public typealias Response   = [String: String]

internal enum ApplicationType {
    static let json = "application/json"
}

public class HTTP {
    internal enum Header {
        static let contentType = "Content-Type"
        static let accept = "Accept"
    }
    
    public enum Method: String {
        case post
        case put
        case get
        case delete
        
        var text: String {
            return rawValue.uppercased()
        }
    }
    
    public struct Config {
        public let method: Method
        public let headers: Headers?
        public let parameters: Parameters?
        
        public init(method: Method, headers: Headers? = nil, parameters: Parameters? = nil) {
            self.method     = method
            self.headers    = headers
            self.parameters = parameters
        }
    }
    
    public enum Encoding {
        case url
        case json
    }
    
    public static func download<T: JSONConstructible>(url: URL,
                                                      config: HTTP.Config,
                                                      downloader: Downloader,
                                                      completion: @escaping (DownloadResult<T>) -> Void) {
        NetworkIndicator.startNetworkActivity()

        downloader.download(url: url, config: config) { result in
            NetworkIndicator.stopNetworkActivity()
            
            switch result {
            case .success(let json):
                guard let type = T(json) else {
                    completion(.failure(.invalidContent))
                    return
                }
                
                completion(.success(type))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
