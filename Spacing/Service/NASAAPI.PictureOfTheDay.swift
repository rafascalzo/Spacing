//
//  NASAAPI.PictureOfTheDay.swift
//  Spacing
//
//  Created by rvsm on 10/05/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import Alamofire

extension NASAAPI {
    typealias ApodCompletion = (_ data: PictureOfTheDay? ,_ error: String?) -> Void
    
    func fetchPictureOfTheDay(date: Date ,hd: Bool, completion: @escaping ApodCompletion) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.string(from: date)
        
        var parameters: [URLQueryItem] = []
        
        parameters.append(URLQueryItem(name: "date", value: date))
        parameters.append(URLQueryItem(name: "hd", value: hd.description))
        
        let url = URLComposer.buildURL(baseUrl: .base, from: .APOD, queryParameters: parameters, apiKey: true)
        print(url)
        NASAAPI.shared.requestObject(url: url, method: .get, nil, encoding: URLEncoding.default, header: .none, completion: completion)
    }
}

struct PictureOfTheDay: Codable {
    
    var copyright: String?
    var dateString: String
    var explanation: String
    var hdURL: String?
    var mediaType: String
    var serviceVersion: String
    var title: String
    var urlString: String
    
    private enum CodingKeys: String, CodingKey {
        case copyright = "copyright"
        case dateString = "date"
        case explanation = "explanation"
        case hdURL = "hdurl"
        case mediaType = "media_type"
        case serviceVersion = "service_version"
        case title = "title"
        case urlString = "url"
    }
}


/*
 {"copyright":"Eric Coles","date":"2020-03-19","explanation":"In 1716, English astronomer Edmond Halley noted, \"This is but a little Patch, but it shews itself to the naked Eye, when the Sky is serene and the Moon absent.\" Of course, M13 is now less modestly recognized as the Great Globular Cluster in Hercules, one of the brightest globular star clusters in the northern sky. Sharp telescopic views like this one reveal the spectacular cluster's hundreds of thousands of stars. At a distance of 25,000 light-years, the cluster stars crowd into a region 150 light-years in diameter. Approaching the cluster core upwards of 100 stars could be contained in a cube just 3 light-years on a side. For comparison, the closest star to the Sun is over 4 light-years away. The remarkable range of brightness recorded in this image follows stars into the dense cluster core and reveals three subtle dark lanes forming the apparent shape of a propeller just below and slightly left of center. Distant background galaxies in the medium-wide field of view include NGC 6207 at the upper left.","hdurl":"https://apod.nasa.gov/apod/image/2003/Messier13_HelmColes.jpg","media_type":"image","service_version":"v1","title":"M13: The Great Globular Cluster in Hercules","url":"https://apod.nasa.gov/apod/image/2003/Messier13_HelmColes1024.jpg"}
 */

