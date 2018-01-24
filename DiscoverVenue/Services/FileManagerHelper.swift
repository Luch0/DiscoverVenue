//
//  FileManagerHelper.swift
//  DiscoverVenue
//
//  Created by Caroline Cruz on 1/23/18.
//  Copyright © 2018 Luis Calle. All rights reserved.
//

import Foundation

class FileManagerHelper {
    
    static let kPathname = "VenuesCollections.plist"
    
    // singleton
    private init(){}
    static let manager = FileManagerHelper()
    
    private var venuesCollections = [VenuesCollections]() {
        didSet{
            saveToDisk()
        }
    }
        // returns documents directory path for app sandbox
        func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
        }
        
        // /documents/Favorites.plist
        // returns the path for supplied name from the dcouments directory
        func dataFilePath(withPathName path: String) -> URL {
        return FileManagerHelper.manager.documentsDirectory().appendingPathComponent(path)
        }
    
    // save to documents directory
    // write to path: /Documents/
    func saveToDisk() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(venuesCollections)
            // Does the writing to disk
            try data.write(to: dataFilePath(withPathName: FileManagerHelper.kPathname), options: .atomic)
        } catch {
            print("encoding error: \(error.localizedDescription)")
        }
        print("\n==================================================")
        print(documentsDirectory())
        print("===================================================\n")
    }
    
//    load from documents directory
    func load() {
        let path = dataFilePath(withPathName: FileManagerHelper.kPathname)
        let decoder = PropertyListDecoder()
        do {
            let data = try Data.init(contentsOf: path)
            venuesCollections = try decoder.decode([VenuesCollections].self, from: data)
        } catch {
            print("decoding error: \(error.localizedDescription)")
        }
    }
    
    // does 2 tasks:
    // 1. stores tip in documents folder
    // 2. appends favorite item to array
    //    func addToSaved(venue: Venue?, andTip: String, collectionID: Int, collectionName: String) -> Bool  {
    func addToSaved(venue: VenuesCollections) -> Bool  {
        //TODO: how to tag collections id or name?
        // checking for uniqueness
//                let indexExist = venuesCollections[collectionID].savedVenues.index{$0.venue.id == venue.id}
//                if indexExist != nil { print("Venue already in collection"); return false }
        //saving user input collection name and tip
        venuesCollections.append(venue)
        print(venuesCollections)
        return true
    }
    
    
    //read
    
    public func getVenuesCollections() -> [VenuesCollections] {
        return venuesCollections
    }
    
    
//    func isVenueInCollection(venue: VenuesCollections) -> Bool {
//        // checking for uniqueness
//        let indexExist = venuesCollections[0].savedVenues.index{ $0.id == venue.id}
//        if indexExist != nil {
//            return true
//        } else {
//            return false
//        }
//    }
    
    func removeCollection(fromIndex index: Int, and venue: SavedVenue) -> Bool {
        venuesCollections.remove(at: index)
        // remove collection
        let imageURL = FileManagerHelper.manager.dataFilePath(withPathName: venue.id)
        do {
            try FileManager.default.removeItem(at: imageURL)
            print("\n==============================================================================")
            print("\(imageURL) removed")
            print("==============================================================================\n")
            return true
        } catch {
            print("error removing: \(error.localizedDescription)")
            return false
        }
    }
}
