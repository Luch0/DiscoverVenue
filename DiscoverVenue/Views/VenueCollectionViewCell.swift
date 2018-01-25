//
//  VenueCollectionViewCell.swift
//  DiscoverVenue
//
//  Created by Luis Calle on 1/19/18.
//  Copyright © 2018 Luis Calle. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class VenueCollectionViewCell: UICollectionViewCell {
    
    private var venueImageAPIClient: VenueImageAPIClient!
    
    lazy var venueImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "placeholder")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10
        layer.masksToBounds = true
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
        setupVenueImageView()
    }
    
    private func setupVenueImageView() {
        addSubview(venueImageView)
        venueImageView.snp.makeConstraints{ (make) -> Void in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    public func configureVenueCell(venue: Venue, venueImageAPIClient : VenueImageAPIClient) {
        self.venueImageAPIClient = venueImageAPIClient
        self.venueImageAPIClient.delegate = self
        self.venueImageAPIClient.getVenueImage(with: venue)
    }
    
}

extension VenueCollectionViewCell: VenueImageAPIClientDelegate {
    
    func venueImageAPIClientService(_ venueImageAPIClient: VenueImageAPIClient, didReceiveVenueImageURL url: URL?, venue: Venue) {
        venueImageView.kf.indicatorType = .activity
        guard let url = url else {
            venueImageView.image = #imageLiteral(resourceName: "placeholder")
            return
        }
        
//        if ImageCache.default.imageCachedType(forKey: venue.id).cached {
//            ImageCache.default.retrieveImage(forKey: venue.id, options: nil) {
//                image, cacheType in
//                if let image = image {
//                    print("Get image \(image), cacheType: \(cacheType). IN VENUES COLLECTION")
//                    //In this code snippet, the `cacheType` is .disk
//                    self.venueImageView.image = image
//                } else {
//                    print("Not exist in cache.")
//                }
//            }
//        }
        
        
        
        
        //let resource = ImageResource(downloadURL: url, cacheKey: "\(venue.id)")
        venueImageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "placeholder"), options: nil, progressBlock: nil) { (image, error, cacheType, url) in
        }
    }

}
