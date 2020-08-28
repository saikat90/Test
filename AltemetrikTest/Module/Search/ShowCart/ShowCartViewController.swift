//
//  ShowCartViewController.swift
//  AltemetrikTest
//
//  Created by Guchhait, Saikat on 28/08/20.
//  Copyright © 2020 Guchhait, Saikat. All rights reserved.
//

import UIKit

private let cartTitle = "Track Cart"

class ShowCartViewController: UIViewController {
    
    @IBOutlet weak var showCartTableView: UITableView!
    @IBOutlet weak var totalCostLabel: UILabel!
    
    private var viewModel: ShowCartViewModelProtocol!
    
    func setUpWith(viewModel: ShowCartViewModelProtocol?) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = cartTitle
        showCartTableView.tableFooterView = UIView(frame: CGRect.zero)
        totalCostLabel.text = String(format: "Total Cost: %.2f", viewModel.totalCostOfTrack())
    }

    @IBAction func closeAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension ShowCartViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension ShowCartViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShowCartTableViewCell.identifier,
                                                       for: indexPath) as? ShowCartTableViewCell else {
            fatalError()
        }
        cell.setUp(viewModel: viewModel.modelAt(index: indexPath.row))
        return cell
    }
    
}
