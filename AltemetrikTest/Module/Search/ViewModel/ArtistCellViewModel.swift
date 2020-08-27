//
//  ArtistCellViewModel.swift
//  AltemetrikTest
//
//  Created by Guchhait, Saikat on 27/08/20.
//  Copyright © 2020 Guchhait, Saikat. All rights reserved.
//

import Foundation

class ArtistCellViewModel: ViewModel {
    
    let artistName: String?
    let artistTrack: String?
    let releaseDate: Date?
    let collectionName: String?
    let collectionPrice: Double?
    let genre: String?
    var numberOfTracks: Int = 0
    
    init(artist: Artist) {
        self.artistName = artist.artistName
        self.artistTrack = artist.trackName
        self.collectionName = artist.collectionName
        self.collectionPrice = artist.collectionPrice
        self.releaseDate = artist.releaseDate
        self.genre = artist.primaryGenreName
    }
}
