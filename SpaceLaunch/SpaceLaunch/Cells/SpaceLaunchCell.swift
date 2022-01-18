//
//  SpaceLaunchCell.swift
//  SpaceLaunch
//
//  Created by Sheethal Karkera on 17/1/22.
//

import UIKit

final class SpaceLaunchCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nationalityLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(model: SpaceLaunchCellViewModel) {
        nameLabel.text = model.name
        nationalityLabel.text = model.nationality
        thumbnailImageView.downloadImage(urlString: model.imageURLString, placeHolderImage: nil)
    }
    
}




