//
//  UserCreatedCollectionsViewController.swift
//  DiscoverAVenue
//
//  Created by Richard Crichlow on 1/18/18.
//  Copyright © 2018 Caroline Cruz. All rights reserved.
//

import UIKit

class UserCreatedCollectionsViewController: UIViewController {
    
    let userCreatedCollectionsView = UserCreatedCollectionsView()
    let cellSpacing: CGFloat =  5.0
    
    var sampleTestArray = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpView()
    }
    
    func setUpView() {
        view.backgroundColor = .purple
        navigationItem.title = "My Collections"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
        //Add Initial View
        view.addSubview(userCreatedCollectionsView)
        
        //Set Up Delegates
        userCreatedCollectionsView.collectionView.delegate = self
        userCreatedCollectionsView.collectionView.dataSource = self
    }
    
    
    
    @objc func addTapped() {
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
         //let aSpecificCollection = UserCollections[indexPath.row]
         
         // using dependency injection to pass Data Object into Venue Collection View Controller
         let modalSavedVenuesVC = ModalSavedVenuesViewController()
        
        let mSVVCinNavCon = UINavigationController(rootViewController: modalSavedVenuesVC)
         
         modalSavedVenuesVC.modalTransitionStyle = .crossDissolve
         modalSavedVenuesVC.modalPresentationStyle = .overCurrentContext
         present(mSVVCinNavCon, animated: true, completion: nil)
         
         //func to configure view on VC
        modalSavedVenuesVC.configureSavedVenueVC(testArray: sampleTestArray)
        
    }
    
}
extension UserCreatedCollectionsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return sampleTestArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionsCustomCollectionViewCell", for: indexPath) as! CollectionsCustomCollectionViewCell
        
        let name = sampleTestArray[indexPath.row]
        
        //cell.spinner.isHidden = false
        //cell.spinner.startAnimating()
        cell.collectionImageView.image = #imageLiteral(resourceName: "placeholder")
        cell.collectionNameLabel.text = "IndexPath : \(indexPath.row)"
        
        
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


