//
//  VenuesCollections.swift
//  DiscoverVenue
//
//  Created by Caroline Cruz on 1/23/18.
//  Copyright © 2018 Luis Calle. All rights reserved.
//

import Foundation

class VenuesCollections: Codable {
    var collectionName: String
    var savedVenues: [SavedVenue]
    init(collection: String, savedVenues: [SavedVenue]) {
        self.collectionName = collection
        self.savedVenues = savedVenues
    }
}

class SavedVenue: Codable {
    var id: String
    var venue: Venue
    var tip: String?
    var imageURL: String
    init(id: String, venue: Venue, tip: String?, imageURL: String) {
        self.id = id
        self.venue = venue
        self.tip = tip
        self.imageURL = imageURL
    }
}
