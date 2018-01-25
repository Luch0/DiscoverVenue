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
    
    //let aVenue : Venue!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        view.backgroundColor = .yellow
        view.addSubview(myView)
    }
    
    private func configureNavBar() {
        let addBarItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addVenueButton))
        navigationItem.rightBarButtonItem = addBarItem
    }
    
    @objc private func addVenueButton() {
        print("add button pressed")
        let addVenueVC = AddVenueViewController()
        //addVenueVC.venueToSendToDVC(venue: aVenue)
        
        //create nav controller as its root
        let navController = UINavigationController(rootViewController:addVenueVC )
        addVenueVC.modalTransitionStyle = .crossDissolve
        addVenueVC.modalPresentationStyle = .currentContext
        
        //present nav controller instead for nav bar
        present(navController, animated: true, completion: nil)
        
    }
    
}
