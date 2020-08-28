//
//  String.swift
//  AltemetrikTest
//
//  Created by Guchhait, Saikat on 28/08/20.
//  Copyright © 2020 Guchhait, Saikat. All rights reserved.
//

import Foundation

extension Optional where Wrapped == String {
    
    public func ifEmptyOrNil(defaultTo replacementValue: @autoclosure () -> String) -> String {
        if let value = self, !value.isEmpty {
            return value as String
        } else {
            return replacementValue()
        }
    }
}
