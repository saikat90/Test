//
//  ShowCartCordinator.swift
//  AltemetrikTest
//
//  Created by Guchhait, Saikat on 28/08/20.
//  Copyright © 2020 Guchhait, Saikat. All rights reserved.
//

import Foundation
import UIKit

class ShowCartCordinator: Coordinator {
    
    var displayContext: UINavigationController
    let viewModel: ShowCartViewModelProtocol
    
    init(context: UINavigationController, viewModel: ShowCartViewModelProtocol) {
        self.displayContext = context
        self.viewModel = viewModel
    }
    
    func start() {
        let showCartViewController: ShowCartViewController = ShowCartViewController.instantiateController()
        showCartViewController.setUpWith(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: showCartViewController)
        displayContext.present(navigationController,
                               animated: true,
                               completion: nil)
    }
    
    
}
