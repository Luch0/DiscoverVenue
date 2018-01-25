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
        // imageView.image = #imageLiteral(resourceName: "placeholder")
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
        self.venueImageView.kf.indicatorType = .activity
        self.venueImageAPIClient.getVenueImage(with: venue)
    }
    
}

extension VenueCollectionViewCell: VenueImageAPIClientDelegate {
    
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
