//
//  RoverName.swift
//  Spacing
//
//  Created by rvsm on 26/05/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import Foundation

public enum RoverName: CaseIterable {
    
    case curiosity
    case opportunity
    case spirit
    
    var name: String {
        switch self {
        case .curiosity: return "curiosity"
        case .opportunity: return "opportunity"
        case .spirit: return "spirit"
        }
    }
}
