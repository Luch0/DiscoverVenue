//
//  SearchResultDetailViewController.swift
//  DiscoverVenue
//
//  Created by Luis Calle on 1/19/18.
//  Copyright © 2018 Luis Calle. All rights reserved.
//
import SnapKit
import MapKit

class SearchResultDetailViewController: UIViewController {
    
    let myView = SearchResultDetailView()
    
    private var venue: Venue!
    private var venueImage: UIImage!
    private var savedVenue: SavedVenue!
    
    public func sendSavedVenue(savedVenue: SavedVenue) {
        self.savedVenue = savedVenue
    }
    
    private var longPressGesture = UILongPressGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        view.backgroundColor = UIColor.groupTableViewBackground
        myView.directionsButton.addTarget(self, action: #selector(openAppleMaps), for: .touchUpInside)
        view.addSubview(myView)
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressGestureHandler))
        myView.detailedImageView.isUserInteractionEnabled = true
        myView.detailedImageView.addGestureRecognizer(longPressGesture)
    }
    
    
    @objc func longPressGestureHandler(recognizer:UIPinchGestureRecognizer){
        switch recognizer.state {
        case .began:
            UIView.animate(withDuration: 0.05,
                           animations: {
                            self.myView.detailedImageView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            },
                           completion: nil)
        case .ended:
            UIView.animate(withDuration: 0.05) {
                self.myView.detailedImageView.transform = CGAffineTransform.identity
            }
        default: break
        }
    }
    
    @objc private func openAppleMaps() {
//        guard let latAndLong = venue.location.labeledLatLngs else {
//            // alert controller there is no lat and long
//            return
//        }
        
        if LocationService.manager.checkForLocationServices() == .denied {
            guard let validSettings: URL = URL(string: UIApplicationOpenSettingsURLString) else { return }
            UIApplication.shared.open(validSettings, options: [:], completionHandler: nil)
            return
        }
        
        
        let userCoordinate = CLLocationCoordinate2D(latitude: LocationService.manager.getCurrentLatitude()!, longitude: LocationService.manager.getCurrentLongitude()!)
        let placeCoordinate = CLLocationCoordinate2D(latitude: venue.location.lat, longitude: venue.location.lng)
        let directionsURLString = "http://maps.apple.com/?saddr=\(userCoordinate.latitude),\(userCoordinate.longitude)&daddr=\(placeCoordinate.latitude),\(placeCoordinate.longitude)"
        
        UIApplication.shared.open(URL(string: directionsURLString)!, options: [:]) { (done) in
            print("launched apple maps")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // prevent from navbar to grow large
        navigationItem.largeTitleDisplayMode = .never
    }
    
    init(venue: Venue, image: UIImage, savedVenue: SavedVenue?) {
        super.init(nibName: nil, bundle: nil)
        self.venue = venue
        self.venueImage = image
        self.savedVenue = savedVenue
        if savedVenue == nil {
            myView.configureDetails(venue: venue, image: image)
        } else {
            myView.configureDetailsFromSaved(savedVenue: savedVenue!)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureNavBar() {
        let addBarItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addVenueButton))
        navigationItem.rightBarButtonItem = addBarItem
    }
    
    @objc private func addVenueButton() {
        print("add button pressed")
        let addVenueVC = AddVenueViewController()
        addVenueVC.venueToSendToDVC(venue: venue, image: venueImage)
        
        //create nav controller as its root
        let navController = UINavigationController(rootViewController:addVenueVC )
        addVenueVC.modalTransitionStyle = .crossDissolve
        addVenueVC.modalPresentationStyle = .currentContext
        
        //present nav controller instead for nav bar
        present(navController, animated: true, completion: nil)
        
    }
    
}
