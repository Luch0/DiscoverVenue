//
//  LaunchScreen.swift
//  DiscoverVenue
//
//  Created by Richard Crichlow on 1/24/18.
//  Copyright © 2018 Luis Calle. All rights reserved.
//

import UIKit

import UIKit

protocol LaunchViewDelegate {
    func animationEnded()
}


class LaunchScreen: UIView {
    
    var delegate: LaunchViewDelegate?
    
    //Three labels
    
    lazy var byLabel: UILabel = {
        let label  = UILabel()
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.text = "By"
        return label
    }()
    
    lazy var weatherLabel: UILabel = {
        let label  = UILabel()
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.text = "Designed"
        return label
    }()
    
    lazy var stringLabel: UILabel = {
        let label  = UILabel()
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.text = "PlaceHolder_Name"
        return label
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
        setupAndConstrainObjects()
        animateView()
    }
    
    private func setupAndConstrainObjects() {
        
        // ARRAY MUST BE ON ORDER
        let launchViewObjects = [byLabel, weatherLabel, stringLabel] as [UIView]
        
        launchViewObjects.forEach{addSubview($0); ($0).translatesAutoresizingMaskIntoConstraints = false}
        
        NSLayoutConstraint.activate([
            
            // By Label
            byLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            byLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 11),
            
            // Weather Label
            weatherLabel.bottomAnchor.constraint(equalTo: byLabel.topAnchor, constant: -5),
            weatherLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            
            // String Label
            stringLabel.topAnchor.constraint(equalTo: byLabel.bottomAnchor, constant: 5),
            stringLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
            
            ])
    }
    
    private func animateView() {
        
        UIView.animate(withDuration: 3.0, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.5, options: [.curveLinear], animations: {
            
            self.weatherLabel.frame = self.weatherLabel.frame.offsetBy(dx: 0, dy: 500)
            self.byLabel.frame = self.byLabel.frame.offsetBy(dx: 0, dy: 500)
            self.stringLabel.frame = self.stringLabel.frame.offsetBy(dx: 0, dy: 500)
            
        }) { (success:Bool) in
            if success {
                //Fade the entire view out
                UIView.animate(withDuration: 3.0, animations: {
                    self.backgroundColor = .clear
                    self.weatherLabel.layer.opacity = 0
                    self.byLabel.layer.opacity = 0
                    self.stringLabel.layer.opacity = 0
                    
                }) {(success) in
                    self.delegate?.animationEnded()
                    
                }
            }
        }
    }
}
