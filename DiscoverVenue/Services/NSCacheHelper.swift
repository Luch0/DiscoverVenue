//
//  NSCacheHelper.swift
//  DiscoverVenue
//
//  Created by Luis Calle on 1/25/18.
//  Copyright © 2018 Luis Calle. All rights reserved.
//

import UIKit

class NSCacheHelper {
    
    private init() { }
    static let manager = NSCacheHelper()
    
    private var myCache = NSCache<NSString, UIImage>()
    
    func addImage(with urlStr: String, and image: UIImage) {
        myCache.setObject(image, forKey: urlStr as NSString)
    }
    
    func getImage(with urlStr: String) -> UIImage? {
        return myCache.object(forKey: urlStr as NSString)
    }
    
}

