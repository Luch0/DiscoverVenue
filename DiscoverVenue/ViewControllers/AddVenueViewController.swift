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
    
    var oneVenue: Venue!
    var oneImage: UIImage!
    
    func venueToSendToDVC(venue: Venue, image: UIImage) {
        self.oneVenue = venue
        self.oneImage = image
    }
    
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
    
    @objc private func xButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func createButton() {
        
        let savedVenue = SavedVenue(id: oneVenue.id, venue: oneVenue, tip: addVenueView.tipTextField.text, imageURL: oneVenue.id)
        
        FileManagerHelper.manager.saveImage(with: oneVenue.id, image: oneImage)
        
        if addVenueView.collectionTextField.text != "" {
            FileManagerHelper.manager.addVenueToANewCollection(collectionName: addVenueView.collectionTextField.text!, venueToSave: savedVenue, and: nil)
            
        }
        
        let alert = UIAlertController(title: "Saved to Collection", message: "(venue) was saved to (collection title)", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: {(UIAlertAction) -> Void in self.dismiss(animated: true, completion: nil)})
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
       
    }
    
    //TODO: modal vc but tab bar controller is not underneath
    
    
    
}
extension AddVenueViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("The Collection View for IndexPath: \(indexPath.row) should pop up now")
        
        
        let savedVenue = SavedVenue(id: oneVenue.id, venue: oneVenue, tip: addVenueView.tipTextField.text, imageURL: oneVenue.id)
        
        if addVenueView.collectionTextField.text == "" {
            FileManagerHelper.manager.saveImage(with: oneVenue.id, image: oneImage)
            FileManagerHelper.manager.addVenueToAnExistingCollection(index: indexPath.row, venueToSave: savedVenue)
            
            let alert = UIAlertController(title: "Saved to Collection", message: "(venue) was saved to (collection title)", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .default, handler: {(UIAlertAction) -> Void in self.dismiss(animated: true, completion: nil)})
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }

    }
    
}
extension AddVenueViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return FileManagerHelper.manager.getVenuesCollectionsArr().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionsCustomCollectionViewCell", for: indexPath) as! CollectionsCustomCollectionViewCell
        
        //cell.spinner.isHidden = false
        //cell.spinner.startAnimating()
        
        
        if let id =  FileManagerHelper.manager.getVenuesCollectionsArr()[indexPath.row].savedVenues.first?.id {
            
            cell.collectionImageView.image = FileManagerHelper.manager.getImage(with: id)
            cell.collectionNameLabel.text = FileManagerHelper.manager.getVenuesCollectionsArr()[indexPath.row].collectionName
        } else {
            cell.collectionImageView.image = #imageLiteral(resourceName: "placeholder")
            cell.collectionNameLabel.text = ""
        }
        
        
        
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
