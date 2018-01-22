//
//  SearchResultDetailViewController.swift
//  DiscoverVenue
//
//  Created by Luis Calle on 1/19/18.
//  Copyright © 2018 Luis Calle. All rights reserved.
//

import SnapKit

class SearchResultDetailedViewController: UIViewController {
    
    let myView = SearchResultDetailedView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        view.backgroundColor = .yellow
        view.addSubview(myView)
    }
    
    func configureNavBar() {
        let addBarItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addVenueButton))
        navigationItem.rightBarButtonItem = addBarItem
    }
    
    @objc func addVenueButton() {
        print("add button pressed")
        let addVenueVC = AddVenueViewController()
        //create nav controller as its root
        let navController = UINavigationController(rootViewController:addVenueVC )
        addVenueVC.modalTransitionStyle = .crossDissolve
        addVenueVC.modalPresentationStyle = .currentContext
        
        //present nav controller instead for nav bar
        present(navController, animated: true, completion: nil)
        
    }
    
}
