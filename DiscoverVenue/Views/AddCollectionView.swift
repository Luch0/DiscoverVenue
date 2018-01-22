//
//  AddCollectionView.swift
//  DiscoverVenue
//
//  Created by Luis Calle on 1/19/18.
//  Copyright © 2018 Luis Calle. All rights reserved.
//

import UIKit

class AddCollectionView: UIView {

    //TextField
    lazy var textField: UITextField = {
        let tField = UITextField()
        tField.backgroundColor = UIColor(red: 0.918, green: 0.918, blue: 0.918, alpha: 1.00)
        tField.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        tField.textAlignment = .center
        tField.placeholder = "Enter a New Collection Title"
        tField.attributedPlaceholder = NSAttributedString(string: "Enter a New Collection Title", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 0.918, green: 0.918, blue: 0.918, alpha: 1.00)])
        tField.keyboardType = .default
        tField.keyboardAppearance = .dark
        tField.backgroundColor = UIColor(red: 0.141, green: 0.149, blue: 0.184, alpha: 1.00)
        tField.textColor = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.00)
        tField.borderStyle = .bezel
        tField.textColor = .white
        return tField
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
    
    private func setupBlurEffectView() {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light) // .light, .dark, .prominent, .regular, .extraLight
        let visualEffect = UIVisualEffectView(frame: UIScreen.main.bounds)
        visualEffect.effect = blurEffect
        addSubview(visualEffect)
    }
    
    private func setupViews() {
        setupBlurEffectView()
        addSubview(textField)
        
        textField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.09)
        }
        
    }


}
