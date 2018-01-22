//
//  Venue.swift
//  DiscoverVenue
//
//  Created by Luis Calle on 1/19/18.
//  Copyright © 2018 Luis Calle. All rights reserved.
//

import Foundation

struct FoursquareResponse: Codable {
    let meta: MetaWrapper
    let response: ResponseWrapper
}

struct MetaWrapper: Codable {
    let code: Int
    let requestId: String
}

struct ResponseWrapper: Codable {
    let venues: [Venue]
    let confident : Bool?
}

struct Venue: Codable {
    let id: String
    let name: String
    let contact: ContactWrapper
    let location: LocationWrapper
    let categories: [CategoriesWrapper]
    let verified: Bool
    let stats: StatsWrapper
    let url: String?
    let hasMenu: Bool?
    let menu: MenuWrapper?
    let allowMenuUrlEdit: Bool?
    let beenHere: BeenHereWrapper
    let specials: SpecialsWrapper
    let storeId: String?
    let hereNow: HereNowWrapper
    let referralId: String
    let venueChains: [VenueChainsWrapper]
    let hasPerk: Bool
}

struct ContactWrapper: Codable {
    let phone: String?
    let formattedPhone: String?
    let twitter: String?
    let instagram: String?
    let facebook: String?
    let facebookUsername: String?
    let facebookName: String?
}

struct LocationWrapper: Codable {
    let address: String?
    let crossStreet: String?
    let lat: Double
    let lng: Double
    let labeledLatLngs: [LabeledLatLngsWrapper]?
    let distance: Int?
    let postalCode: String?
    let cc: String
    let city: String?
    let state: String
    let country: String
    let formattedAddress: [String]
}

struct LabeledLatLngsWrapper: Codable {
    let label: String
    let lat: Double
    let lng: Double
}

struct CategoriesWrapper: Codable {
    let id: String
    let name: String
    let pluralName: String
    let shortName: String
    let icon: IconWrapper
    let primary: Bool
}

struct IconWrapper: Codable {
    let prefix: String
    let suffix: String
}

struct StatsWrapper: Codable {
    let checkinsCount: Int
    let usersCount: Int
    let tipCount: Int
}

struct MenuWrapper: Codable {
    let type: String
    let label: String
    let anchor: String
    let url: String
    let mobileUrl: String
}

struct BeenHereWrapper: Codable {
    let lastCheckinExpiredAt: Int
}

struct SpecialsWrapper: Codable {
    let count: Int
    //"items": []
}

struct HereNowWrapper: Codable {
    let count: Int
    let summary: String
    let groups: [GroupsWrapper]
}

struct GroupsWrapper: Codable {
    let type: String
    let name: String
    let count: Int
    //"items": []
}

struct VenueChainsWrapper: Codable {
    let id: String
}

