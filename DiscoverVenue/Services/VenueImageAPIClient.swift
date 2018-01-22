//
//  VenueImageAPIClient.swift
//  DiscoverVenue
//
//  Created by Luis Calle on 1/19/18.
//  Copyright © 2018 Luis Calle. All rights reserved.
//

import Foundation

struct VenueImageAPIClient {
    
    private init() {}
    static let manager = VenueImageAPIClient()
    
    let clientID = "AVBMS5AZM4ZURJ4EBSHNWD1EUTEW4JWVGK5ZBBBM3IBZ302N"
    let clientSecret = "HG50R3IBLNM4VJ0TN3AX0QQSNHCXB452JS0BXE21LPVVFA3D"
    let version = "20180117"
    let endpointUrlStr = "https://api.foursquare.com/v2/venues/"
    
    func getVenueImage(with venueID: String, completionHandler: @escaping (VenueImage) -> Void, errorHandler: @escaping (Error) -> Void) {
        let fullUrl = "\(endpointUrlStr)\(venueID)/photos?client_id=\(clientID)&&client_secret=\(clientSecret)&v=\(version)"
        guard let url = URL(string: fullUrl) else {
            errorHandler(AppError.badURL(str: fullUrl))
            return
        }
        let urlRequest = URLRequest(url: url)
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let venueImagesResponse = try JSONDecoder().decode(ImagesResponse.self, from: data)
                if venueImagesResponse.response.photos.count == 0 {
                    errorHandler(AppError.noImages)
                    return
                }
                completionHandler(venueImagesResponse.response.photos.items[0])
            }
            catch {
                errorHandler(AppError.couldNotParseJSON(rawError: error))
            }
        }
        NetworkHelper.manager.performDataTask(with: urlRequest, completionHandler: completion, errorHandler: errorHandler)
    }
    
}
