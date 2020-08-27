//
//  SearchResponseModel.swift
//  AltemetrikTest
//
//  Created by Guchhait, Saikat on 23/08/20.
//  Copyright © 2020 Guchhait, Saikat. All rights reserved.
//

import Foundation

struct SearchResponseModel: Decodable {
    let resultCount: Int
    let results: [Artist]
}

struct Artist: Decodable, Hashable {
    let artistName: String?
    let trackName: String?
    let releaseDate: Date?
    let collectionName: String?
    let collectionPrice: Double?
    let primaryGenreName: String?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(trackName)
    }
    
    static func == (lhs: Artist, rhs: Artist) -> Bool {
        return lhs.trackName == rhs.trackName
    }
}


extension DateFormatter {
    static let serverFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()
}
