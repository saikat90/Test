//
//  NetworkRequestPath.swift
//  AltemetrikTest
//
//  Created by Guchhait, Saikat on 23/08/20.
//  Copyright © 2020 Guchhait, Saikat. All rights reserved.
//

import Foundation

protocol NetworkRequestProtocol {
    func networkComponent() -> URLComponents
}

enum NetworkRequestPath: NetworkRequestProtocol {
    
    case itunes(value: String?)
    
    private struct ItunesAPI {
        let scheme = "https"
        let host = "itunes.apple.com"
        let basePath = "/search"
        
        func itunesURLComponent(path: NetworkRequestPath) -> URLComponents {
            var components = URLComponents()
            components.host = host
            components.scheme = scheme
            components.path = basePath
            components.queryItems = path.queryItems()
            return components
        }
    }
    
    private func queryItems() -> [URLQueryItem] {
        switch self {
        case .itunes(let value):
            return [URLQueryItem(name: "term", value: value ?? "all")]
        }
    }
    
    func networkComponent() -> URLComponents {
        return ItunesAPI().itunesURLComponent(path: self)
    }
}
