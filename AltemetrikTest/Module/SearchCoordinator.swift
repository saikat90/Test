//
//  SearchCoordinator.swift
//  AltemetrikTest
//
//  Created by Guchhait, Saikat on 23/08/20.
//  Copyright © 2020 Guchhait, Saikat. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator {
    var displayContext: UINavigationController { get }
    func start()
}

class SearchCoordinator: Coordinator {
    var displayContext: UINavigationController
    
    init(context: UINavigationController) {
        self.displayContext = context
    }
    
    func start() {
        let model = SearchViewModel()
        let searchController: SearchViewController = SearchViewController.instantiateConstroller()
        searchController.setUpWith(model: model)
        displayContext.pushViewController(searchController, animated: true)
    }
}
