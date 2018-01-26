//
//  UserCreatedCollectionsViewController.swift
//  DiscoverAVenue
//
//  Created by Richard Crichlow on 1/18/18.
//  Copyright © 2018 Caroline Cruz. All rights reserved.
//

import UIKit

class UserCreatedCollectionsViewController: UIViewController {
    
    private let userCreatedCollectionsView = UserCreatedCollectionsView()
    private let cellSpacing: CGFloat =  5.0
    
    private var venuesCollectionArray = [VenuesCollections]() {
        didSet {
            userCreatedCollectionsView.collectionView.reloadData()
            //FileManagerHelper.manager
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        //venuesCollectionArray =  FileManagerHelper.manager.getVenuesCollectionsArr()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userCreatedCollectionsView.collectionView.reloadData()
        setUpView()
        venuesCollectionArray =  FileManagerHelper.manager.getVenuesCollectionsArr()
    }
    
    private func setUpView() {
        navigationItem.title = "My Collections"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
        //Add Initial View
        view.addSubview(userCreatedCollectionsView)
        
        //Set Up Delegates
        userCreatedCollectionsView.collectionView.delegate = self
        userCreatedCollectionsView.collectionView.dataSource = self
    }
    
    
    
    @objc private func addTapped() {
        // Present AddCollectionViewController
        print("Present AddCollectionViewController")
        
        let addCollectionVC = AddCollectionViewController()
        
        let addCollectionViewWithNavController = UINavigationController(rootViewController: addCollectionVC)
        
        addCollectionViewWithNavController.modalTransitionStyle = .coverVertical
        addCollectionViewWithNavController.modalPresentationStyle = .overCurrentContext // This presents the view and keeps the tab bar
        
        //addCollectionViewWithNavController.modalPresentationStyle = .overfullScreen // This covers the tabs at the bottom of the screen
        present(addCollectionViewWithNavController,animated: true, completion: nil)
        
        
    }
    
    
    
}
extension UserCreatedCollectionsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("The Collection View for IndexPath: \(indexPath.row) should pop up now")
        
        // identify a specific collection
        let aSpecificCollection = venuesCollectionArray[indexPath.row]
        
        // using dependency injection to pass Data Object into Venue Collection View Controller
        let modalSavedVenuesVC = ModalSavedVenuesViewController()
        
        let mSVVCinNavCon = UINavigationController(rootViewController: modalSavedVenuesVC)
        
        modalSavedVenuesVC.modalTransitionStyle = .crossDissolve
        modalSavedVenuesVC.modalPresentationStyle = .overCurrentContext
        present(mSVVCinNavCon, animated: true, completion: nil)
        
        //func to configure view on VC
        modalSavedVenuesVC.configureSavedVenueVC(aSpecificCollection: aSpecificCollection)
        
    }
    
}
extension UserCreatedCollectionsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        var numOfSections: Int = 0
        if venuesCollectionArray.count > 0 {
            userCreatedCollectionsView.collectionView.backgroundView = nil
            numOfSections = 1
        } else {
            let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: userCreatedCollectionsView.collectionView.bounds.size.width, height: userCreatedCollectionsView.collectionView.bounds.size.height))
            noDataLabel.text = "No Collections Yet"
            noDataLabel.font = UIFont.systemFont(ofSize: 22, weight: .medium)
            noDataLabel.textAlignment = .center
            userCreatedCollectionsView.collectionView.backgroundView = noDataLabel
        }
        return numOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return venuesCollectionArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionsCustomCollectionViewCell", for: indexPath) as! CollectionsCustomCollectionViewCell
        
        let aCollection = venuesCollectionArray[indexPath.row]
        
        //cell.spinner.isHidden = false
        //cell.spinner.startAnimating()
        cell.collectionImageView.image = #imageLiteral(resourceName: "placeholder") //Placeholder
        
        if let latestVenue = aCollection.savedVenues.last {
            cell.collectionImageView.image = FileManagerHelper.manager.getImage(with: latestVenue.id)
        } else {
            cell.collectionImageView.image = #imageLiteral(resourceName: "placeholder") //Placeholder
        }
        
        cell.collectionNameLabel.text = aCollection.collectionName
        
        
        return cell
    }
    
    
}
extension UserCreatedCollectionsViewController: UICollectionViewDelegateFlowLayout {
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


