//
//  NASAAPI.EPIC.swift
//  Spacing
//
//  Created by rvsm on 02/06/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import Alamofire

extension NASAAPI {
    
    struct EPICAPI {
        
        typealias EPICCompletion = (_ objects: [EPICModel]?, _ error: String?) -> Void
        
        static func fetchImagery(parameters: EpicQueryingParameters,completion: @escaping EPICCompletion) {
            var path: String = parameters.colorImageQuality
            
            if !(parameters.parameterOption == EPICParametersOptions.most_recent.identifier) {
                path = path + "/\(parameters.parameterOption)"
                
                if parameters.parameterOption == EPICParametersOptions.date.identifier {
                    if let date = parameters.date {
                        path = path + "/\(date)"
                    }
                }
            }
            
            let url = URLComposer.buildURL(baseUrl: .epic, from: nil, path: path, queryParameters: [], apiKey: true)
            print(url)
            NASAAPI.shared.requestObjectList(url: url, method: .get, nil, encoding: URLEncoding.default, header: .none, completion: completion)
            
        }
    }
}

/*
 image [name]
 date
 caption
 centroid_coordinates
 dscovr_j2000_position
 lunar_j2000_position
 sun_j2000_position
 attitude_quaternions
 coords
 {
 lat (Latitude)
 lon (Longitude)
 dscovr_j2000_position
 lunar_j2000_position   (Position of the moon in space)
 sun_j2000_position (Position of the sun in space)
 attitude_quaternions   (Satellite attitude)
 }
 */

struct EPICModel: Codable {
    
    var id: String
    var caption: String
    var imageName: String
    var version: String
    var satelliteFocusedCoordinates: SatelliteFocusedCoordinates
    var satellitePosition: SpacePosition
    var moonPosition: SpacePosition
    var sunPosition: SpacePosition
    var satelliteAttitude: SatelliteAttitude
    var date: String
    var coordinates: Coordinates
    
    private enum CodingKeys: String, CodingKey {
        case id = "identifier"
        case caption = "caption"
        case imageName = "image"
        case version = "version"
        case satelliteFocusedCoordinates = "centroid_coordinates"
        case satellitePosition = "dscovr_j2000_position"
        case moonPosition = "lunar_j2000_position"
        case sunPosition = "sun_j2000_position"
        case satelliteAttitude = "attitude_quaternions"
        case date = "date"
        case coordinates = "coords"
    }
}

struct Coordinates: Codable {
    
    var satelliteFocusedCoordinates: SatelliteFocusedCoordinates
    var satellitePosition: SpacePosition
    var moonPosition: SpacePosition
    var sunPosition: SpacePosition
    var satelliteAttitude: SatelliteAttitude
    
    private enum CodingKeys: String, CodingKey {
        case satelliteFocusedCoordinates = "centroid_coordinates"
        case satellitePosition = "dscovr_j2000_position"
        case moonPosition = "lunar_j2000_position"
        case sunPosition = "sun_j2000_position"
        case satelliteAttitude = "attitude_quaternions"
    }
}

// (Geographical coordinates that the satellite is looking at)
struct SatelliteFocusedCoordinates : Codable{
    var latitude: Double
    var longitude: Double
    
    private enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lon"
    }
}

struct SpacePosition: Codable {
    var x: Double
    var y: Double
    var z: Double
    
    private enum CodingKeys: String, CodingKey {
        case x = "x"
        case y = "y"
        case z = "z"
    }
}


// (Satellite attitude)

struct SatelliteAttitude: Codable {
    
    var q0: Double
    var q1: Double
    var q2: Double
    var q3: Double
    
    private enum CodingKeys: String, CodingKey {
        
        case q0 = "q0"
        case q1 = "q1"
        case q2 = "q2"
        case q3 = "q3"
    }
}
