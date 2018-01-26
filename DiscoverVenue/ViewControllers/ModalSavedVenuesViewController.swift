//
//  ModalSavedVenuesViewController.swift
//  DiscoverVenue
//
//  Created by Richard Crichlow on 1/20/18.
//  Copyright © 2018 Luis Calle. All rights reserved.
//

import UIKit

class ModalSavedVenuesViewController: UIViewController {
    
    
    
    //Func to set up modalSavedVenuesVC when called
    func configureSavedVenueVC(aSpecificCollection: VenuesCollections) {
        self.aVenueCollection = aSpecificCollection.savedVenues
    }
    
    private let modalSavedVenuesView = ModalSavedVenuesView()
    
    private var aVenueCollection = [SavedVenue]() {
        didSet {
            modalSavedVenuesView.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(modalSavedVenuesView)
        modalSavedVenuesView.tableView.delegate = self
        modalSavedVenuesView.tableView.dataSource = self
        modalSavedVenuesView.tableView.rowHeight = UITableViewAutomaticDimension
        setupView()
        animateTable()
        
        
    }
    
    
    private func animateTable() {
        modalSavedVenuesView.tableView.reloadData()
        let cells = modalSavedVenuesView.tableView.visibleCells
        let tableViewHeight = modalSavedVenuesView.tableView.bounds.size.height
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }
        var delayCounter = 0
        for cell in cells {
            UIView.animate(withDuration: 1.75, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }
    }
    
    private func setupView() {
        view.backgroundColor = UIColor.groupTableViewBackground
        
        // Left Bar Button
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "◀ Back", style: .done, target: self, action: #selector(backButton))
        //navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back"), style: .done, target: self, action: #selector(backButton))
        
    }
    
    @objc private func backButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}
extension ModalSavedVenuesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected IndexPath: \(indexPath)")
        //Segue to venueView here
        
                // use dependency injection to pass Venue Model Object to dvc
                
                let cell = modalSavedVenuesView.tableView.cellForRow(at: indexPath) as! VenueTableViewCell
                guard let image = cell.venueImageView.image else { return }
                let savedVenue = aVenueCollection[indexPath.row]
        let searchResultsDVC = SearchResultDetailViewController(venue: savedVenue.venue, image: image, savedVenue: savedVenue)
                searchResultsDVC.sendSavedVenue(savedVenue: savedVenue)
                self.navigationController?.pushViewController(searchResultsDVC, animated: true)
                searchResultsDVC.myView.configureDetailsFromSaved(savedVenue: savedVenue)
        
            }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
        
        // TODO: Needs to call singleton from file manager to load savedVenues collections
    
        //        let DetailVC = ModalSavedVenuesViewController()
        //
        //        let mSVVCinNavCon = UINavigationController(rootViewController: DetailVC)
        //
        //        DetailVC.modalTransitionStyle = .crossDissolve
        //        DetailVC.modalPresentationStyle = .overCurrentContext
        //        present(mSVVCinNavCon, animated: true, completion: nil)
//    }
    
}

extension ModalSavedVenuesViewController: UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if aVenueCollection.count > 0 {
            modalSavedVenuesView.tableView.backgroundView = nil
            modalSavedVenuesView.tableView.separatorStyle = .singleLine
            numOfSections = 1
        } else {
            let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: modalSavedVenuesView.tableView.bounds.size.width, height: modalSavedVenuesView.tableView.bounds.size.height))
            noDataLabel.text = "No Saved Venues"
            noDataLabel.font = UIFont.systemFont(ofSize: 22, weight: .medium)
            noDataLabel.textAlignment = .center
            modalSavedVenuesView.tableView.backgroundView = noDataLabel
            modalSavedVenuesView.tableView.separatorStyle = .none
        }
        return numOfSections
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aVenueCollection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "VenueTableViewCell", for: indexPath) as? VenueTableViewCell else {return UITableViewCell()}
        
        let aVenue = aVenueCollection[indexPath.row]
        
        //cell.configureCell(venue: aVenue.venue, venueImageAPIClient: nil)
        
        cell.nameLabel.text = "\(aVenue.venue.name)"
        cell.categoryLabel.text = "\(aVenue.tip ?? "Info Unavailable")"
        
        if let savedImage = FileManagerHelper.manager.getImage(with: aVenue.id) {
            cell.venueImageView.image = savedImage
        } else {
            cell.venueImageView.image = #imageLiteral(resourceName: "placeholder")
        }
        return cell
        
    }
    
    
}

