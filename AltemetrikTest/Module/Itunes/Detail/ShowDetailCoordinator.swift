//
//  ShowDetailCoordinator.swift
//  AltemetrikTest
//
//  Created by Guchhait, Saikat on 28/08/20.
//  Copyright © 2020 Guchhait, Saikat. All rights reserved.
//

import Foundation
import UIKit

class ShowDetailCoordinator: Coordinator {
    
    var displayContext: UINavigationController
    let model: DetailViewModelProtocol
    
    init(displayContext: UINavigationController, model: DetailViewModelProtocol) {
        self.displayContext = displayContext
        self.model = model
    }
    
    func start() {
        let detailController: ShowDetailViewController = ShowDetailViewController.instantiateController()
        detailController.setUpWith(viewModel: model)
        displayContext.pushViewController(detailController, animated: true)
    }
    
}
