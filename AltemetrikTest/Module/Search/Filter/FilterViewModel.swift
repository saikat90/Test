//
//  FilterViewModel.swift
//  AltemetrikTest
//
//  Created by Guchhait, Saikat on 27/08/20.
//  Copyright © 2020 Guchhait, Saikat. All rights reserved.
//

import Foundation

protocol FilterViewModelProtocol: ViewModel {
    init(filterData: SortFilterDataProtocol?)
    func setFilterOn(genre: PrimaryGenreName)
    func sortByCollectionPrice(selected: Bool)
    func sortByReleaseDate(selected: Bool)
    func enableFilterButtonWithTag() -> Int
    func enableSortByReleaseDate() -> Bool
    func enableSortByCollectionPrice() -> Bool
}

struct SortFilterData {
    var filterGenre: PrimaryGenreName?
    var isReleaseDateSelected: Bool = false
    var isCollectionPriceSelected: Bool = true
}

enum PrimaryGenreName: Int, CaseIterable {
    case holiday = 10
    case pop
    case rock
    case alternative
}

class FilterViewModel: FilterViewModelProtocol, SortFilterDataProtocol {
    
    var sortFilterData: SortFilterData?
    
    required init(filterData: SortFilterDataProtocol?) {
        self.sortFilterData = filterData?.sortFilterData
    }
    
    func setFilterOn(genre: PrimaryGenreName) {
        sortFilterData?.filterGenre = genre
    }
    
    func sortByCollectionPrice(selected: Bool) {
        sortFilterData?.isCollectionPriceSelected = selected
    }
    
    func sortByReleaseDate(selected: Bool) {
        sortFilterData?.isReleaseDateSelected = selected
    }
    
    func enableFilterButtonWithTag() -> Int {
        return sortFilterData?.filterGenre?.rawValue ?? 0
    }
    
    func enableSortByReleaseDate() -> Bool {
        return sortFilterData?.isReleaseDateSelected ?? false
    }
    
    func enableSortByCollectionPrice() -> Bool {
        return sortFilterData?.isCollectionPriceSelected ?? false
    }
}
