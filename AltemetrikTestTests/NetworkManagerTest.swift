//
//  NetworkManagerTest.swift
//  AltemetrikTestTests
//
//  Created by Guchhait, Saikat on 23/08/20.
//  Copyright © 2020 Guchhait, Saikat. All rights reserved.
//

import XCTest
@testable import AltemetrikTest

private let JSONExtension = "json"

class MockNetworkManager: NetworkManagerProtocol {
    
    func fetchItunes(request: URLRequest, completionHandler: ((NetworkResponseProtocol) -> Void)?) {
        var response: NetworkResponse!
        let requestString = request.url?.absoluteString ?? ""
        switch requestString {
        case _ where requestString.contains("all"):
            let url = Bundle(for: type(of: self)).url(forResource: "response", withExtension: JSONExtension)
            if let jsonURL = url  {
                let data = try? Data(contentsOf: jsonURL)
                response = NetworkResponse(data: data, response: nil, error: nil)
            } else {
                response =  NetworkResponse(data: nil,
                                            response: nil,
                                            error: NetworkError.network(description: "No Data Found"))
            }
        default:
            response = NetworkResponse(data: nil,
                                       response: nil,
                                       error: NetworkError.network(description: "No Data Found"))
        }
        completionHandler?(response)
    }
    
}

class NetworkManagerTest: XCTestCase {
    
    var networkManger: NetworkManager!
    
    override func setUp() {
        let mockNetworkManger = MockNetworkManager()
        networkManger = NetworkManager(session: mockNetworkManger)
    }
    
    override func tearDown() {
    }
    
    func test_fetchCountryDataUsingRequestComponent() {
        let urlComponent = NetworkRequestPath.itunes(value: "all").networkComponent()
        networkManger.fetchItunesDataUsing(urlComponent) { response in
            let reponse: SearchResponseModel? = response.parseData()
            XCTAssertNotNil(reponse)
        }
    }
    
}
