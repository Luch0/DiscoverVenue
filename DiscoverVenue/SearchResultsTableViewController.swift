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
    
    let venueView = SearchResultsTableView()
    var venues = [Venue]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        view.addSubview(venueView)
        
        //        setup delegate and datasource
        venueView.tableView.dataSource = self
        venueView.tableView.delegate = self
    }
}

extension SearchResultsTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VenueCell", for: indexPath) as! VenueTableViewCell
        //        TODO: we will be passing a venue Object here
        //            let venue = venues[indexPath.row]
        //            cell.congfigureCell(venue: venue)
        cell.nameLabel.text = "Hello"
        cell.venueImageView.image = #imageLiteral(resourceName: "placeholder")
        return cell
    }
}

extension SearchResultsTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        TODO: use dependency injection to pass Venue Model Object to dvc
        //            let venue = venues[indexPath.row]
        let cell = tableView.cellForRow(at: indexPath) as! VenueTableViewCell
        //            var cellImage: UIImage!
        //            if let image = cell.venueImageView.image {
        //                cellImage = image
        //            } else {
        //                cellImage = UIImage(named:"placeholder-image")
        //            }
        cell.nameLabel.text = "Hello"
        cell.ratingLabel.text = "Good"
        
        let dvc = SearchResultsDetailViewController()//(venue: venue, image: cellImage )
        //        the way the modal comes on the screen
        dvc.modalTransitionStyle = .crossDissolve
        dvc.modalPresentationStyle = .overCurrentContext
        present(dvc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160.0
    }
}

