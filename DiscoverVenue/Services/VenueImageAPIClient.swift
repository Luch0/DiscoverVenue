//
//  VenueImageAPIClient.swift
//  DiscoverVenue
//
//  Created by Luis Calle on 1/19/18.
//  Copyright © 2018 Luis Calle. All rights reserved.
//

import Foundation
import Alamofire


protocol VenueImageAPIClientDelegate: class {
    func venueImageAPIClientService(_ venueImageAPIClient: VenueImageAPIClient, didReceiveVenueImageURL url: URL?)
}

class VenueImageAPIClient {
    
    //     Lisa's Keys
    //    Client ID
    //    LL2KZGKS4PKGUCB5IHFSYXSP1ZRGLNIXNM43GPRK21FD3GZO
    //    Client Secret
    //    DZKKPJYR2PO3LOOOXONVNUTI3WIAAAONX3TFE1PRPBX1DLMZ
    
    //    Luis Keys
    //    let clientID = "AVBMS5AZM4ZURJ4EBSHNWD1EUTEW4JWVGK5ZBBBM3IBZ302N"
    //    let clientSecret = "HG50R3IBLNM4VJ0TN3AX0QQSNHCXB452JS0BXE21LPVVFA3D"
    
    let clientID = "LL2KZGKS4PKGUCB5IHFSYXSP1ZRGLNIXNM43GPRK21FD3GZO"
    let clientSecret = "DZKKPJYR2PO3LOOOXONVNUTI3WIAAAONX3TFE1PRPBX1DLMZ"
    let version = "20180117"
    
    weak var delegate: VenueImageAPIClientDelegate?
    
    func getVenueImage(with venueID: String) {
        
        let params: [String: Any] = ["client_id"     : clientID,
                                     "client_secret" : clientSecret,
                                     "v"             : version]
        let foursquareImageBaseURL = "https://api.foursquare.com/v2/venues/\(venueID)/photos?"
        
        Alamofire.request(foursquareImageBaseURL, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseData{ (dataResponse) in
            if let error = dataResponse.error {
                print("data response error: \(error.localizedDescription)")
            } else if let data = dataResponse.data {
                do {
                    let venueImagesResponse = try JSONDecoder().decode(ImagesResponse.self, from: data)
                    if venueImagesResponse.response.photos.count == 0 {
                        self.delegate?.venueImageAPIClientService(self, didReceiveVenueImageURL: nil)
                        return
                    }
                    let venueImage = venueImagesResponse.response.photos.items[0]
                    self.delegate?.venueImageAPIClientService(self, didReceiveVenueImageURL: URL(string: "\(venueImage.prefix)300x300\(venueImage.suffix)"))
                } catch {
                    print("decoding error: \(error)")
                }
            }
        }
        
    }
    
}
