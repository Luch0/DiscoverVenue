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
    
    private var venuesCollectionsArr = [VenuesCollections]() {
        didSet{
            saveToPhoneDisk()
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
    func saveToPhoneDisk() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(venuesCollectionsArr)
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
    func loadFromDisk() {
        let path = dataFilePath(withPathName: FileManagerHelper.kPathname)
        let decoder = PropertyListDecoder()
        do {
            let data = try Data.init(contentsOf: path)
            venuesCollectionsArr = try decoder.decode([VenuesCollections].self, from: data)
        } catch {
            print("decoding error: \(error.localizedDescription)")
        }
    }
    
    
    // This adds a VenueCollection to our array of VenueCollections
    func add(venueCollection: VenuesCollections) -> Bool {
        venuesCollectionsArr.append(venueCollection)
        print(venuesCollectionsArr)
        return true
    }
    
    //     This adds a Venue to the Array inside of a VenueCollection
    func addVenueToACollection(collectionName: String?, venueToSave: SavedVenue, and tip: String?) {
        for theSavedVenues in venuesCollectionsArr {
            if collectionName == theSavedVenues.collectionName {
                let copyOfVenue = venueToSave
                copyOfVenue.tip = tip
                theSavedVenues.savedVenues.append(copyOfVenue)
            }
        }
    }
    
    
    
    
    //read
    
    public func getVenuesCollectionsArr() -> [VenuesCollections] {
        return venuesCollectionsArr
    }
    
    //    this func gets the venues insides a collection
    func getVenuesInACollection(collectionName: String) -> [SavedVenue] {
        var arrToReturn = [SavedVenue]()
        for savedVenues in venuesCollectionsArr {
            if collectionName == savedVenues.collectionName {
                arrToReturn = savedVenues.savedVenues
            }
        }
        return arrToReturn
    }
    
    
    //    function to remove a venue from a collection
    func removeAVenue(with venueID: String) {
        for venueCollection in venuesCollectionsArr {
            var indexTracker = -1
            for aVenue in venueCollection.savedVenues {
                indexTracker += 1
                if aVenue.id == venueID {
                    venueCollection.savedVenues.remove(at: indexTracker)
                    indexTracker -= 1 // If it removes a value, the next value in the array will be at the same index as the removed value. So we need to push the indexTracker back one index to match the shift in the array
                }
            }
        }
    }
    
    func eraseSaves(){
        venuesCollectionsArr = []
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
        venuesCollectionsArr.remove(at: index)
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
