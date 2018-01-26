//
//  VenueAPIClient.swift
//  DiscoverVenue
//
//  Created by Luis Calle on 1/19/18.
//  Copyright © 2018 Luis Calle. All rights reserved.
//

import Foundation
import CoreLocation
import Alamofire

protocol VenueAPIClientDelegate: class {
    func VenueAPIClient(_venueAPIClient: VenueAPIClient, didReceiveVenues venues: [Venue]?)
}

class VenueAPIClient {
    let foursquareBaseURL = "https://api.foursquare.com/v2/venues/search?"
    
    weak var delegate: VenueAPIClientDelegate?
    
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
    
    func getVenues(near location: String, with query: String) {
        
        let params: [String: Any] = ["near"          : location,
                                     "query"         : query,
                                     "limit"         : 10,
                                     "client_id"     : clientID,
                                     "client_secret" : clientSecret,
                                     "v"             : version]
        
        Alamofire.request(foursquareBaseURL, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseData{ (dataResponse) in
            if let error = dataResponse.error {
                print("data response error: \(error.localizedDescription)")
                
                self.delegate?.VenueAPIClient(_venueAPIClient: self, didReceiveVenues: nil)
            } else if let data = dataResponse.data {
                do {
                    let foursquareResponse = try JSONDecoder().decode(FoursquareResponse.self, from: data)
                    if foursquareResponse.response.venues.isEmpty {
                        self.delegate?.VenueAPIClient(_venueAPIClient: self, didReceiveVenues: nil)
                    } else {
                        self.delegate?.VenueAPIClient(_venueAPIClient: self, didReceiveVenues: foursquareResponse.response.venues)
                    }
                } catch {
                    print("decoding error: \(error)")
                    self.delegate?.VenueAPIClient(_venueAPIClient: self, didReceiveVenues: nil)
                }
            }
        }
    }
    
}
