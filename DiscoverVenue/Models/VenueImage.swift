//
//  VenueImage.swift
//  DiscoverVenue
//
//  Created by Luis Calle on 1/19/18.
//  Copyright © 2018 Luis Calle. All rights reserved.
//

import Foundation

struct ImagesResponse: Codable {
    let meta: ImagesMetaWrapper
    let response: ImageResponseWrapper
}

struct ImagesMetaWrapper: Codable {
    let code: Int
    let requestId: String
}

struct ImageResponseWrapper: Codable {
    let photos: PhotosWrapper
}

struct PhotosWrapper: Codable {
    let count: Int
    let items: [VenueImage]
    let dupesRemoved: Int
}

struct VenueImage: Codable {
    let id: String
    let createdAt: Int
    let source: SourceWrapper
    let prefix: String
    let suffix: String
    let width: Int
    let height: Int
    let user: UserWrapper
    let visibility: String
}

struct SourceWrapper: Codable {
    let name: String
    let url: String
}

struct UserWrapper: Codable {
    let id: String
    let firstName: String
    let lastName: String?
    let gender: String
    let photo: PhotoWrapper
}

struct PhotoWrapper: Codable {
    let prefix: String
    let suffix: String
    let `default`: Bool?
}
