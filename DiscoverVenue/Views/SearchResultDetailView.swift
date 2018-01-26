//
//  SearchResultDetailView.swift
//  DiscoverVenue
//
//  Created by Luis Calle on 1/19/18.
//  Copyright © 2018 Luis Calle. All rights reserved.
//
import UIKit

import SnapKit

class SearchResultDetailView: UIView {

    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Placeholder text"
        label.font = UIFont.systemFont(ofSize: 40, weight: UIFont.Weight(rawValue: 250))
        //label.backgroundColor = .red
        return label
    }()
    
    lazy var detailedImageView: UIImageView = {
        let iv = UIImageView()
        //iv.backgroundColor = .blue
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    lazy var restaurantTypelabel: UILabel = {
        let label = UILabel()
        label.text = "Placeholder text"
        label.font = UIFont.systemFont(ofSize: 20)
        //label.backgroundColor = .green
        return label
    }()
    
    lazy var tiplabel: UILabel = {
        let label = UILabel()
        label.text = "Tips are great for the community"
        label.font = UIFont.systemFont(ofSize: 20)
        //label.backgroundColor = .red
        return label
    }()
    
    lazy var directionsButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.blue, for: .normal)
        return button
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
        backgroundColor = UIColor.groupTableViewBackground
        setupViews()
    }
    
    //    override func layoutSubviews() {
    //        self.snp.makeConstraints{(make) -> Void in
    //            make.height.equalTo(self.snp.height).multipliedBy(0.8)
    //            }
    //        }
    
    private func setupViews() {
        setupLabel()
        setupImageView()
        //setupSpinner()
        setupRestaurantTypeLabel()
        setupTipLabel()
        setupDirectionsButton()
    }
    
    func setupLabel() {
        addSubview(label)
        label.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.width.equalToSuperview().multipliedBy(1)
            make.centerX.equalToSuperview().multipliedBy(1)
            
        }
        
    }
    
    func setupImageView() {
        addSubview(detailedImageView)
        detailedImageView.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(label.snp.bottom).multipliedBy(1)
            make.width.equalTo(safeAreaLayoutGuide.snp.width)
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.64)
        }
    }
    
    func setupRestaurantTypeLabel() {
        addSubview(restaurantTypelabel)
        restaurantTypelabel.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(detailedImageView.snp.bottom)
            make.width.equalTo(safeAreaLayoutGuide.snp.width)
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.07)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
        }
    }
    
    func setupTipLabel() {
        addSubview(tiplabel)
        tiplabel.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(restaurantTypelabel.snp.bottom)
            make.width.equalTo(safeAreaLayoutGuide.snp.width)
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.07)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
        }
    }
    
    func setupDirectionsButton() {
        addSubview(directionsButton)
        directionsButton.snp.makeConstraints { (make) in
            make.top.equalTo(tiplabel.snp.bottom)
            make.width.equalTo(safeAreaLayoutGuide.snp.width)
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.07)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func configureDetails(venue: Venue, image: UIImage) {
        self.label.text = venue.name
        self.restaurantTypelabel.text = venue.categories[0].name
        self.detailedImageView.kf.indicatorType = .activity
        self.detailedImageView.image = image
        guard let address = venue.location.address else {
           self.directionsButton.setTitle("No address available", for: .normal)
            return
        }
        self.directionsButton.setTitle("\(address)", for: .normal)
    }
    
}

