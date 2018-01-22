//
//  VenueAPIClient.swift
//  DiscoverVenue
//
//  Created by Luis Calle on 1/19/18.
//  Copyright © 2018 Luis Calle. All rights reserved.
//

import Foundation

struct VenueAPIClient {
    
    private init() {}
    static let manager = VenueAPIClient()
    
    let clientID = "AVBMS5AZM4ZURJ4EBSHNWD1EUTEW4JWVGK5ZBBBM3IBZ302N"
    let clientSecret = "HG50R3IBLNM4VJ0TN3AX0QQSNHCXB452JS0BXE21LPVVFA3D"
    let version = "20180117"
    let endpointUrlStr = "https://api.foursquare.com/v2/venues/search?"
    
    func getVenues(near location: String, with query: String, completionHandler: @escaping ([Venue]) -> Void, errorHandler: @escaping (Error) -> Void) {
        let fullUrl = "\(endpointUrlStr)near=\(location)&query=\(query)&client_id=\(clientID)&&client_secret=\(clientSecret)&v=\(version)"
        guard let url = URL(string: fullUrl) else {
            errorHandler(AppError.badURL(str: fullUrl))
            return
        }
        let urlRequest = URLRequest(url: url)
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let foursquareResponse = try JSONDecoder().decode(FoursquareResponse.self, from: data)
                completionHandler(foursquareResponse.response.venues)
            }
            catch {
                errorHandler(AppError.couldNotParseJSON(rawError: error))
            }
        }
        NetworkHelper.manager.performDataTask(with: urlRequest, completionHandler: completion, errorHandler: errorHandler)
    }
    
}
