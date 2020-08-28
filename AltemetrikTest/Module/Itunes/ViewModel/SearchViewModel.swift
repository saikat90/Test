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
    func filterAndSort(completion: @escaping (() ->()))
    func trackAddedInCart(completion: @escaping ((_ total: Int) ->()))
    func isFilterApplied() -> Bool
    func resetFilter()
}

protocol SortFilterDataProtocol {
    var sortFilterData: SortFilterData? { get set }
}

class SearchViewModel: SearchViewModelProtocol, SortFilterDataProtocol {
    private var cellModels = [ArtistCellViewModel]()
    private var filteredModels = [ArtistCellViewModel]()
    private let network: NetworkManager?
    private var appliedFilterCompletion: (() -> ())?
    private var updateCartCompletion: ((_ total: Int) ->())?
    
    var sortFilterData: SortFilterData? {
        didSet {
            applyFilterAndSortLogic()
        }
    }
    
    private var totalNumber = 0 {
        didSet {
            updateCartCompletion?(totalNumber)
        }
    }
    
    
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
                .map(ArtistCellViewModel.init)
            self?.applyFilterAndSortLogic()
            onCompletion(nil)
        }
    }
    
    func numberOfRows() -> Int {
        return filteredModels.count
    }
    
    func modelAt(index: Int) -> ArtistCellViewModel {
        let cellModel = filteredModels[index]
        cellModel.delegate = self
        return cellModel
    }
    
    func isArtistEmpty() -> Bool {
        return filteredModels.isEmpty
    }
    
    func isFilterApplied() -> Bool {
        guard let filterData = sortFilterData else {
            return false
        }
        return filterData.filterGenre != nil || filterData.isCollectionPriceSelected
    }
    
    private func applyFilterAndSortLogic() {
        if let filterValue = sortFilterData?.filterGenre?.generKey() {
            filteredModels = cellModels.filter({ $0.genre == filterValue})
            filteredModels = applySortOn(models: filteredModels)
        } else {
            filteredModels = applySortOn(models: cellModels)
        }
        appliedFilterCompletion?()
    }
    
    private func applySortOn(models: [ArtistCellViewModel]) -> [ArtistCellViewModel] {
        var resultantModels = [ArtistCellViewModel]()
        if let isSortByReleasDate = sortFilterData?.isReleaseDateSelected, isSortByReleasDate {
            resultantModels = models.sorted(by: releaseDateSortCondition)
        }
        if let isSortByCollectionPrice = sortFilterData?.isCollectionPriceSelected, isSortByCollectionPrice {
            resultantModels = models.sorted(by: collectionPriceSortCondition)
        }
        return resultantModels
    }
    
    private func releaseDateSortCondition(artist: ArtistCellViewModel, nextArtist: ArtistCellViewModel) -> Bool {
        guard let releaseDate = artist.releaseDate,
            let nextReleaseDate = nextArtist.releaseDate else {
                return false
        }
        return releaseDate < nextReleaseDate
    }
    
    private func collectionPriceSortCondition(artist: ArtistCellViewModel, nextArtist: ArtistCellViewModel) -> Bool {
        guard let collectionPrice = artist.trackPrice,
            let nextCollectionPrice = nextArtist.trackPrice else {
                return false
        }
        return collectionPrice < nextCollectionPrice
    }
    
    func filterAndSort(completion: @escaping (() -> ())) {
        self.appliedFilterCompletion = completion
    }
    
    func trackAddedInCart(completion: @escaping ((_ total: Int) ->())) {
        updateCartCompletion = completion
    }
    
    func resetFilter() {
        sortFilterData = SortFilterData()
    }
    
    func showCartDetailModel() -> ShowCartViewModelProtocol {
        let models = cellModels.filter({$0.numberOfTracks > 0})
        return ShowCartViewModel(cellModels: models)
    }
}

extension SearchViewModel: ArtistCellViewModelDelegate {
    
    func didUpdateNumberOfTracks() {
        totalNumber = cellModels.reduce(0, {$0 + $1.numberOfTracks})
    }
    
}
