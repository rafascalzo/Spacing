//
//  EPICCell.swift
//  Spacing
//
//  Created by Rafael Scalzo on 03/06/20.
//  Copyright © 2020 Rafael Scalzo. All rights reserved.
//

import UIKit

class EPICCell: UICollectionViewCell {
    
    @IBOutlet var epicImageView: UIImageView!
    @IBOutlet var leftArrow: UIImageView!
    @IBOutlet var rightArrow: UIImageView!
    @IBOutlet var earthLatitudeLabel: UILabel!
    @IBOutlet var earthLongitudeLabel: UILabel!
    @IBOutlet var sunXPositionLabel: UILabel!
    @IBOutlet var sunYPositionLabel: UILabel!
    @IBOutlet var sunZPositionLabel: UILabel!
    @IBOutlet var moonXPositionLabel: UILabel!
    @IBOutlet var moonYPositionLabel: UILabel!
    @IBOutlet var moonZPositionLabel: UILabel!
    @IBOutlet var satelliteXPositionLabel: UILabel!
    @IBOutlet var satelliteYPositionLabel: UILabel!
    @IBOutlet var satelliteZPositionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let leftArrowImage = UIImage(named: "left-arrow")?.withRenderingMode(.alwaysTemplate)
        leftArrow.image = leftArrowImage
        leftArrow.tintColor = .white
        
        let rightArrowImage = UIImage(named: "right-arrow")?.withRenderingMode(.alwaysTemplate)
        rightArrow.image = rightArrowImage
        rightArrow.tintColor = .white
    }
    
    var touchLocation: CGPoint?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           super.touchesBegan(touches, with: event)
           let touch = touches.first
           self.touchLocation = touch?.location(in: touch?.view)
    }
}
