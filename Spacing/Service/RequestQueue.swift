//
//  RequestQueue.swift
//  Spacing
//
//  Created by rvsm on 10/05/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import Foundation

class RequestQueue: NSObject {
    
    var queue = Queue()
    
    func tryExecute(completion: @escaping () ->Void) {
        guard let requests = queue.fetch() else { completion(); return }
        guard let request = requests.first else { completion(); return }
        switch request.type {
        case RequestType.pictureOfTheDay.value():
            break;
        case RequestType.marsRoverByEarthDate.value():
//            if let parameters = try? JSONDecoder().decode(MarsEarthDateQueryingParameters.self, from: request.parameters) {
//                NASAAPI.Curiosity.queryByEarthDate(rover: <#Rover#>, queryParameters: parameters) { (decodedObject, error) in
//
//                }
//            }
            break;
        default:
            break;
        }
    }
    
}

enum RequestType : String {
    
    case pictureOfTheDay = "PICTURE_OF_THE_DAY"
    case marsRoverByEarthDate = "MARS_ROVER_PHOTOS_BY_EARTH_DATE"
    case marsRoverByMartianSun = "MARS_ROVER_PHOTOS_BY_MARTIAN_SUN"
    
    func value() -> String {
        return self.rawValue
    }
}

struct Request: Codable {
    
    let type: String
    let parameters: Data
}

struct Queue {
    
    private var itens = [Request]()
    
    var isEmpty: Bool {
        return itens.isEmpty
    }
    
    mutating func push(_ request: Request) {
        itens = fetch() ?? []
        itens.append(request)
        save()
    }
    
    mutating func pop() -> Request? {
        itens = fetch() ?? []
        if !isEmpty {
            let deletedItem = itens.removeFirst()
            save()
            return deletedItem
        }
        return nil
    }
    
    func save() {
        do {
            let dataToSave = try JSONEncoder().encode(itens.self)
            UserDefaultsManager.shared.setRequestQueue(dataToSave)
        } catch {
            print(error.localizedDescription, #file, #function, #line)
        }
    }
    
    func fetch() -> [Request]? {
        if let savedData = UserDefaultsManager.shared.getRequestQueue() {
            do {
                return try JSONDecoder().decode([Request].self, from: savedData)
            } catch {
                print(error.localizedDescription, #file, #function, #line)
            }
        }
        return nil
    }
}

