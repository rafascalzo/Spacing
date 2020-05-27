//
//  EarthImageryQueryParameters.swift
//  Spacing
//
//  Created by rvsm on 11/05/20.
//  Copyright © 2020 rvsm. All rights reserved.
//
/*
 Parameter    Type    Default    Description
 
 lat    float    n/a    Latitude
 lon    float    n/a    Longitude
 dim    float    0.025    width and height of image in degrees
 date    YYYY-MM-DD    today    date of image; if not supplied, then the most recent image (i.e., closest to today) is returned
 cloud_score    bool    False    [NOT CURRENTLY AVAILABLE!!!!] calculate the percentage of the image covered by clouds
 api_key    string    DEMO_KEY    api.nasa.gov key for expanded usage

 */
import Foundation

struct EarthImageryQueryParameters: Codable {
    
    var latitude: Float?
    var longitude: Float?
    var dimension: Double?
    var date: String
    var cloudScore: Bool
    
    private enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lon"
        case dimension = "dim"
        case date = "date"
        case cloudScore = "cloud_score"
    }
}
