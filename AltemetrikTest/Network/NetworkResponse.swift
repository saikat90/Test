//
//  NetworkResponse.swift
//  AltemetrikTest
//
//  Created by Guchhait, Saikat on 23/08/20.
//  Copyright © 2020 Guchhait, Saikat. All rights reserved.
//

import Foundation

protocol NetworkResponseProtocol {
    func parseData<T: Decodable>() -> T?
    func parseError() -> String
}

struct NetworkResponse: NetworkResponseProtocol {
    let data: Data?
    let response: URLResponse?
    let error: Error?
    
    func parseData<T: Decodable>() -> T? {
        guard let anyData = data else { return nil }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.serverFormat)
        var parsedData: T?
        do {
            parsedData = try decoder.decode(T.self, from: anyData)
        } catch let error {
            print(error.localizedDescription)
        }
        return parsedData
    }
    
    func parseError() -> String {
        guard let networkError = error as? NetworkError else {
            switch (response as? HTTPURLResponse)?.statusCode {
            case 404:
                return "No Data Found"
            default:
                return error?.localizedDescription ?? ""
            }
        }
        switch networkError {
        case .badRequest:
            return "Bad Request"
        case .network(let description):
        return "\(description)"
        }
    }
}

extension NetworkResponse {
    init(error: NetworkError, response: URLResponse? = nil) {
        self.error = error
        self.data = nil
        self.response = response
    }
}
