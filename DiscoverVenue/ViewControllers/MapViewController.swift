//
//  MapViewController.swift
//  DiscoverVenue
//
//  Created by Luis Calle on 1/19/18.
//  Copyright © 2018 Luis Calle. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController {
    
    private let cellSpacing: CGFloat = 5.0
    
    var venues = [Venue]() {
        didSet {
            mapView.venuesCollectionView.reloadData()
            mapView.venuesCollectionView.setContentOffset(CGPoint.zero, animated: true)
            addVenueAnnotations()
        }
    }
    
    private var venueAnnotations = [MKAnnotation]()
    
    func addVenueAnnotations() {
        for venue in venues {
            let venueLocation: CLLocation = CLLocation(latitude: venue.location.lat, longitude: venue.location.lng)
            let venueAnnotation = MKPointAnnotation()
            venueAnnotation.coordinate = venueLocation.coordinate
            venueAnnotation.title = venue.name
            venueAnnotations.append(venueAnnotation)
            mapView.venuesMapView.addAnnotation(venueAnnotation)
        }
        mapView.venuesMapView.addAnnotations(venueAnnotations)
        mapView.venuesMapView.showAnnotations(venueAnnotations, animated: true)
    }
    
    let mapView = MapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mapView)
        mapView.venueSearchbBar.delegate = self
        mapView.locationSearchBar.delegate = self
        mapView.venuesCollectionView.dataSource = self
        mapView.venuesCollectionView.delegate = self
        mapView.venuesMapView.delegate = self
        
        let _ = LocationService.manager.checkForLocationServices()
        configureNavigationBar()
    }
    
    func configureNavigationBar() {
        guard let mapViewNavBar = navigationController else { return }
        mapViewNavBar.navigationBar.barTintColor = UIColor.groupTableViewBackground
        navigationItem.titleView = mapView.venueSearchbBar
        let showVenuesTableViewBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "tableView"), style: .plain, target: self, action: #selector(showVenuesTableView))
        self.navigationItem.rightBarButtonItem = showVenuesTableViewBarButton
        
    }
    
    @objc func showVenuesTableView() {
        // TODO: segue to list of venues in table view
    }
    
}

extension MapViewController: MKMapViewDelegate {
    
    
}

extension MapViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // TODO: implement delegate methods
        //mapView.venuesCollectionView.isHidden = false
        

        guard let locationText = mapView.locationSearchBar.text else { return }
        guard let locationTextEncoded = locationText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        guard let venueText = mapView.venueSearchbBar.text else { return }
        guard let venueTextEncoded = venueText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }

        
        VenueAPIClient.manager.getVenues(near: locationTextEncoded, with: venueTextEncoded, completionHandler: {
            self.mapView.venuesMapView.removeAnnotations(self.mapView.venuesMapView.annotations)
            self.venues.removeAll()
            self.venueAnnotations.removeAll()
            self.venues = $0
        }, errorHandler: { print($0) })
        searchBar.resignFirstResponder()
    }
    
}

extension MapViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return venues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let venueCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Venue Cell", for: indexPath) as! VenueCollectionViewCell
        let selectedVenue = venues[indexPath.row]
        venueCell.venueImageView.image = #imageLiteral(resourceName: "placeholderImage")
        VenueImageAPIClient.manager.getVenueImage(with: selectedVenue.id, completionHandler: {
            ImageAPIClient.manager.getImage(with: $0, completionHandler: {
                venueCell.venueImageView.image = $0
                venueCell.venueImageView.setNeedsLayout()
            }, errorHandler: { print($0) })
        }, errorHandler: { print($0) })
        return venueCell
    }
    
}

extension MapViewController: UICollectionViewDelegate { }

extension MapViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewHeight = mapView.venuesCollectionView.bounds.height
        return CGSize(width: collectionViewHeight * 0.9, height: collectionViewHeight * 0.9)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: cellSpacing, left: cellSpacing, bottom: cellSpacing, right: cellSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
}
