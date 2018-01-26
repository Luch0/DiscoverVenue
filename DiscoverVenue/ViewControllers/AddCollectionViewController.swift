//
//  AddCollectionViewController.swift
//  DiscoverAVenue
//
//  Created by Richard Crichlow on 1/18/18.
//  Copyright © 2018 Caroline Cruz. All rights reserved.
//

import UIKit

protocol RefreshFromModalSaveDelegate {
    func viewRemovedRefreshNowPlease()
}

class AddCollectionViewController: UIViewController {
    
    var refreshDelegate: RefreshFromModalSaveDelegate?
    
    private let addCollectionView = AddCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(addCollectionView)
        addCollectionView.textField.delegate = self
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .clear
        
        // Title
        navigationItem.title = "Add To Or Create Collection"
        
        // Left Bar Button
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButton))
        
        // Right Bar Button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create", style: .done, target: self, action: #selector(createCollection))
        
        
    }
    
    @ objc private func createCollection() {
        if addCollectionView.textField.text == "" {
            print("Textfield was empty")
            
            let alert = UIAlertController(title: "Error", message: "Please enter text to save a New Collection", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Got it", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            print("Collection Created")
            
            // Add Collection to UserCreatedCollectionsView Data Array
            let newCollection: VenuesCollections = VenuesCollections(collection: addCollectionView.textField.text!, savedVenues: [])
            
            FileManagerHelper.manager.addAVenueCollection(venueCollection: newCollection)
            
            
            // The easiest way to do this is to add it directly to the File Manager and have the UCCVC get the data from the FileManager in it's viewDidpperar function
            let alert = UIAlertController(title: "New Collection Saved", message: "\(addCollectionView.textField.text ?? "Unnamed Collection") was saved to Collections", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: {
                
                self.refreshDelegate?.viewRemovedRefreshNowPlease()
                self.dismiss(animated: true, completion: nil)
                
            })
        }
    }
    
    @ objc private func cancelButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}

extension AddCollectionViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //create Keyboard upon textfield being selected
        textField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("Enter was Pressed")
        createCollection()
        guard textField.text != "" else {return true}
        
        
        
        textField.resignFirstResponder()
        return true
    }
    
    
}

