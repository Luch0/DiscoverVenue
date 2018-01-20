//
//  MapView.swift
//  DiscoverVenue
//
//  Created by Luis Calle on 1/19/18.
//  Copyright © 2018 Luis Calle. All rights reserved.
//

import UIKit
import MapKit
import SnapKit

class MapView: UIView {
    
    lazy var venueSearchbBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for venue"
        return searchBar
    }()
    
    lazy var locationSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.barTintColor = UIColor.groupTableViewBackground
        searchBar.placeholder = "Enter location"
        return searchBar
    }()
    
    lazy var venuesMapView: MKMapView = {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        return mapView
    }()
    
    lazy var venuesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(VenueCollectionViewCell.self, forCellWithReuseIdentifier: "Venue Cell")
        //collectionView.isHidden = true
        return collectionView
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
        backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        setupLocationSearchBar()
        setupVenuesMapView()
        setupVenuesCollectionView()
    }
    
    private func setupLocationSearchBar() {
        addSubview(locationSearchBar)
        locationSearchBar.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.width.equalTo(safeAreaLayoutGuide.snp.width)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
        }
    }
    
    private func setupVenuesMapView() {
        addSubview(venuesMapView)
        venuesMapView.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(locationSearchBar.snp.bottom)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func setupVenuesCollectionView() {
        addSubview(venuesCollectionView)
        venuesCollectionView.snp.makeConstraints{ (make) -> Void in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.width.equalTo(safeAreaLayoutGuide.snp.width)
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.2)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
        }
    }
    
}
