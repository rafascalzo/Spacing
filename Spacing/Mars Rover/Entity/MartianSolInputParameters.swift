//
//  MartianSolInputParameters.swift
//  Spacing
//
//  Created by rvsm on 10/05/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import Foundation
/*
sol    int    none    sol (ranges from 0 to max found in endpoint)
camera    string    all    see table above for abbreviations
page    int    1    25 items per page returned
api_key    string    DEMO_KEY    api.nasa.gov key for expanded usage
*/

struct MartianSolInputParameters: Codable {
    
    var authenticated: Bool
    var sol: Int?
    var camera: String?
    var page: Int
    
    private enum CodingKeys: String, CodingKey {
        case authenticated
        case sol = "sol"
        case camera = "camera"
        case page = "page"
    }
}
