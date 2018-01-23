//
//  UserDefaults.swift
//  DiscoverVenue
//
//  Created by Lisa J on 1/23/18.
//  Copyright © 2018 Luis Calle. All rights reserved.
//

import Foundation

struct UserDefaultsHelper {
    static let manager = UserDefaultsHelper()
    private init() {}
    
    private let lastSearchedVenueKey = "lastSearchedVenueKey"
    private let lastSearchedLocationKey = "lastSearchedLocationKey"
    
    //Getting
    func getLastSearchedVenue() -> String? {
        return UserDefaults.standard.string(forKey: lastSearchedVenueKey)
    }
    func getLastSearchedLocation() -> String? {
        return UserDefaults.standard.string(forKey: lastSearchedLocationKey)
    }
    
    //Saving
    func lastSearchedVenue(named: String){
        UserDefaults.standard.setValue(named, forKey: lastSearchedVenueKey)
    }
    func lastSearchedLocation(named: String){
        UserDefaults.standard.setValue(named, forKey: lastSearchedLocationKey)
    }
    
    
}
