//
//  SessionManager.swift
//  AltemetrikTest
//
//  Created by Guchhait, Saikat on 23/08/20.
//  Copyright © 2020 Guchhait, Saikat. All rights reserved.
//

import Foundation

protocol NetworkManagerProtocol {
    func fetchItunes(request: URLRequest,
                     completionHandler: ((_ response: NetworkResponseProtocol) -> Void)?)
}

struct SessionManager {
    let urlSession: URLSession
    
    init(configuration: URLSessionConfiguration = URLSessionConfiguration.default) {
        urlSession = URLSession(configuration: configuration)
    }
}

extension SessionManager: NetworkManagerProtocol {
    
    func fetchItunes(request: URLRequest,
                     completionHandler: ((NetworkResponseProtocol) -> Void)?) {
        urlSession.dataTask(with: request) { (data, response, error) in
            let response = NetworkResponse(data: data, response: response, error: error)
            DispatchQueue.main.async {
                completionHandler?(response)
            }
        }.resume()
    }
}
