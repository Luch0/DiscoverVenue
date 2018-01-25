//
//  VenuesCollections.swift
//  DiscoverVenue
//
//  Created by Caroline Cruz on 1/23/18.
//  Copyright © 2018 Luis Calle. All rights reserved.
//

import Foundation

struct VenuesCollections: Codable {
    var collectionName: String
    var savedVenues: [SavedVenue]
}

struct SavedVenue: Codable {
    var id: String
    let venue: Venue
    var tip: String?
    var imageURL: String
}
