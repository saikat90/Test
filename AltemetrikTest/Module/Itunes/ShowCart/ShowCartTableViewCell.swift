//
//  ShowCartTableViewCell.swift
//  AltemetrikTest
//
//  Created by Guchhait, Saikat on 28/08/20.
//  Copyright © 2020 Guchhait, Saikat. All rights reserved.
//

import UIKit

class ShowCartTableViewCell: UITableViewCell {

    @IBOutlet weak var trackCostLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var trackNameLabel: UILabel!
    
    static let identifier = "ShowCartTableViewCell"
    var cellModel: ShowCartCellViewModelProtocol!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  
    func setUp(viewModel: ShowCartCellViewModelProtocol) {
        trackCostLabel.text = "\(viewModel.trackPrice ?? 0)"
        trackNameLabel.text = viewModel.artistTrack ?? "NA"
        quantityLabel.text =  "X \(viewModel.numberOfTracks)"
    }

}
