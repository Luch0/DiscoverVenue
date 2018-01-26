//
//  LocationService.swift
//  DiscoverVenue
//
//  Created by Luis Calle on 1/19/18.
//  Copyright © 2018 Luis Calle. All rights reserved.
//

import Foundation
import CoreLocation

class LocationService: NSObject {
    
    private override init() {
        super.init()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
    }
    static let manager = LocationService()
    
    private var locationManager: CLLocationManager!
    
    var lat: Double!
    var lon: Double!
    
}

extension LocationService {
    
    public func checkForLocationServices() -> CLAuthorizationStatus {
        var status: CLAuthorizationStatus!
        
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
                print("Not Determined")
                locationManager.requestWhenInUseAuthorization()
            case .denied:
                print("Denied")
            case .authorizedAlways:
                print("Authorized Always")
            case .authorizedWhenInUse:
                print("Authorized When in Use")
            default:
                break
            }
        } else { // update UI to inform user
            print("Go to settings to update your location persmission")
        }
        status = CLLocationManager.authorizationStatus()
        return status
    }
    
}

extension LocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //print("Did update locations")
        
        lat = locations.last?.coordinate.latitude
        lon = locations.last?.coordinate.longitude
        
        //print("didUpdateLocations: \(locations)")
        
        //guard let location = locations.last else { print("no location data"); return }
        
        // update user preferences
        //UserPreference.manager.setLatitude(latitude: location.coordinate.latitude)
        //UserPreference.manager.setLongitude(longitude: location.coordinate.longitude)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Manager: didFailWithError - \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("Location Manager: didChangeAuthorization - \(status)") // e.g .denied
    }
    
    func getCurrentLatitude() -> Double? {
        return lat
    }
    
    func getCurrentLongitude() -> Double? {
        return lon
    }
    
}
