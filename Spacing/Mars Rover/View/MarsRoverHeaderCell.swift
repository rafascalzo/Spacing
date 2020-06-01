//
//  MarsRoverHeaderCell.swift
//  Spacing
//
//  Created by FulltrackMobile on 31/05/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import UIKit

class MarsRoverHeaderCell: UICollectionReusableView {
    
    @IBOutlet var roverNameLabel: UILabel!
    @IBOutlet var launchDateLabel: UILabel!
    @IBOutlet var landingDateLabel: UILabel!
    @IBOutlet var maxDateLabel: UILabel!
    @IBOutlet var maxSolLabel: UILabel!
    @IBOutlet var stateLabel: UILabel!
    @IBOutlet var totalPhotosLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
}
