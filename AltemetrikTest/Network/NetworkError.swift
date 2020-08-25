//
//  NetworkError.swift
//  AltemetrikTest
//
//  Created by Guchhait, Saikat on 23/08/20.
//  Copyright © 2020 Guchhait, Saikat. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case badRequest
    case network(description: String)
}
