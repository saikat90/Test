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
    @IBOutlet weak var collectionPriceLabel: UILabel!
    
    static let identifier = "ArtistTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpWith(model: ArtistCellViewModel) {
        artistLabel.text = model.artistName
        trackLabel.text = model.artistTrack
        collectionNameLabel.text = model.collectionName ?? "No Data"
        collectionPriceLabel.text = String(model.collectionPrice ?? 0.0)
    }

}
