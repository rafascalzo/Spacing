//
//  MainCell.swift
//  Spacing
//
//  Created by FulltrackMobile on 10/05/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import UIKit

class MainCell: UICollectionViewCell {

    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var favoriteImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let image = UIImage(named: "empty_heart")?.withRenderingMode(.alwaysTemplate)
        favoriteImageView.image = image
        favoriteImageView.tintColor = .white
    }

}
