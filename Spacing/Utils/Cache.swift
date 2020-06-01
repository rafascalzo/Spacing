//
//  Cache.swift
//  Spacing
//
//  Created by rvsm on 11/05/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import UIKit

class Cache: NSObject {
    
    typealias ImageCompletion = (_ image: UIImage?) -> Void
    
    static var images = NSCache<NSString, UIImage>()
    
    static func initCache(capacity megaBytes: Int) {
        let memoryCapacity = megaBytes * 1024 * 1024
        let diskCapacity = megaBytes * 1024 * 1024
        let urlCache = URLCache(memoryCapacity: memoryCapacity , diskCapacity: diskCapacity, diskPath: "Cache")
        URLCache.shared = urlCache
    }
    
    static func clearAll() {
        images.removeAllObjects()
    }
    
    static func save(_ image: UIImage, name: String) {
        images.setObject(image, forKey: name as NSString)
    }
    
    static func fetchImage(named name: String) -> UIImage? {
        return images.object(forKey: name as NSString)
    }
    
    static func downloadImage(urlString: String, completion: @escaping ImageCompletion) {
        
        if let savedImage = images.object(forKey: urlString as NSString) {
            completion(savedImage)
        } else {
            let formatted = urlString.hasPrefix("httpss") ? urlString.replacingOccurrences(of: "httpss", with: "https") : urlString
            if let url = URL(string: formatted) {
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: url) {
                        if let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                images.setObject(image, forKey: urlString as NSString)
                                completion(image)
                            }
                        } else {
                            DispatchQueue.main.async {
                                completion(nil)
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            completion(nil)
                        }
                    }
                }
            } else {
                completion(nil)
            }
        }
    }
}
