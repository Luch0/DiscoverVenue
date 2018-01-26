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
    func venueImageAPIClientService(_ venueImageAPIClient: VenueImageAPIClient, didReceiveVenueImageURL url: URL?, venue: Venue, image: UIImage?)
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
    
    //    Caroline's Keys
    //    let clientID = "THCDBDGXTZOKSF2RFZYTDKGZMETDCI5PXVH2ZNVNI4UKTXDI"
    //    let clientSecret = "3QI1E2MX1RFINQOLGNCQN0VU42FMJ5JL4K0MNLB2VQA0WFY0"
    
     // Richard's keys
    //    Client ID
    //    5AGOFYCG3TUAKAQXN0ZZKEKWNZT5EUYZHTFAWQLYVNHIMZ2V
    //    Client Secret
    //    GCTLLD1M3PGLGGYXAPZ5CLF3ADTQ54JVFU4YSFSV4O2CKQQJ
    
    private let clientID = "5AGOFYCG3TUAKAQXN0ZZKEKWNZT5EUYZHTFAWQLYVNHIMZ2V"
    private let clientSecret = "GCTLLD1M3PGLGGYXAPZ5CLF3ADTQ54JVFU4YSFSV4O2CKQQJ"
    private let version = "20180117"
    
    weak var delegate: VenueImageAPIClientDelegate?
    
    func getVenueImage(with venue: Venue) {
        
        // check if image is cached
        if let image = NSCacheHelper.manager.getImage(with: venue.id) {
            self.delegate?.venueImageAPIClientService(self, didReceiveVenueImageURL: nil, venue: venue, image: image)
            return
        }
        
        let params: [String: Any] = ["client_id"     : clientID,
                                     "client_secret" : clientSecret,
                                     "v"             : version]
        let foursquareImageBaseURL = "https://api.foursquare.com/v2/venues/\(venue.id)/photos?"
        
        Alamofire.request(foursquareImageBaseURL, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseData{ (dataResponse) in
            if let error = dataResponse.error {
                print("data response error: \(error.localizedDescription)")
                self.delegate?.venueImageAPIClientService(self, didReceiveVenueImageURL: nil, venue: venue, image: nil)
            } else if let data = dataResponse.data {
                do {
                    let venueImagesResponse = try JSONDecoder().decode(ImagesResponse.self, from: data)
                    if venueImagesResponse.response.photos.count == 0 {
                        self.delegate?.venueImageAPIClientService(self, didReceiveVenueImageURL: nil, venue: venue, image: nil)
                        return
                    }
                    let venueImage = venueImagesResponse.response.photos.items[0]
                    self.delegate?.venueImageAPIClientService(self, didReceiveVenueImageURL: URL(string: "\(venueImage.prefix)300x300\(venueImage.suffix)"), venue: venue, image: nil)
                } catch {
                    print("decoding error: \(error)")
                }
            }
        }
        
    }
    
}
