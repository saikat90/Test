//
//  ShowCartViewModelTest.swift
//  AltemetrikTestTests
//
//  Created by Guchhait, Saikat on 28/08/20.
//  Copyright © 2020 Guchhait, Saikat. All rights reserved.
//

import XCTest
@testable import AltemetrikTest

class CartCellModelMock: ShowCartCellViewModelProtocol {
    var artistTrack: String?
    var trackPrice: Double?
    var numberOfTracks: Int
    
    init(artistTrack: String, trackPrice: Double, numberOfTracks: Int) {
        self.numberOfTracks = numberOfTracks
        self.artistTrack = artistTrack
        self.trackPrice = trackPrice
    }
    
}

class ShowCartViewModelTest: XCTestCase {

    var viewModel: ShowCartViewModelProtocol!
    
    override func setUp()  {
        super.setUp()
        viewModel = ShowCartViewModel(cellModels: mockData())
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func test_numberOfRows() {
        XCTAssertEqual(viewModel.numberOfRows(), 2)
    }
    
    func test_modelAtIndex() {
        let model = viewModel.modelAt(index: 0)
        XCTAssertEqual(model.artistTrack, "Track 1")
        XCTAssertEqual(model.numberOfTracks, 1)
    }
    
    func test_totalCostOfTrack() {
        let totalCost = viewModel.totalCostOfTrack()
        XCTAssertEqual(totalCost, 15.0)
    }
    
    func mockData() -> [ShowCartCellViewModelProtocol]  {
        return [CartCellModelMock(artistTrack: "Track 1", trackPrice: 12, numberOfTracks: 1),
                CartCellModelMock(artistTrack: "Track 2", trackPrice: 1, numberOfTracks: 3)]
    }

}
