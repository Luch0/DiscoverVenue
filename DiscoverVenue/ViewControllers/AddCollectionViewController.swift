//
//  AddCollectionViewController.swift
//  DiscoverAVenue
//
//  Created by Richard Crichlow on 1/18/18.
//  Copyright © 2018 Caroline Cruz. All rights reserved.
//

import UIKit

class AddCollectionViewController: UIViewController {
    
    let addCollectionView = AddCollectionView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(addCollectionView)
        addCollectionView.textField.delegate = self
        setupView()
    }
    
    func setupView() {
        view.backgroundColor = .clear
        
        // Title
        navigationItem.title = "Add To Or Create Collection"
        
        // Left Bar Button
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButton))
        
        // Right Bar Button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create", style: .done, target: self, action: #selector(createCollection))
        
        
    }
    
    @ objc func createCollection() {
        print("Collection Created")
        // Add Collection to UserCreatedCollectionsView Data Array
    }
    
    @ objc func cancelButton() {
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
        guard let text = textField.text else {return true}
        
        
        
        textField.resignFirstResponder()
        return true
    }
    
    
}

