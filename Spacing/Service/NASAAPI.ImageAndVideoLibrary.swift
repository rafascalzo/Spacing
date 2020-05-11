//
//  NASAAPI.ImageAndVideoLibrary.swift
//  Spacing
//
//  Created by rvsm on 10/05/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import Foundation
import Alamofire
/*
 GET /search?q={q}    Performing a search
 GET /asset/{nasa_id}    Retrieving a media asset’s manifest
 GET /metadata/{nasa_id}    Retrieving a media asset’s metadata location
 GET /captions/{nasa_id}    Retrieving a video asset’s captions location
 
 */

extension NASAAPI {
    
    typealias SearchCompletion = (_ data: ImageVideLibraryDataWrapper?, _ error: String?) -> Void
    
    static func search(parameters: LibrarySearchParameters, completion: @escaping SearchCompletion) {
        
        var queryParameters: [URLQueryItem] = []
        if let searchTherm = parameters.searchTherm {
            queryParameters.append(URLQueryItem(name: "q", value: searchTherm))
        }
        if let center = parameters.center {
            queryParameters.append(URLQueryItem(name: "center", value: center))
        }
        if let description = parameters.description {
            queryParameters.append(URLQueryItem(name: "description", value: description))
        }
        if let description508 = parameters.description508 {
            queryParameters.append(URLQueryItem(name: "description_508", value: description508))
        }
        if let keywords = parameters.keywords {
            queryParameters.append(URLQueryItem(name: "keywords", value: keywords))
        }
        if let location = parameters.location {
            queryParameters.append(URLQueryItem(name: "location", value: location))
        }
        if let mediaType = parameters.mediaType {
            queryParameters.append(URLQueryItem(name: "media_type", value: mediaType))
        }
        if let nasaId = parameters.nasaId {
            queryParameters.append(URLQueryItem(name: "nasa_id", value: nasaId))
        }
        if let page = parameters.page {
            queryParameters.append(URLQueryItem(name: "page", value: "\(page)"))
        }
        if let photographer = parameters.photographer {
            queryParameters.append(URLQueryItem(name: "photographer", value: photographer))
        }
        if let secondaryCreator = parameters.secondaryCreator {
            queryParameters.append(URLQueryItem(name: "secondary_creator", value: secondaryCreator))
        }
        if let title = parameters.title {
            queryParameters.append(URLQueryItem(name: "title", value: title))
        }
        if let yearStart = parameters.yearStart {
            queryParameters.append(URLQueryItem(name: "year_start", value: yearStart))
        }
        if let yearEnd = parameters.yearEnd {
            queryParameters.append(URLQueryItem(name: "year_end", value: yearEnd))
        }
        
        let url = URLComposer.buildURL(baseUrl: .library, from: .searchImageVideoLibrary, path: nil, queryParameters: queryParameters, apiKey: parameters.authenticated)
        print(url)
        NASAAPI.shared.requestObject(url: url, method: .get, nil, encoding: URLEncoding.default, header: nil, completion: completion)
    }
    
}

struct ImageVideLibraryDataWrapper: Codable {
    var collection: SearchDataWrapper
    
    private enum CodingKeys: String, CodingKey {
        case collection = "collection"
    }
}

struct SearchDataWrapper: Codable {
    var href: String
    var items: [ImageVideoLibraryCollecion]
    var links: [Link]
    var metadata: MetaData
    var version: String
    
    private enum CodingKeys: String, CodingKey {
        case href = "href"
        case items = "items"
        case links = "links"
        case metadata = "metadata"
        case version = "version"
    }
}

struct ImageVideoLibraryCollecion: Codable {
    var data: [SearchData]
    var href: String
    var links: [InnerLink]
    
    private enum CodingKeys: String, CodingKey {
        case data = "data"
        case href = "href"
        case links = "links"
    }
}

struct SearchData: Codable {
    var center: String
    var dateCreated: String
    var description: String
    var keywords: [String]
    var mediaType: String
    var nasaId: String
    var title: String
    
    private enum CodingKeys: String, CodingKey {
        case center = "center"
        case dateCreated = "date_created"
        case description = "description"
        case keywords = "keywords"
        case mediaType = "media_type"
        case nasaId = "nasa_id"
        case title = "title"
    }
}

struct Link: Codable {
    var href: String
    var prompt: String
    var rel: String
    
    private enum CodingKeys: String, CodingKey {
        case href = "href"
        case prompt = "prompt"
        case rel = "rel"
    }
}

struct InnerLink: Codable {
    var href: String
    var rel: String
    var render: String
    
    private enum CodingKeys: String, CodingKey {
        case href = "href"
        case rel = "rel"
        case render = "render"
    }
}

struct MetaData: Codable {
    var totalHits: Int
    
    private enum CodingKeys: String, CodingKey {
        case totalHits = "total_hits"
    }
}

