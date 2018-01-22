//
//  UserCreatedCollectionsView.swift
//  DiscoverVenue
//
//  Created by Luis Calle on 1/19/18.
//  Copyright © 2018 Luis Calle. All rights reserved.
//

import UIKit

class UserCreatedCollectionsView: UIView {
    
    // Collection View
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: frame, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        cv.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.00)
        
        // Register CollectionViewCell
        cv.register(CollectionsCustomCollectionViewCell.self, forCellWithReuseIdentifier: "CollectionsCustomCollectionViewCell")
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .purple
        
        setupViews()
    }
    
    private func setupViews() {
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(self.safeAreaLayoutGuide).inset(UIEdgeInsetsMake(0, 0, 0, 0))
        }
    }
    
    
}
