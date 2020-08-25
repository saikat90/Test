//
//  SearchViewModel.swift
//  AltemetrikTest
//
//  Created by Guchhait, Saikat on 23/08/20.
//  Copyright © 2020 Guchhait, Saikat. All rights reserved.
//

import Foundation

protocol ViewModel {}

protocol SearchViewModelProtocol {
    init(session: NetworkManagerProtocol)
}

class SearchViewModel: SearchViewModelProtocol {
    
    private var cellModels = [ArtistCellViewModel]()
    private let network: NetworkManager?
    
    required init(session: NetworkManagerProtocol) {
        self.network = NetworkManager(session: session)
    }
    
    convenience init() {
        self.init(session: SessionManager())
    }
    
    func fetchRequest(onCompletion: @escaping ((_ error: String?) ->())) {
        let requestComponent = NetworkRequestPath.itunes(value: "all").networkComponent()
        network?.fetchItunesDataUsing(requestComponent) {[weak self] response in
            guard let responseModel: SearchResponseModel? = response.parseData() else {
                onCompletion(response.parseError())
                return
            }
            self?.cellModels = Set(responseModel?.results ?? [])
                .map(ArtistCellViewModel.init).sorted(by: { (artist, nextArtist) -> Bool in
                    guard let releaseDate = artist.releaseDate,
                        let nextReleaseDate = nextArtist.releaseDate else {
                        return false
                    }
                    return releaseDate < nextReleaseDate
                })
            onCompletion(nil)
        }
    }
 
    func numberOfRows() -> Int {
        return cellModels.count 
    }
    
    func modelAt(index: Int) -> ArtistCellViewModel {
        return cellModels[index]
    }
}

class ArtistCellViewModel: ViewModel {
    
    let artistName: String?
    let artistTrack: String?
    let releaseDate: Date?
    let collectionName: String?
    let collectionPrice: Double?
    
    init(artist: Artist) {
        self.artistName = artist.artistName
        self.artistTrack = artist.trackName
        self.collectionName = artist.collectionName
        self.collectionPrice = artist.collectionPrice
        self.releaseDate = artist.releaseDate
    }
}
