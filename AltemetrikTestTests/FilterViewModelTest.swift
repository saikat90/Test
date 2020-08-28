//
//  FilterViewModelTest.swift
//  AltemetrikTestTests
//
//  Created by Guchhait, Saikat on 28/08/20.
//  Copyright © 2020 Guchhait, Saikat. All rights reserved.
//

import XCTest
@testable import AltemetrikTest

class MockSortFilterData: SortFilterDataProtocol {
    var sortFilterData: SortFilterData?
    
    init() {
        self.sortFilterData = SortFilterData()
    }
}

class FilterViewModelTest: XCTestCase {

    var viewModel: FilterViewModelProtocol!
    
    override func setUp() {
        super.setUp()
        viewModel = FilterViewModel(filterData: MockSortFilterData())
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func test_setFilterOnGenre() {
        viewModel.setFilterOn(genre: .alternative)
        XCTAssertEqual(viewModel.enableFilterButtonWithTag(), 13)
    }
    
    func test_sortByCollectionPrice() {
        viewModel.sortByCollectionPrice(selected: true)
        XCTAssertTrue(viewModel.enableSortByCollectionPrice())
    }
    
    func test_sortByReleaseDate() {
        viewModel.sortByReleaseDate(selected: true)
        XCTAssertTrue(viewModel.enableSortByReleaseDate())
    }
}
