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
    var isReleaseDateSelected: Bool = true
    var isCollectionPriceSelected: Bool = false
}

enum PrimaryGenreName: Int, CaseIterable {
    case holiday = 10
    case pop
    case rock
    case alternative
    
    func generKey() -> String {
        switch self {
        case .holiday:
            return "Holiday"
        case .pop:
            return "Pop"
        case .rock:
            return "Rock"
        default:
            return "Alternative"
        }
    }
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
        if selected {
            sortFilterData?.isReleaseDateSelected = false
        }
    }
    
    func sortByReleaseDate(selected: Bool) {
        sortFilterData?.isReleaseDateSelected = selected
        if selected {
            sortFilterData?.isCollectionPriceSelected = false
        }
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
