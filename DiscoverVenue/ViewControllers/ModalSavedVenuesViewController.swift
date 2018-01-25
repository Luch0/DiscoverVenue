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
    
    let modalSavedVenuesView = ModalSavedVenuesView()
    
    var sampleCityArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    
    var aVenueCollection = [SavedVenue]() {
        didSet {
            modalSavedVenuesView.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(modalSavedVenuesView)
        modalSavedVenuesView.tableView.delegate = self
        modalSavedVenuesView.tableView.dataSource = self
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
        view.backgroundColor = .purple
        
        // Left Bar Button
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "◀ Back", style: .done, target: self, action: #selector(backButton))
        //navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back"), style: .done, target: self, action: #selector(backButton))
        
    }
    
    @ objc func backButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    

}
extension ModalSavedVenuesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected IndexPath: \(indexPath)")
        //Segue to venueView here
        
        // TODO: Needs to call singleton from file manager to load savedVenues collections
        //let SRDVC = SearchResultDetailViewController()
        //self.navigationController?.pushViewController(SRDVC, animated: true)
        
//        let DetailVC = ModalSavedVenuesViewController()
//
//        let mSVVCinNavCon = UINavigationController(rootViewController: DetailVC)
//
//        DetailVC.modalTransitionStyle = .crossDissolve
//        DetailVC.modalPresentationStyle = .overCurrentContext
//        present(mSVVCinNavCon, animated: true, completion: nil)
    }
    
}

extension ModalSavedVenuesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aVenueCollection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "VenueTableViewCell", for: indexPath) as? VenueTableViewCell else {return UITableViewCell()}
        
        let aVenue = aVenueCollection[indexPath.row]
        
        cell.textLabel?.text = "\(aVenue.id)"
        
        if aVenue.imageURL != nil {
            //set image based of aVenue.imageURL here
            //cell.collectionImageView.image = aVenue.imageURL
        } else {
            cell.imageView?.image = #imageLiteral(resourceName: "placeholder") //Placeholder
        }
        
        return cell
        
        
    }
    
    
}

