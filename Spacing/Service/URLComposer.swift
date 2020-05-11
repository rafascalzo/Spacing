//
//  URLComposer.swift
//  Spacing
//
//  Created by rvsm on 10/05/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

enum BaseUrl {
    case base, library
}

import Alamofire
struct URLComposer {
    
    static func buildURL(baseUrl: BaseUrl, from urlType: URLType ,path: String? = nil, queryParameters: [URLQueryItem], apiKey: Bool) -> URLConvertible {
        
        var url: NSURLComponents
        let baseUrl = baseUrl == .base ? NASAAPI.shared.baseURL : NASAAPI.shared.libraryBaseURL
        if let path = path {
            url = NSURLComponents(string: baseUrl + urlType.url() + path)!
        } else {
            url = NSURLComponents(string: baseUrl + urlType.url())!
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
