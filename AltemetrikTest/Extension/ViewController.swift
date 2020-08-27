//
//  ViewController.swift
//  AltemetrikTest
//
//  Created by Guchhait, Saikat on 27/08/20.
//  Copyright © 2020 Guchhait, Saikat. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(title: String,with message: String, actions: [UIAlertAction] = []) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        if !actions.isEmpty {
            actions.forEach({alert.addAction($0)})
        } else {
            let okAlertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAlertAction)
        }
        present(alert, animated: true, completion: nil)
    }
    
    static func instantiateController<T: UIViewController>() -> T {
        let storyBoard = UIStoryboard(name: String(describing: self), bundle: Bundle.main)
        return storyBoard.instantiateViewController(identifier: String(describing: self))
    }
}


