//
//  ImageAPIClient.swift
//  DiscoverVenue
//
//  Created by Luis Calle on 1/19/18.
//  Copyright © 2018 Luis Calle. All rights reserved.
//

import UIKit

struct ImageAPIClient {
    
    private init() {}
    static let manager = ImageAPIClient()
    
    func getImage(with venueImage: VenueImage, completionHandler: @escaping (UIImage) -> Void, errorHandler: @escaping (Error) -> Void) {
        let fullImageURL = "\(venueImage.prefix)300x300\(venueImage.suffix)"
        guard let url = URL(string: fullImageURL) else { errorHandler(AppError.badURL(str: fullImageURL)); return }
        let request = URLRequest(url: url)
        //        if let cachedImage = NSCacheHelper.manager.getImage(with: id) {
        //            completionHandler(cachedImage)
        //            return
        //        }
        let completion: (Data) -> Void = { (data: Data) in
            guard let onlineImage = UIImage(data: data) else { errorHandler(AppError.notAnImage); return }
            //            NSCacheHelper.manager.addImage(with: id, and: onlineImage)
            completionHandler(onlineImage)
        }
        NetworkHelper.manager.performDataTask(with: request, completionHandler: completion, errorHandler: errorHandler)
    }
    
}
