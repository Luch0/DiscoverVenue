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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // prevent from navbar to grow large when going back to mapview
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        mapView.venueSearchbBar.resignFirstResponder()
        mapView.locationSearchBar.resignFirstResponder()
    }
    
    func configureNavigationBar() {
        guard let mapViewNavBar = navigationController else { return }
        mapViewNavBar.navigationBar.barTintColor = UIColor.groupTableViewBackground
        navigationItem.titleView = mapView.venueSearchbBar
        let showVenuesTableViewBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "tableView"), style: .plain, target: self, action: #selector(showVenuesTableView))
        self.navigationItem.rightBarButtonItem = showVenuesTableViewBarButton
        
    }
    
    @objc func showVenuesTableView() {
        let tableViewResults = SearchResultsTableViewController()
        self.navigationController?.pushViewController(tableViewResults, animated: true)
    }
    
    private func showAlertController(with title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
    }
    
}

extension MapViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        mapView.locationSearchBar.placeholder = "Enter location"
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // TODO: implement delegate methods
        //mapView.venuesCollectionView.isHidden = false
        
        guard let venueText = mapView.venueSearchbBar.text else { return }
        if venueText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            showAlertController(with: "Error", message: "Must enter a venue to search")
            searchBar.text = ""
            return
        }
        guard let venueTextEncoded = venueText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        
        guard let locationText = mapView.locationSearchBar.text else { return }
        var locationTextEncoded: String?
        if locationText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            locationTextEncoded = "Queens, NY".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            mapView.locationSearchBar.placeholder = "Queens, NY"
        } else {
            locationTextEncoded = locationText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        }
        guard let locationTextUnwrapped = locationTextEncoded else { return }
        VenueAPIClient.manager.getVenues(near: locationTextUnwrapped, with: venueTextEncoded, completionHandler: {
            self.venues.removeAll()
            self.venueAnnotations.removeAll()
            self.mapView.venuesMapView.removeAnnotations(self.mapView.venuesMapView.annotations)
            self.venues = $0
        }, errorHandler: {
            print($0)
            self.showAlertController(with: "Error", message: "No results found")
        })
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
