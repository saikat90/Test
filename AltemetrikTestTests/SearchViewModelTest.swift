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
        viewModel = SearchViewModel(session: MockNetworkManager())
        viewModel.fetchRequest { error in}
    }

    override func tearDown() {
    }

    func test_numberOfRows() {
        XCTAssertEqual(viewModel.numberOfRows(), 48)
    }
    
    func test_modelAtIndex() {
        let model = viewModel.modelAt(index: 0)
        XCTAssertEqual(model.artistName, "John Badham")
    }
}
