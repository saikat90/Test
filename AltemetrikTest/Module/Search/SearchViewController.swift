//
//  SearchViewController.swift
//  AltemetrikTest
//
//  Created by Guchhait, Saikat on 23/08/20.
//  Copyright © 2020 Guchhait, Saikat. All rights reserved.
//

import UIKit

private let searchTitle = "Search"
private let networkErrorTitle = "Network Error"
private let noDataAvailable = "No Data Available"

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchTableView: UITableView!
    
    @IBOutlet weak var resetFilter: UIButton!
    private let refreshControl = UIRefreshControl()
    private var viewModel: SearchViewModelProtocol!
    weak var delegate: SearchCoordinatorDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUpWith(model: SearchViewModel) {
        self.viewModel = model
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = searchTitle
        searchTableView.tableFooterView = UIView(frame: CGRect.zero)
        setUpRefreshControl()
        fetchRequest()
        setUpBarButtonItems()
        filterAndSortApplied()
        addToCartForTrack()
    }
    
    private func setUpRefreshControl() {
        searchTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    private func checkFilterEnableButtonState() {
        resetFilter.isHidden = !viewModel.isFilterApplied()
    }
    
    private func setUpBarButtonItems() {
        let filterImage = UIImage(named: "fliterIcon")
        let leftBarItem = UIBarButtonItem(image: filterImage,
                                          style: .done,
                                          target: self,
                                          action: #selector(launchFilter))
        navigationItem.leftBarButtonItem = leftBarItem
        
        let cartButton = UIButton(type: .system)
        cartButton.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
        cartButton.setImage(UIImage(named:"cart"), for: .normal)
        let cartBarItem = UIBarButtonItem(customView: cartButton)
        cartBarItem.customView?.widthAnchor.constraint(equalToConstant: 24).isActive = true
        cartBarItem.customView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
        navigationItem.rightBarButtonItem = cartBarItem
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    private func fetchRequest() {
        viewModel.fetchRequest {[weak self] error in
            if let message = error  {
                self?.showNetworkAlert(message)
            }
            self?.reloadData()
        }
    }
    
    private func reloadData() {
        refreshControl.endRefreshing()
        searchTableView.reloadData()
    }
    
    private func showNetworkAlert(_ message: String) {
        showAlert(title: networkErrorTitle, with: message)
    }
    
    private func filterAndSortApplied() {
        viewModel.filterAndSort { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.checkFilterEnableButtonState()
            strongSelf.reloadData()
        }
    }
    
    private func addToCartForTrack() {
        viewModel.trackAddedInCart {[weak self] value in
             self?.navigationItem.rightBarButtonItem?.isEnabled = value != 0
        }
    }
    
    @objc func refresh(_ sender: AnyObject) {
        fetchRequest()
    }
    
    @objc func launchFilter() {
        delegate?.launchFilter()
    }
    
    @IBAction func resetFilterAction(_ sender: Any) {
        viewModel.resetFilter()
        checkFilterEnableButtonState()
    }
}

extension SearchViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if viewModel.isArtistEmpty() {
            let noDataLabel = UILabel(frame: CGRect(x: 0,
                                                    y: 0,
                                                    width: tableView.bounds.size.width,
                                                    height: tableView.bounds.size.height))
            noDataLabel.text = noDataAvailable
            noDataLabel.textAlignment = .center
            tableView.backgroundView = noDataLabel
        } else {
            tableView.backgroundView = UIView()
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArtistTableViewCell.identifier,
                                                       for: indexPath) as? ArtistTableViewCell else {
                                                        fatalError()
        }
        cell.setUpWith(model: viewModel.modelAt(index: indexPath.row))
        return cell
    }
    
}

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

