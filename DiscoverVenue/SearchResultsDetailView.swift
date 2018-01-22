//
//  SearchResultsDetailView.swift
//  DiscoverVenue
//
//  Created by Caroline Cruz on 1/22/18.
//  Copyright © 2018 Luis Calle. All rights reserved.
//


import UIKit
import SnapKit

class SearchResultDetailView: UIView {
    
    lazy var dismissModalButton: UIButton = {
        let buttton = UIButton(frame: UIScreen.main.bounds)
        buttton.backgroundColor = .clear
        return buttton
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var addButtonInContainerView: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "addIcon"), for: .normal)
        
        return button
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        return label
    }()
    
    lazy var venueImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
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
        backgroundColor = .clear
        setupViews()
    }
    
    override func layoutSubviews() {
        // here you get the actual frame size of the elements before getting laid out on screen
        super.layoutSubviews()
        //        make profile image a circle
        venueImage.layer.cornerRadius = venueImage.bounds.width/2.0
        venueImage.layer.masksToBounds = true
    }
    
    private func setupViews() {
        setupBlurEffectView()
        setupDismissModal()
        setupContainerView()
        setupAddButton()
        setupNameLabel()
        setupVenueImage()
        
        
    }
    private func setupBlurEffectView() {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light) // .light, .dark, .prominent, .regular, .extraLight
        //       UIVisualEffectView is the view you need to create the effect
        let visualEffect = UIVisualEffectView(frame: UIScreen.main.bounds)
        visualEffect.effect = blurEffect
        addSubview(visualEffect)
    }
    
    func setupDismissModal() {
        addSubview(dismissModalButton)
    }
    
    
    func setupContainerView() {
        addSubview(containerView)
        containerView.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(self.snp.width).multipliedBy(0.90)
            make.height.equalTo(self.snp.height).multipliedBy(0.80)
        }
    }
    
    private func setupAddButton() {
        addSubview(addButtonInContainerView)
        addButtonInContainerView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(containerView.snp.top).offset(10)
            make.trailing.equalTo(containerView.snp.trailing).offset(-5)
        }
    }
    
    private func setupNameLabel() {
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(addButtonInContainerView.snp.bottom)
            make.centerX.equalTo(self.snp.centerX)
        }
    }
    
    private func setupVenueImage() {
        addSubview(venueImage)
        venueImage.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(nameLabel.snp.bottom)
            make.width.equalTo(containerView.snp.width).multipliedBy(0.50)
            make.height.equalTo(venueImage.snp.width)
        }
    }
    
    
    
    public func configureDetailView(venue: Venue, image: UIImage) {
        nameLabel.text = venue.name
        venueImage.image = image
    }
}

