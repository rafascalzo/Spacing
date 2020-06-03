//
//  URLComposer.swift
//  Spacing
//
//  Created by rvsm on 10/05/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

enum BaseUrl {
    case base, library, epic
}

import Alamofire
struct URLComposer {
    
    static func buildURL(baseUrl: BaseUrl = .base, from urlType: URLType? = nil ,path: String? = nil, queryParameters: [URLQueryItem], apiKey: Bool) -> URLConvertible {
        
        var url: NSURLComponents
        var urlstring = NASAAPI.shared.baseURL
        switch baseUrl {
        case .library: urlstring = NASAAPI.shared.libraryBaseURL
        case .epic: urlstring = NASAAPI.shared.epicBaseURL
        default: break
        }
        if let path = path {
            if let type = urlType {
                url = NSURLComponents(string: urlstring + type.url() + path)!
            } else {
                url = NSURLComponents(string: urlstring + path)!
            }
        } else {
            if let type = urlType {
                url = NSURLComponents(string: urlstring + type.url())!
            } else {
                url = NSURLComponents(string: urlstring)!
            }
        }
        var itens = [URLQueryItem]()
        
        for parameter in queryParameters {
            itens.append(URLQueryItem(name: parameter.name, value: parameter.value))
        }
        if apiKey {
            itens.append(URLQueryItem(name: "api_key", value: NASAAPI.shared.apiKey))
        }
        url.queryItems = itens
        return url.url!
    }
}
