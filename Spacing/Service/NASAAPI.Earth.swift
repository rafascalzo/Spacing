//
//  NASAAPI.Earth.swift
//  Spacing
//
//  Created by rvsm on 12/05/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import Foundation
import Alamofire

private let defaultDimension:Double = 0.025

extension NASAAPI {
    
    struct EARTH {
        
        typealias EarthImageryCompletion = (_ success: Bool, _ message: String?) -> Void
        typealias EarthAssetsCompletion = () -> Void
        
        static func fetchImagery(parameters: EarthImageryQueryParameters,completion: @escaping EarthImageryCompletion) {
            
            var queryParameters: [URLQueryItem] = []
            
            if let latitude = parameters.latitude {
                queryParameters.append(URLQueryItem(name: "lat", value: "\(latitude)"))
            }
            if let longitude = parameters.longitude {
                queryParameters.append(URLQueryItem(name: "lon", value: "\(longitude)"))
            }
            //queryParameters.append(URLQueryItem(name: "dim", value: "\(parameters.dimension ?? defaultDimension)"))
            queryParameters.append(URLQueryItem(name: "date", value: parameters.date))
            
            // not currently available
            // queryParameters.append(URLQueryItem(name: "cloud_score", value: parameters.cloudScore ? "true" : "false"))
            
            let url = URLComposer.buildURL(baseUrl: .base, from: .EARTH_IMAGERY, path: nil, queryParameters: queryParameters, apiKey: true)
            
            NASAAPI.shared.requestString(url: url, method: .get, nil, encoding: URLEncoding.default, header: .none, completion: completion)
            
        }
        
        static func fetchAssets(completion: @escaping EarthAssetsCompletion) {
            
        }
    }
}
