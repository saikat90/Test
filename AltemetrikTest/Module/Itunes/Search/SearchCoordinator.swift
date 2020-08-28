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
    func showCart()
    func showDetailControllerWith(model: DetailViewModelProtocol)
}

class SearchCoordinator: Coordinator {
    var displayContext: UINavigationController
    let model = SearchViewModel()
    var coordinator: Coordinator?
    
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
        let filterCoordinator = FilterCoordinator(context: displayContext)
        filterCoordinator.sortFilterData = model
        filterCoordinator.delegate = self
        filterCoordinator.start()
        coordinator = filterCoordinator
    }
    
    func showCart() {
        let showCartCoordinator = ShowCartCordinator(context: displayContext, viewModel: model.showCartDetailModel())
        showCartCoordinator.start()
        coordinator = showCartCoordinator
    }
    
    func showDetailControllerWith(model: DetailViewModelProtocol) {
        let showDetailCoordinator = ShowDetailCoordinator(displayContext: displayContext,
                                                          model: model)
        showDetailCoordinator.start()
        coordinator = showDetailCoordinator
    }
}

extension SearchCoordinator: FilterCoordinatorDelegate {
    
    func appliedFilter(data: SortFilterDataProtocol) {
        model.sortFilterData = data.sortFilterData
    }
    
}
