//
//  VenuesCollections.swift
//  DiscoverVenue
//
//  Created by Caroline Cruz on 1/23/18.
//  Copyright © 2018 Luis Calle. All rights reserved.
//

import Foundation

struct VenuesCollections: Codable {
    let collectionName: String
    let savedVenues: [SavedVenue]
}

struct SavedVenue: Codable {
    let id: String
    let venue: Venue
    let tip: String
    let imageURL: String
}
