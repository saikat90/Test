//
//  SearchCoordinator.swift
//  AltemetrikTest
//
//  Created by Guchhait, Saikat on 23/08/20.
//  Copyright © 2020 Guchhait, Saikat. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator: class {
    var displayContext: UINavigationController { get }
    func start()
}

protocol SearchCoordinatorDelegate: class {
    func launchFilter()
}

class SearchCoordinator: Coordinator {
    var displayContext: UINavigationController
    let model = SearchViewModel()
    var filterCoordinator: FilterCoordinator?
    
    init(context: UINavigationController) {
        self.displayContext = context
    }
    
    func start() {
        let searchController: SearchViewController = SearchViewController.instantiateController()
        searchController.delegate = self
        searchController.setUpWith(model: model)
        displayContext.pushViewController(searchController, animated: true)
    }

}

extension SearchCoordinator: SearchCoordinatorDelegate {
    
    func launchFilter() {
        filterCoordinator = FilterCoordinator(context: displayContext)
        filterCoordinator?.sortFilterData = model
        filterCoordinator?.delegate = self
        filterCoordinator?.start()
    }
    
}

extension SearchCoordinator: FilterCoordinatorDelegate {
    
    func appliedFilter(data: SortFilterDataProtocol) {
        model.sortFilterData = data.sortFilterData
    }
    
}
