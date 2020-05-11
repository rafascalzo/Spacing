//
//  UserDefaultsManager.swift
//  Spacing
//
//  Created by rvsm on 10/05/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import Foundation

class UserDefaultsManager: NSObject {
    
    static var shared = UserDefaultsManager()
    
    private let defaults = UserDefaults.standard
    private let requestQueueKey = "RequestQueueKey"
    
    func getRequestQueue() -> Data? {
        return defaults.object(forKey: requestQueueKey) as? Data
    }
    
    func setRequestQueue(_ requests: Data) {
        defaults.set(requests, forKey: requestQueueKey)
    }
}

