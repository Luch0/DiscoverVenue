//
//  AddVenueViewController.swift
//  DiscoverVenue
//
//  Created by Luis Calle on 1/19/18.
//  Copyright © 2018 Luis Calle. All rights reserved.
//
import UIKit

class AddVenueViewController: UIViewController {
    
    let cellSpacing: CGFloat =  5.0
    
    let myView = SearchResultDetailView()
    
    let addVenueView = AddVenueView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(addVenueView)
        configureNavBar()
        addVenueView.collectionView.dataSource = self
        addVenueView.collectionView.delegate = self
    }
    
    private func configureNavBar() {
        let xBarItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(xButton))
        navigationItem.leftBarButtonItem = xBarItem
        xBarItem.style = .done
        
        let createBarItem = UIBarButtonItem(title: "Create", style: .plain , target: self, action: #selector(createButton))
        navigationItem.rightBarButtonItem = createBarItem
        navigationItem.title = "Add to or Create Collection"
        
    }
    
    @objc func xButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func createButton() {
        let alert = UIAlertController(title: "Saved to Collection", message: "(venue) was saved to (collection title)", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
        //TODO: Add creating/saving functionality
    }
    
    //TODO: modal vc but tab bar controller is not underneath
    
    
    
}
extension AddVenueViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("The Collection View for IndexPath: \(indexPath.row) should pop up now")
        
        /*
         // identify a specific collection
         let aSpecificCollection = UserCollections[indexPath.row]
         
         // using dependency injection to pass Data Object into Venue Collection View Controller
         let savedVenueVC = SavedVenueViewController()
         
         savedVenueVC.modalTransitionStyle = .crossDissolve
         savedVenueVC.modalPresentationStyle = .overCurrentContext
         present(savedVenueVC, animated: true, completion: nil)
         
         //func to configure view on VC
         savedVenueVC.savedVenueView.configureDetailView(forecast: aSpecificDay, cityName: cityName)
         */
    }
    
}
extension AddVenueViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionsCustomCollectionViewCell", for: indexPath) as! CollectionsCustomCollectionViewCell
        
        //cell.spinner.isHidden = false
        //cell.spinner.startAnimating()
        cell.collectionImageView.image = #imageLiteral(resourceName: "placeholderImage")
        cell.collectionNameLabel.text = "IndexPath : \(indexPath.row)"
        
        
        return cell
    }
    
    
}
extension AddVenueViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numCells: CGFloat = 3
        let numSpaces: CGFloat = numCells + 1
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        return CGSize(width: (screenWidth - (cellSpacing * numSpaces)) / numCells, height: screenHeight * 0.25)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: cellSpacing, left: cellSpacing, bottom: 0, right: cellSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
}
