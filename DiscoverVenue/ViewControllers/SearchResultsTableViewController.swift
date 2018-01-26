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
        //view.backgroundColor = .yellow
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if tableViewVenues.count > 0 {
            venueView.tableView.backgroundView = nil
            venueView.tableView.separatorStyle = .singleLine
            numOfSections = 1
        } else {
            let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: venueView.tableView.bounds.size.width, height: venueView.tableView.bounds.size.height))
            noDataLabel.text = "No Results Yet"
            noDataLabel.font = UIFont.systemFont(ofSize: 22, weight: .medium)
            noDataLabel.textAlignment = .center
            venueView.tableView.backgroundView = noDataLabel
            venueView.tableView.separatorStyle = .none
        }
        return numOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewVenues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VenueCell", for: indexPath) as! VenueTableViewCell
        // we will be passing a venue Object here
        let selectedVenue = tableViewVenues[indexPath.row]
        let venueImageAPIClient = VenueImageAPIClient()
        cell.configureCell(venue: selectedVenue, venueImageAPIClient: venueImageAPIClient)
        return cell
    }
}

extension SearchResultsTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // use dependency injection to pass Venue Model Object to dvc
        
        let cell = tableView.cellForRow(at: indexPath) as! VenueTableViewCell
        guard let image = cell.venueImageView.image else { return }
        let SRDVC = SearchResultDetailViewController(venue: tableViewVenues[indexPath.row], image: image, savedVenue: nil)
        self.navigationController?.pushViewController(SRDVC, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
}
