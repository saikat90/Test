//
//  ArtistTableViewCell.swift
//  AltemetrikTest
//
//  Created by Guchhait, Saikat on 23/08/20.
//  Copyright © 2020 Guchhait, Saikat. All rights reserved.
//

import UIKit

class ArtistTableViewCell: UITableViewCell {
    
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var trackLabel: UILabel!
    @IBOutlet weak var collectionNameLabel: UILabel!
    @IBOutlet weak var trackPriceLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var sepratorView: UIView!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var addStepper: UIStepper!
    
    static let identifier = "ArtistTableViewCell"
    
    private var model: ArtistCellViewModel? {
        didSet {
            updateWithModel()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpWith(model: ArtistCellViewModel) {
        self.model = model
    }
    
    func updateWithModel() {
        artistLabel.text = model?.artistName
        trackLabel.text = model?.artistTrack
        collectionNameLabel.text = model?.collectionName ?? "No Data"
        trackPriceLabel.text = String(model?.trackPrice ?? 0.0)
        countLabel.text = "\(model?.numberOfTracks ?? 0)"
        genreLabel.text = model?.genre
        addStepper.value = Double(model?.numberOfTracks ?? 0)
        if let isAddToCartButtonEnabled = model?.isAddToCartButtonEnabled(),
            isAddToCartButtonEnabled {
            addToCartButton.isHidden = false
            hideCartLayout()
        } else {
            addToCartButton.isHidden = true
            updateCartLayout()
        }
    }
    
    private func updateCartLayout() {
        sepratorView.isHidden = false
        countLabel.isHidden = false
        addStepper.isHidden = false
    }
    
    private func hideCartLayout() {
        sepratorView.isHidden = true
        countLabel.isHidden = true
        addStepper.isHidden = true
    }
    
    private func updateStepperWithModel() {
        model?.numberOfTracks = Int(addStepper.value)
        countLabel.text = "\(Int(addStepper.value))"
        if addStepper.value == 0 {
            hideCartLayout()
            addToCartButton.isHidden = false
        }
    }
    
    @IBAction func addToCartAction(_ stepper: UIStepper) {
        updateStepperWithModel()
    }
    
    @IBAction func enableAddToCartAction(_ sender: Any) {
        addToCartButton.isHidden = true
        addStepper.value = 1.0
        updateStepperWithModel()
        updateCartLayout()
    }
    
}
