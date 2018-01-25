//
//  SearchResultDetailViewController.swift
//  DiscoverVenue
//
//  Created by Luis Calle on 1/19/18.
//  Copyright © 2018 Luis Calle. All rights reserved.
//
import SnapKit

class SearchResultDetailViewController: UIViewController {
    
    let myView = SearchResultDetailView()
    
    var venue: Venue!
    var venueImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        view.backgroundColor = .yellow
        view.addSubview(myView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // prevent from navbar to grow large
        navigationItem.largeTitleDisplayMode = .never
    }
    
    init(venue: Venue, image: UIImage) {
        super.init(nibName: nil, bundle: nil)
        self.venue = venue
        self.venueImage = image
        myView.configureDetails(venue: venue, image: image)
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
