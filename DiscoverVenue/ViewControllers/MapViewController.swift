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
import Kingfisher
import Alamofire

class MapViewController: UIViewController {
    
    private let cellSpacing: CGFloat = 5.0
    
    private var firstTime = true // only zoom in to location at app start
    
    private var currentVenue: Venue!
    
    private var venues = [Venue]() {
        didSet {
            mapView.venuesCollectionView.reloadData()
            mapView.venuesCollectionView.setContentOffset(CGPoint.zero, animated: true)
            addVenueAnnotations()
        }
    }
    
    private var venueAnnotations = [MKAnnotation]()
    
    private func addVenueAnnotations() {
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
    
    private let mapView = MapView()
    
    private var venueAPIclient: VenueAPIClient!
    
    init(venueAPIclient: VenueAPIClient) {
        super.init(nibName: nil, bundle: nil)
        self.venueAPIclient = venueAPIclient
        self.venueAPIclient.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let launchScreen = LaunchScreen()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mapView)
        view.addSubview(launchScreen)
        
        navigationController?.navigationBar.alpha = 0.0
        tabBarController?.tabBar.alpha = 0.0
        
        UIView.animate(withDuration: 2.0, delay: 2.0, animations: {
            
            self.navigationController?.navigationBar.alpha = 1.0
            self.tabBarController?.tabBar.alpha = 1.0
            
        })
        
        launchScreen.delegate = self
        if let lastSearchedVenue = UserDefaultsHelper.manager.getLastSearchedVenue() {
            mapView.venueSearchbBar.placeholder = lastSearchedVenue
        } else {
            mapView.venueSearchbBar.placeholder = "Search for a Venue"
        }
        
        if let lastSearchedLocation = UserDefaultsHelper.manager.getLastSearchedLocation() {
            mapView.locationSearchBar.placeholder = lastSearchedLocation
        } else {
            mapView.locationSearchBar.placeholder = "Search for a Location"
        }
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
    
    private func configureNavigationBar() {
        guard let mapViewNavBar = navigationController else { return }
        mapViewNavBar.navigationBar.barTintColor = UIColor.groupTableViewBackground
        navigationItem.titleView = mapView.venueSearchbBar
        let showVenuesTableViewBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "tableView"), style: .plain, target: self, action: #selector(showVenuesTableView))
        self.navigationItem.rightBarButtonItem = showVenuesTableViewBarButton
        
    }
    
    @objc private func showVenuesTableView() {
        // pass venues data to SearchResultsTableViewController
        let tableViewResults = SearchResultsTableViewController(venues: venues)
        self.navigationController?.pushViewController(tableViewResults, animated: true)
    }
    
    private func showAlertController(with title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}

extension MapViewController: VenueAPIClientDelegate {

    func VenueAPIClient(_venueAPIClient: VenueAPIClient, didReceiveVenues venues: [Venue]?) {
        mapView.venuesCollectionView.isHidden = false
        guard let venues = venues else {
            showAlertController(with: "Error", message: "No results found")
            self.venues.removeAll()
            self.venueAnnotations.removeAll()
            self.mapView.venuesMapView.removeAnnotations(self.mapView.venuesMapView.annotations)
            return
        }
        self.venues.removeAll()
        self.venueAnnotations.removeAll()
        self.mapView.venuesMapView.removeAnnotations(self.mapView.venuesMapView.annotations)
        self.venues = venues
    }
    
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        if firstTime {
            let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            mapView.setRegion(region, animated: true)
            firstTime = false
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
    
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "VenueAnnotationView") as? MKMarkerAnnotationView
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "VenueAnnotationView")
            annotationView?.canShowCallout = true
//            let index = venueAnnotations.index{$0 === annotation}
//            if let annotationIndex = index {
//                let selectedVenueAnnotation = venues[annotationIndex]
//                // customize annotation
//            }
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
        
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {

        let index = venueAnnotations.index{ $0 === view.annotation }
        guard let venueAnnotationIndex = index else { print("Index is nil"); return }
        
        currentVenue = venues[venueAnnotationIndex]
        let indexPath = IndexPath(item: venueAnnotationIndex, section: 0)
        self.mapView.venuesCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        // idea: border color for selected cell
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let deatilVC = SearchResultDetailViewController(venue: currentVenue, image: NSCacheHelper.manager.getImage(with: currentVenue.id) ?? #imageLiteral(resourceName: "placeholder"), savedVenue: nil)
        navigationController?.pushViewController(deatilVC, animated: true)
    }
    
}

extension MapViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        mapView.locationSearchBar.placeholder = "Search for a Location"
        mapView.venueSearchbBar.placeholder = "Search for a Venue"
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        mapView.venuesCollectionView.isHidden = false
        
        if !NetworkReachabilityManager()!.isReachable {
            showAlertController(with: "Error", message: "No internet connection")
            searchBar.resignFirstResponder()
            return
        }
        
        guard var venueText = mapView.venueSearchbBar.text else { return }
        
        if venueText.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            mapView.venueSearchbBar.placeholder = "Coffee"
            venueText = "Coffee"
        }
    
        guard let locationText = mapView.locationSearchBar.text else { return }

        var location: String?
        if locationText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            location = "Queens, NY"
            mapView.locationSearchBar.placeholder = "Queens, NY"
        } else {
            location = locationText
        }

        guard let locationUnwrapped = location else { return }
        venueAPIclient.getVenues(near: locationUnwrapped, with: venueText)
        
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
        let venueImageAPIClient = VenueImageAPIClient()
        venueCell.configureVenueCell(venue: selectedVenue, venueImageAPIClient: venueImageAPIClient)
        return venueCell
    }
    
}

extension MapViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let deatilVC = SearchResultDetailViewController(venue: venues[indexPath.row], image: NSCacheHelper.manager.getImage(with: venues[indexPath.row].id) ?? #imageLiteral(resourceName: "placeholder"), savedVenue: nil)
        navigationController?.pushViewController(deatilVC, animated: true)
    }
    
}

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
extension MapViewController: LaunchViewDelegate {
    public func animationEnded() {
        launchScreen.removeFromSuperview()
    }
    
    
}
