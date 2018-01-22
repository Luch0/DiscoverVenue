//
//  SearchResultsTableView.swift
//  
//
//  Created by Caroline Cruz on 1/22/18.
//

import UIKit
import SnapKit

class SearchResultsTableView: UIView {
    
    //    TableView
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.register(VenueTableViewCell.self, forCellReuseIdentifier: "VenueCell")
        tv.backgroundColor = .orange
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
        backgroundColor = .black
        setupViews()
    }
    
    private func setupViews() {
        setupTableView()
    }
    
    private func setupTableView() {
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
}


