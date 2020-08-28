//
//  SearchViewModelTest.swift
//  AltemetrikTestTests
//
//  Created by Guchhait, Saikat on 23/08/20.
//  Copyright © 2020 Guchhait, Saikat. All rights reserved.
//

import XCTest
@testable import AltemetrikTest

class SearchViewModelTest: XCTestCase {

  var viewModel: SearchViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = SearchViewModel(session: MockNetworkManager())
        viewModel.fetchRequest { error in}
    }

    override func tearDown() {
        super.tearDown()
    }

    func test_numberOfRows() {
        XCTAssertEqual(viewModel.numberOfRows(), 48)
    }
    
    func test_modelAtIndex() {
        let model = viewModel.modelAt(index: 0)
        XCTAssertEqual(model.artistName, "John Badham")
    }
    
    func test_isArtistEmpty() {
        XCTAssertFalse(viewModel.isArtistEmpty())
    }
    
    func test_trackAddedInCart() {
        let expectation = XCTestExpectation(description: "Track Added In Cart")
        expectation.expectedFulfillmentCount = 2
        var total = 0
        viewModel.trackAddedInCart { value in
            total = value
            expectation.fulfill()
        }
        let firstModel = viewModel.modelAt(index: 0)
        firstModel.numberOfTracks = 4
        
        let secondModel = viewModel.modelAt(index: 1)
        secondModel.numberOfTracks = 5
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(total, 9)
    }
    
    func test_resetFilter() {
        viewModel.resetFilter()
        XCTAssertEqual(viewModel.numberOfRows(), 48)
        let model = viewModel.modelAt(index: 0)
        XCTAssertEqual(model.artistName, "John Badham")
    }
    
    func test_filterAndSort() {
        viewModel.sortFilterData = SortFilterData(filterGenre: .holiday,
                                                  isReleaseDateSelected: false,
                                                  isCollectionPriceSelected: true)
        XCTAssertEqual(viewModel.numberOfRows(), 1)
        let model = viewModel.modelAt(index: 0)
        XCTAssertEqual(model.artistName, "Mariah Carey")
        XCTAssertEqual(model.trackPrice, 1.29)
    }
}
