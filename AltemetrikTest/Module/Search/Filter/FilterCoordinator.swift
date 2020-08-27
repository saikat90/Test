//
//  FilterCoordinator.swift
//  AltemetrikTest
//
//  Created by Guchhait, Saikat on 27/08/20.
//  Copyright © 2020 Guchhait, Saikat. All rights reserved.
//

import Foundation
import UIKit

protocol FilterCoordinatorDelegate: class {
    func appliedFilter(data: SortFilterDataProtocol)
}

class FilterCoordinator: Coordinator {
    var displayContext: UINavigationController
    var sortFilterData: SortFilterDataProtocol?
    weak var delegate: FilterCoordinatorDelegate?
    
    init(context: UINavigationController) {
        self.displayContext = context
    }
    
    func start() {
        let filterViewController: FilterViewController = FilterViewController.instantiateController()
        let viewModel = FilterViewModel(filterData: sortFilterData)
        filterViewController.setUpWith(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: filterViewController)
        displayContext.present(navigationController,
                               animated: true,
                               completion: nil)
        filterViewController.applyFilterCompletion = { [weak self] in
            self?.delegate?.appliedFilter(data: viewModel)
        }
    }
    
    func stop() {
        displayContext.dismiss(animated: true, completion: nil)
    }
    
}
