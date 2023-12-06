//
//  NASAAPI.swift
//  Spacing
//
//  Created by rvsm on 10/05/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import Foundation
import Alamofire

enum URLType {
    
    case APOD, MARS_CURIOSITY, MARS_OPPORTUNITY, MARS_SPIRIT, searchImageVideoLibrary, mediaAssetsImageLibrary, EARTH_IMAGERY
    
    func url() -> String {
        switch self {
        case .APOD: return "planetary/apod"
        case .MARS_CURIOSITY: return "mars-photos/api/v1/rovers/curiosity/photos"
        case .MARS_OPPORTUNITY: return "mars-photos/api/v1/rovers/opportunity/photos"
        case .MARS_SPIRIT: return "mars-photos/api/v1/rovers/spirit/photos"
        case .searchImageVideoLibrary: return "search"
        case .mediaAssetsImageLibrary: return "asset/"
        case .EARTH_IMAGERY: return "planetary/earth/imagery"
        }
    }
}

class NASAAPI: NSObject {
    
    var apiKey: String {
        return Bundle.main.infoDictionary!["API KEY"] as! String
    }
    
    var baseURL: String {
        return Bundle.main.infoDictionary!["BASE URL"] as! String
    }
    
    var libraryBaseURL: String {
        return Bundle.main.infoDictionary!["LIBRARY BASE URL"] as! String
    }
    
    var epicBaseURL: String {
        return Bundle.main.infoDictionary!["EPIC BASE URL"] as! String
    }
    
    static var shared = NASAAPI()
    
    func printAPIKey() {
        print(apiKey)
    }
    
    func request(_ url: URLConvertible, method: HTTPMethod = .get, _ parameters: Parameters? = nil, encoding: ParameterEncoding = JSONEncoding.default, headers: HTTPHeaders? = nil) -> DataRequest {
        
        return AF.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
    }
    
    func requestObject<T: Codable>(url: URLConvertible, method: HTTPMethod = .get,_ parameters: EncodableObject? = nil, encoding: ParameterEncoding = JSONEncoding.default, header: HTTPHeaders? = nil, completion: @escaping(T?, String?) -> Void) {
        guard Network.isConnectedToNetwork() else { completion(nil, "no_connection"); return}
        var headers = [String:String]()
        
        switch header {
        case .none:
            headers = [:]
        default:
            break
        }
        
        var parametersDictionary: [String:Any]?
        
        if let parameters = parameters {
            do {
                let encodedParameters = try JSONEncoder().encode(parameters)
                parametersDictionary = try JSONSerialization.jsonObject(with: encodedParameters, options: []) as? [String:Any]
            } catch {
                completion(nil, error.localizedDescription)
            }
        }
        
        request(url, method: method, parametersDictionary, encoding: encoding, headers: HTTPHeaders(headers)).validate().responseJSON { response in
            print(response)
            guard let data = response.data else { completion(nil, "error_default"); return }
            
            switch response.result {
            case .success(_):
                do {
                    let decodedObject = try JSONDecoder().decode(T.self, from: data)
                    completion(decodedObject, nil)
                } catch {
                    completion(nil, error.localizedDescription)
                }
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
    
    func requestObjectList<T: Codable>(url: URLConvertible, method: HTTPMethod = .get,_ parameters: EncodableObject? = nil, encoding: ParameterEncoding = JSONEncoding.default, header: HTTPHeaders? = nil, completion: @escaping([T]?, String?) -> Void) {
        guard Network.isConnectedToNetwork() else { completion(nil, "no_connection"); return}
        var headers = [String:String]()
        
        switch header {
        case .none:
            headers = [:]
        default:
            break
        }
        
        var parametersDictionary: [String:Any]?
        
        if let parameters = parameters {
            do {
                let encodedParameters = try JSONEncoder().encode(parameters)
                parametersDictionary = try JSONSerialization.jsonObject(with: encodedParameters, options: []) as? [String:Any]
            } catch {
                completion(nil, error.localizedDescription)
            }
        }
        
        request(url, method: method, parametersDictionary, encoding: encoding, headers: HTTPHeaders(headers)).validate().responseJSON { response in
            print(response)
            guard let data = response.data else { completion(nil, "error_default"); return }
            
            switch response.result {
            case .success(_):
                do {
                    let decodedObject = try JSONDecoder().decode([T].self, from: data)
                    completion(decodedObject, nil)
                } catch {
                    completion(nil, error.localizedDescription)
                }
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
    
    func requestString(url: URLConvertible, method: HTTPMethod = .get,_ parameters: EncodableObject? = nil, encoding: ParameterEncoding = JSONEncoding.default, header: HTTPHeaders? = nil, completion: @escaping(Bool, String?) -> Void) {
        guard Network.isConnectedToNetwork() else { completion(false, "no_connection"); return}
        var headers = [String:String]()
        
        switch header {
        case .none:
            headers = [:]
        default:
            break
        }
        
        var parametersDictionary: [String:Any]?
        
        if let parameters = parameters {
            do {
                let encodedParameters = try JSONEncoder().encode(parameters)
                parametersDictionary = try JSONSerialization.jsonObject(with: encodedParameters, options: []) as? [String:Any]
            } catch {
                completion(false, error.localizedDescription)
            }
        }
        
        request(url, method: method, parametersDictionary, encoding: encoding, headers: HTTPHeaders(headers)).validate().responseString { response in
            print(response)
            guard let data = response.data else { completion(false, "error_default"); return }
            let base = data.base64EncodedData()
            
            if let responseString = String(data: base as Data, encoding: String.Encoding.utf8) {
                switch response.result {
                case .success(_):
                    completion(true, responseString)
                case .failure(let error):
                    completion(false, error.localizedDescription)
                }
            } else {
                var message: String?
                if let urls = String(data: data, encoding: .unicode) {
                    print(urls)
                }
                do {
                    let jsonResult = try JSONSerialization.jsonObject(with: data, options: [.mutableLeaves, JSONSerialization.ReadingOptions.mutableContainers])
                    guard
                        let dictionary = jsonResult as? [String: Any],
                        let msg = dictionary["msg"] as? String else {
                            print("The JSON structure doesn't meet our expectations \(data)")
                            return
                    }
                    message = msg
                } catch {
                    print(error.localizedDescription, #file, #function, #line)
                }
                
                switch response.result {
                case .success(_):
                    completion(true, message)
                case .failure(let error):
                    completion(false, error.localizedDescription)
                }
            }
        }
    }
}

public struct EncodableObject : Encodable {
    
    private let encode: (Encoder) throws -> Void
    
    public init<Element: Encodable>(_ object: Element) {
        encode = object.encode
    }
    
    public func encode(to encoder: Encoder) throws {
        try encode(to: encoder)
    }
}

public enum HttpStatusCode: Int {
    
    case ok = 200
    case created = 201
    case forbidden = 403
    case notFound = 404
    case unauthorized = 401
    case badRequest = 400
    case unacceptable = 500
}

enum headerType {
    case none, urlEncoded, urlEncodedWithAuthentication ,multipartFormdata, multipartFormdataWithAuthentication
}

class Header: NSObject {
    
    static var shared = Header()
    
    var none: [String:String] {
        return [:]
    }
    
    var multipartFormData: [String:String] {
        return ["Content-Type": "multipart/form-data"]
    }
}
