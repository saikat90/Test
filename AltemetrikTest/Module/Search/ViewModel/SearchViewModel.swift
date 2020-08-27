//
//  SearchViewModel.swift
//  AltemetrikTest
//
//  Created by Guchhait, Saikat on 23/08/20.
//  Copyright © 2020 Guchhait, Saikat. All rights reserved.
//

import Foundation

protocol ViewModel: class {}

protocol SearchViewModelProtocol: ViewModel {
    init(session: NetworkManagerProtocol)
    func fetchRequest(onCompletion: @escaping ((_ error: String?) ->()))
    func numberOfRows() -> Int
    func modelAt(index: Int) -> ArtistCellViewModel
    func isArtistEmpty() -> Bool
}

protocol SortFilterDataProtocol {
    var sortFilterData: SortFilterData? { get set }
}

class SearchViewModel: SearchViewModelProtocol, SortFilterDataProtocol {
    var sortFilterData: SortFilterData?
    private var cellModels = [ArtistCellViewModel]()
    private let network: NetworkManager?
    
    required init(session: NetworkManagerProtocol) {
        self.network = NetworkManager(session: session)
        self.sortFilterData = SortFilterData()
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
    
    func isArtistEmpty() -> Bool {
        return cellModels.isEmpty
    }
    
}
