//
//  DetailViewModel.swift
//  AltemetrikTest
//
//  Created by Guchhait, Saikat on 28/08/20.
//  Copyright © 2020 Guchhait, Saikat. All rights reserved.
//

import Foundation

protocol DetailViewModelProtocol: ViewModel {
    var artistName: String? { get }
    var artistTrack: String? { get }
    var collectionName: String? { get }
    var trackPrice: Double? { get }
    var collectionPrice: Double? { get }
    var imageUrl: String? { get }
    var country: String? { get }
    var primaryGenre: String? { get }
    var formattedDate: String? { get }
}

extension ArtistCellViewModel: DetailViewModelProtocol {
    
    var formattedDate: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        guard let date = releaseDate else {
            return nil
        }
        return dateFormatter.string(from: date)
    }
}
