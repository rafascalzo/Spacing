//
//  MarsRoverCell.swift
//  Spacing
//
//  Created by rvsm on 11/05/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import UIKit

class MarsRoverCell: UICollectionViewCell {
    
    @IBOutlet var cardImageView: UIImageView!
    
    @IBOutlet var bookmarkImageView: UIImageView!
    @IBOutlet var starImageView: UIImageView!
    @IBOutlet var cameraDescriptionLabel: UILabel!
    @IBOutlet var earthDateLabel: UILabel!
    @IBOutlet var solLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let defaultImage = UIImage(named: "bookmark")?.withRenderingMode(.alwaysTemplate)
        bookmarkImageView.image = defaultImage
        bookmarkImageView.tintColor = .white
        animateCellTransition()
    }
    
    override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bookmarkImageView.gestureRecognizers?.removeAll()
        animateCellTransition()
    }
    
    func animateCellTransition() {
        cardImageView.alpha = 0
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
        self.cardImageView.alpha = 1
        })
    }
}
