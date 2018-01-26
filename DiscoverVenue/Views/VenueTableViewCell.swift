//
//  VenueTableViewCell.swift
//  DiscoverVenue
//
//  Created by Caroline Cruz on 1/22/18.
//  Copyright © 2018 Luis Calle. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class VenueTableViewCell: UITableViewCell {
    
    private var venueImageAPIClient: VenueImageAPIClient!
    
    //    ImageView
    lazy var venueImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .gray
        return imageView
    }()
    
    //    NameLabel
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Venue"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.numberOfLines = 0
        label.textColor = .black
        
        return label
    }()
    
    //    RatingLabel
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Rating"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
       
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
        backgroundColor = UIColor.groupTableViewBackground
        setupViews()
    }
    
    override func layoutSubviews() {
        //    we get the frame of the UI element here
        super.layoutSubviews()
        venueImageView.layer.cornerRadius = 35//venueImageView.bounds.width/2.0
        venueImageView.layer.masksToBounds = true // so it will not bleed outside the bounds
    }
    
    private func setupViews() {
        setupVenueImage()
        setupNameLabel()
        setupRatingLabel()
        
    }
    
    private func setupVenueImage() {
        self.addSubview(venueImageView)
        venueImageView.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(snp.centerY)
            make.height.width.equalTo(snp.height)
            make.leading.equalTo(snp.leading).offset(10)
        }
    }
    
    private func setupNameLabel() {
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(venueImageView.snp.trailing).offset(10)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-10)
            make.centerY.equalTo(safeAreaLayoutGuide.snp.centerY)
        }
        
    }
    
    private func setupRatingLabel() {
        addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.leading.equalTo(venueImageView.snp.trailing).offset(10)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-10)
        }
    }
    
    public func configureCell(venue: Venue, venueImageAPIClient: VenueImageAPIClient) {
        nameLabel.text = venue.name
        if venue.categories.isEmpty {
            categoryLabel.text = "Unknown category"
        } else {
            categoryLabel.text = venue.categories[0].name
        }

        self.venueImageAPIClient = venueImageAPIClient
        self.venueImageAPIClient.delegate = self
        self.venueImageView.kf.indicatorType = .activity
        self.venueImageAPIClient.getVenueImage(with: venue)

    }
}

extension VenueTableViewCell: VenueImageAPIClientDelegate {
    func venueImageAPIClientService(_ venueImageAPIClient: VenueImageAPIClient, didReceiveVenueImageURL url: URL?, venue: Venue, image: UIImage?) {
        
        if image != nil {
            venueImageView.image = image
            return
        }
        
        guard let url = url else {
            venueImageView.image = #imageLiteral(resourceName: "placeholder")
            return
        }
        
        venueImageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "placeholder"), options: nil, progressBlock: nil) { (image, error, cacheType, url) in
            guard let image = image else { return }
            NSCacheHelper.manager.addImage(with: venue.id, and: image)
        }
    }
    
    
}
