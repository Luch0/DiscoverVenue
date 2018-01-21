//
//  ModalSavedVenuesView.swift
//  DiscoverAVenue
//
//  Created by Richard Crichlow on 1/20/18.
//  Copyright © 2018 Caroline Cruz. All rights reserved.
//

import UIKit

class ModalSavedVenuesView: UIView {
    
    lazy var topLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        label.text = "Venues in Collection"
        label.backgroundColor = .clear
        label.textColor = UIColor(red: 0.559, green: 0.559, blue: 0.559, alpha: 1.00)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var venueTableView: UITableView = {
        let tv = UITableView()
        //create and register a cell
        tv.register(VenueTableViewCell.self, forCellReuseIdentifier: "VenueTableViewCell")
        tv.backgroundColor = .gray
        return tv
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
        //setupBlurEffectView()
        setupViews()
    }
    
    private func setupBlurEffectView() {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark) // .light, .dark, .prominent, .regular, .extraLight
        let visualEffect = UIVisualEffectView(frame: UIScreen.main.bounds)
        visualEffect.effect = blurEffect
        addSubview(visualEffect)
    }
    
    private func setupViews() {
        setupBlurEffectView()
        addSubview(topLabel)
        addSubview(venueTableView)
        
        topLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(1)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(10)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-10)
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.09)
        }
        
        venueTableView.snp.makeConstraints { (make) in
            make.top.equalTo(topLabel.snp.bottom)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
        }
        
        
    }
    
    //Func to set up modalSavedVenuesView when called
    public func configureSavedVenueView(testArray: [String]) {
        //self.testArray = testArray
    }
    
}

