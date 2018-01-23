//
//  VenueTableViewCell.swift
//  DiscoverVenue
//
//  Created by Caroline Cruz on 1/22/18.
//  Copyright © 2018 Luis Calle. All rights reserved.
//


import UIKit
import SnapKit

class VenueTableViewCell: UITableViewCell {
    
    //    ImageView
    lazy var venueImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .red
        return imageView
    }()
    
    //    Activiy Indicator
    lazy var spinner: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView()
        ai.color = .white
        return ai
    }()
    
    //    NameLabel
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Venue"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.textColor = .white
        label.backgroundColor = .black
        return label
    }()
    
    //    RatingLabel
    lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "Rating"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        label.backgroundColor = .black
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: "VenueCell")
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .black
        setupViews()
    }
    
    override func layoutSubviews() {
        //    we get the frame of the UI element here
        super.layoutSubviews()
        venueImageView.layer.cornerRadius = venueImageView.bounds.width/2.0
        venueImageView.layer.masksToBounds = true // so it will not bleed outside the bounds
    }
    
    private func setupViews() {
        setupSpinner()
        setupVenueImage()
        setupNameLabel()
        setupRatingLabel()
        
    }
    
    private func setupVenueImage() {
        self.addSubview(venueImageView)
        venueImageView.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(self.safeAreaLayoutGuide.snp.centerY)
            make.height.equalTo(safeAreaLayoutGuide.snp.height)
            make.width.equalTo(venueImageView.snp.height)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(10)
        }
    }
    
    private func setupSpinner() {
        addSubview(spinner)
        spinner.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(venueImageView.snp.centerY)
            make.centerX.equalTo(venueImageView.snp.centerX)
        }
    }
    
    private func setupNameLabel() {
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(venueImageView.snp.trailing)
            make.centerY.equalTo(self.safeAreaLayoutGuide.snp.centerY)
        }
        
    }
    
    private func setupRatingLabel() {
        addSubview(ratingLabel)
        ratingLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.leading.equalTo(venueImageView.snp.trailing)
            
        }
    }
}

