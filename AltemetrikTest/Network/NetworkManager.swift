//
//  NetworkManager.swift
//  AltemetrikTest
//
//  Created by Guchhait, Saikat on 23/08/20.
//  Copyright © 2020 Guchhait, Saikat. All rights reserved.
//

import Foundation

struct NetworkManager {
    let session: NetworkManagerProtocol
    
    init(session: NetworkManagerProtocol = SessionManager()) {
        self.session = session
    }
    
    func fetchItunesDataUsing(_ requestComponent: URLComponents, onCompletion: ((NetworkResponseProtocol) -> Void)?) {
        guard let requestURL = requestComponent.url else {
            onCompletion?(NetworkResponse(error: .badRequest))
            return
        }
        session.fetchItunes(request: URLRequest(url: requestURL),
                            completionHandler: onCompletion)
    }
}
