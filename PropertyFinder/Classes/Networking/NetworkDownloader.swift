//
//  NetworkDownloader.swift
//  PropertyFinder
//
//  Created by Apokrupto on 24/10/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Foundation

public struct NetworkDownloader: Downloader {
    public init() {
    }
    
    public func download(url: URL, config: HTTP.Config, completion: @escaping (DownloadResult<JSONFormat>) -> Void) {
        let urlRequest = request(for: url, config: config)
        
        DispatchQueue.global(qos: .background).async {
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                guard let response = response as? HTTPURLResponse else {
                    completion(.failure(.unknown))
                    return
                }
                
                switch response.statusCode {
                case 200 ... 299:
                    guard let data = data, let json: JSONFormat = data.json else {
                        completion(.failure(.invalidContent))
                        return
                    }
                    
                    completion(.success(json))
                    
                case 400 ... 599:
                    completion(.failure(.httpError(response.statusCode)))
                    
                default:
                    completion(.failure(.unknown))
                }
            }.resume()
        }
    }
}

private extension NetworkDownloader {
    func request(for url: URL, config: HTTP.Config) -> URLRequest {
        var request: URLRequest = {
            guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
                return URLRequest(url: url)
            }
            
            components.queryItems = config.parameters?.map { key, value in
                URLQueryItem(name: key, value: value)
            }

            return URLRequest(url: components.url ?? url)
        }()
        
        request.httpMethod = config.method.text
        request.allHTTPHeaderFields = config.headers

        return request
    }
}
