//
//  FilterViewController.swift
//  AltemetrikTest
//
//  Created by Guchhait, Saikat on 27/08/20.
//  Copyright © 2020 Guchhait, Saikat. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    
    @IBOutlet weak var trackPriceButton: UIButton!
    @IBOutlet weak var releaseButton: UIButton!
    @IBOutlet weak var holidayButton: UIButton!
    @IBOutlet weak var popButton: UIButton!
    @IBOutlet weak var alternativeButton: UIButton!
    @IBOutlet weak var rockButton: UIButton!
    
    private var viewModel: FilterViewModelProtocol!
    var applyFilterCompletion: (() -> ())?
    
    func setUpWith(viewModel: FilterViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateFilterSortButtonState()
    }
    
    private func updateFilterSortButtonState() {
        trackPriceButton.isSelected = viewModel.enableSortByCollectionPrice()
        releaseButton.isSelected = viewModel.enableSortByReleaseDate()
        guard let button = view.viewWithTag(viewModel.enableFilterButtonWithTag()) as? UIButton else {
            return
        }
        button.isSelected = true
    }
    
    private func unSelectFilterApartFrom(current: UIButton) {
        PrimaryGenreName.allCases.forEach { genre in
            guard let button = view.viewWithTag(genre.rawValue) as? UIButton,
                button.tag != current.tag else {
                return
            }
            button.isSelected = false
        }
    }
    
    @IBAction func sortByTrackPrice(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        releaseButton.isSelected = false
        viewModel.sortByCollectionPrice(selected: sender.isSelected)
    }
    
    @IBAction func sortByReleaseDate(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        trackPriceButton.isSelected = false
        viewModel.sortByReleaseDate(selected: sender.isSelected )
    }
    
    @IBAction func filterByPrimaryGenreName(_ sender: UIButton) {
        unSelectFilterApartFrom(current: sender)
        sender.isSelected = !sender.isSelected
        guard let genre = PrimaryGenreName(rawValue: sender.tag) else {
            return
        }
        viewModel?.setFilterOn(genre: genre)
    }
    
    @IBAction func dissmissFilterAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func applyFilterAction(_ sender: Any) {
        dismiss(animated: true) { [weak self] in
            self?.applyFilterCompletion?()
        }
    }
    
}
