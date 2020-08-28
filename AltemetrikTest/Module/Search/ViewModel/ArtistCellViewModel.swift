//
//  ArtistCellViewModel.swift
//  AltemetrikTest
//
//  Created by Guchhait, Saikat on 27/08/20.
//  Copyright © 2020 Guchhait, Saikat. All rights reserved.
//

import Foundation

protocol ArtistCellViewModelDelegate: class {
    func didUpdateNumberOfTracks()
}

class ArtistCellViewModel: ViewModel {
    
    let artistName: String?
    var artistTrack: String?
    let releaseDate: Date?
    let collectionName: String?
    var trackPrice: Double?
    let genre: String?
    weak var delegate: ArtistCellViewModelDelegate?
    
    var numberOfTracks: Int = 0 {
        didSet {
            delegate?.didUpdateNumberOfTracks()
        }
    }
    
    init(artist: Artist) {
        self.artistName = artist.artistName
        self.artistTrack = artist.trackName
        self.collectionName = artist.collectionName
        self.trackPrice = artist.trackPrice
        self.releaseDate = artist.releaseDate
        self.genre = artist.primaryGenreName
    }
    
    func isAddToCartButtonEnabled() -> Bool {
        return numberOfTracks == 0
    }
}
