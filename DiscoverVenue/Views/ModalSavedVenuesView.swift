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
        label.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        label.text = "Venues in Collection"
        label.backgroundColor = .clear
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        //create and register a cell
        tv.register(VenueTableViewCell.self, forCellReuseIdentifier: "VenueTableViewCell")
        tv.backgroundColor = UIColor.groupTableViewBackground
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
        backgroundColor = UIColor.groupTableViewBackground
        
        setupViews()
    }
    
    private func setupBlurEffectView() {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light) // .light, .dark, .prominent, .regular, .extraLight
        let visualEffect = UIVisualEffectView(frame: UIScreen.main.bounds)
        visualEffect.effect = blurEffect
        addSubview(visualEffect)
    }
    
    private func setupViews() {
        setupBlurEffectView()
        addSubview(topLabel)
        addSubview(tableView)
        
        topLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(1)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(10)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-10)
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.09)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(topLabel.snp.bottom)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
        }
        
    }
    
}
