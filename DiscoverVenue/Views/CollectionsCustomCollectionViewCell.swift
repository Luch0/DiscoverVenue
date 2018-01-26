//
//  CollectionsCustomCollectionViewCell.swift
//  DiscoverVenue
//
//  Created by Richard Crichlow on 1/20/18.
//  Copyright © 2018 Luis Calle. All rights reserved.
//

import UIKit
import SnapKit

class CollectionsCustomCollectionViewCell: UICollectionViewCell {
    
    // ImageView
    lazy var collectionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "placeholder")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    // Name Label
    lazy var collectionNameLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.textAlignment = .center
        label.backgroundColor = .white
        label.textColor = .black
        return label
    }()
    
    // Spinner
    lazy var spinner: UIActivityIndicatorView = {
        let sp = UIActivityIndicatorView()
        sp.activityIndicatorViewStyle = .gray
        //sp.isHidden = true // Make visible directly before the IMAGE API call for the cell
        sp.hidesWhenStopped = true // Automatically goes invisible when it stops
        if sp.isHidden == false {
            sp.startAnimating()
        }
        
        return sp
    }()
    
    // Plus Sign Image View
    lazy var plusSignImageView: UIImageView = {
        let plusSign = UIImageView()
        plusSign.image = #imageLiteral(resourceName: "plus")
        plusSign.contentMode = .scaleAspectFit
        plusSign.isHidden = true //Starts off hidden
        return plusSign
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        setupViews()
        
    }
    
    private func setupViews() {
        addSubview(collectionImageView)
        addSubview(collectionNameLabel)
        addSubview(spinner)
        addSubview(plusSignImageView)
        setupVenueImageView()
        
    }
    
    private func setupVenueImageView() {
        
        collectionImageView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top)
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
            make.height.equalTo(self.snp.height)
        }
        
        collectionNameLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(collectionImageView.snp.bottom)
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
            make.height.equalTo(self.snp.height).multipliedBy(0.15)
        }
        
        spinner.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(collectionImageView.snp.center)
            make.edges.equalTo(collectionImageView.snp.edges)
        }
        
        plusSignImageView.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(collectionImageView.snp.center)
            make.height.equalTo(collectionImageView.snp.height).multipliedBy(0.5)
            make.width.equalTo(collectionImageView.snp.width).multipliedBy(0.5)
        }
        
    }
    
    
    
    
}
