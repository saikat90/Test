//
//  ShowCartViewModel.swift
//  AltemetrikTest
//
//  Created by Guchhait, Saikat on 28/08/20.
//  Copyright © 2020 Guchhait, Saikat. All rights reserved.
//

import Foundation

protocol ShowCartViewModelProtocol: ViewModel {
    init(cellModels: [ShowCartCellViewModelProtocol])
    func numberOfRows() -> Int
    func modelAt(index: Int) -> ShowCartCellViewModelProtocol
    func totalCostOfTrack() -> Double
}

protocol ShowCartCellViewModelProtocol: ViewModel {
    var artistTrack: String? { get }
    var trackPrice: Double? { get }
    var numberOfTracks: Int { get }
}

extension ArtistCellViewModel: ShowCartCellViewModelProtocol { }

class ShowCartViewModel: ShowCartViewModelProtocol {
    
    private let cellModels: [ShowCartCellViewModelProtocol]
    
    required init(cellModels: [ShowCartCellViewModelProtocol]) {
        self.cellModels = cellModels
    }
    
    func numberOfRows() -> Int {
        return cellModels.count
    }
    
    func modelAt(index: Int) -> ShowCartCellViewModelProtocol {
        return cellModels[index]
    }
      
    func totalCostOfTrack() -> Double {
        return cellModels.reduce(0.0, {$0 + (Double($1.trackPrice ?? 0.0) * Double($1.numberOfTracks))})
    }
}
