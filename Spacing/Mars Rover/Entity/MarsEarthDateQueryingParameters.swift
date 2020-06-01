//
//  MarsEarthDateQueryingParameters.swift
//  Spacing
//
//  Created by rvsm on 10/05/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import Foundation

struct MarsEarthDateQueryingParameters: Codable {
    
    var authenticated: Bool
    var rover: String
    var earthDate: String
    var camera: String?
    var page: Int
    
    private enum CodingKeys: String, CodingKey {
        
        case authenticated, rover
        case earthDate = "earth_date"
        case camera = "camera"
        case page = "page"
    }
}

