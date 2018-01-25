//
//  SearchResultsTableViewController.swift
//  DiscoverVenue
//
//  Created by Caroline Cruz on 1/22/18.
//  Copyright © 2018 Luis Calle. All rights reserved.
//
import UIKit
import GameplayKit

class SearchResultsTableViewController: UIViewController {
    
    private let venueView = SearchResultsTableView()
    private var tableViewVenues = [Venue]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        view.addSubview(venueView)
        configureNavBar()
        //        setup delegate and datasource
        venueView.tableView.dataSource = self
        venueView.tableView.delegate = self
    }
    
    init(venues: [Venue]) {
        super.init(nibName: nil, bundle: nil)
        self.tableViewVenues = venues
        
//        venueView.configureDetailView(fellow: fellow, image: image)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureNavBar() {
        navigationItem.title = "Result List"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
}

extension SearchResultsTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewVenues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VenueCell", for: indexPath) as! VenueTableViewCell
        //        TODO: we will be passing a venue Object here
//                    let venue = venues[indexPath.row]
//                    cell.congfigureCell(venue: venue)
        let selectedVenue = tableViewVenues[indexPath.row]
        //cell.nameLabel.text = selectedVenue.name
        let venueImageAPIClient = VenueImageAPIClient()
        cell.configureCell(venue: selectedVenue, venueImageAPIClient: venueImageAPIClient)
        //cell.venueImageView.image = #imageLiteral(resourceName: "placeholderImage")
        return cell
    }
}

extension SearchResultsTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        TODO: use dependency injection to pass Venue Model Object to dvc
//                    let venue = venues[indexPath.row]
        let cell = tableView.cellForRow(at: indexPath) as! VenueTableViewCell
        //            var cellImage: UIImage!
        //            if let image = cell.venueImageView.image {
        //                cellImage = image
        //            } else {
        //                cellImage = UIImage(named:"placeholder-image")
        //            }
        cell.nameLabel.text = "Hello"
        cell.ratingLabel.text = "Good"
        
//        let dvc = SearchResultDetailViewController()//(venue: venue, image: cellImage )
//        //        the way the modal comes on the screen
//        dvc.modalTransitionStyle = .crossDissolve
//        dvc.modalPresentationStyle = .overCurrentContext
//        present(dvc, animated: true, completion: nil)
        
//        let SRDVC = SearchResultDetailViewController()
//        //create nav controller as its root
//        let navController = UINavigationController(rootViewController:SRDVC)
//        SRDVC.modalTransitionStyle = .crossDissolve
//        SRDVC.modalPresentationStyle = .currentContext
        guard let image = cell.venueImageView.image else { return }
        let SRDVC = SearchResultDetailViewController(venue: tableViewVenues[indexPath.row], image: image)
        self.navigationController?.pushViewController(SRDVC, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160.0
    }
}
