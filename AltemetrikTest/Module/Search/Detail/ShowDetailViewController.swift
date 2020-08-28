//
//  ShowDetailViewController.swift
//  AltemetrikTest
//
//  Created by Guchhait, Saikat on 28/08/20.
//  Copyright © 2020 Guchhait, Saikat. All rights reserved.
//

import UIKit

private let noData = "No Data"

class ShowDetailViewController: UIViewController {
    
    @IBOutlet weak var artistImageView: UIImageView!
    @IBOutlet weak var collectionNamelabel: UILabel!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var trackPriceLabel: UILabel!
    @IBOutlet weak var releaseDatelabel: UILabel!
    @IBOutlet weak var collectionPriceLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var primaryGenreLabel: UILabel!
    
    var viewModel: DetailViewModelProtocol?
    
    func setUpWith(viewModel: DetailViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel?.artistName
        collectionNamelabel.text = viewModel?.collectionName.ifEmptyOrNil(defaultTo: noData)
        trackNameLabel.text = viewModel?.artistTrack.ifEmptyOrNil(defaultTo: noData)
        trackPriceLabel.text = "$\(viewModel?.trackPrice ?? 0.0)"
        collectionPriceLabel.text = "$\(viewModel?.collectionPrice ?? 0.0)"
        countryLabel.text = viewModel?.country.ifEmptyOrNil(defaultTo: noData)
        primaryGenreLabel.text =  viewModel?.primaryGenre.ifEmptyOrNil(defaultTo: noData)
        countryLabel.text = viewModel?.country.ifEmptyOrNil(defaultTo: noData)
        releaseDatelabel.text = viewModel?.formattedDate.ifEmptyOrNil(defaultTo: noData)
        if let imageData = viewModel?.imageData {
            artistImageView.image = UIImage(data: imageData)
        } else {
            viewModel?.downLoadImageFromString(onCompletion: {[weak self] data in
                if let imgData = data {
                    self?.artistImageView.image = UIImage(data: imgData)
                }
            })
        }
    }
    
}
