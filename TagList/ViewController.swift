//
//  ViewController.swift
//  TagList
//
//  Created by 王继荣 on 13/12/2016.
//  Copyright © 2016 wonderbear. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var big = UIControl()
    var small = UIControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(big)
        big.addSubview(small)
        
        big.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        big.addTarget(self, action: #selector(clickBig), for: .touchUpInside)
        big.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraint(NSLayoutConstraint(item: big, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: big, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 200))
        view.addConstraint(NSLayoutConstraint(item: big, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: big, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 200))
        
        small.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
        small.addTarget(self, action: #selector(clickSmall), for: .touchUpInside)
        small.translatesAutoresizingMaskIntoConstraints = false
        big.addConstraint(NSLayoutConstraint(item: small, attribute: .centerX, relatedBy: .equal, toItem: big, attribute: .centerX, multiplier: 1, constant: 0))
        big.addConstraint(NSLayoutConstraint(item: small, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 100))
        big.addConstraint(NSLayoutConstraint(item: small, attribute: .centerY, relatedBy: .equal, toItem: big, attribute: .centerY, multiplier: 1, constant: 0))
        big.addConstraint(NSLayoutConstraint(item: small, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 100))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func clickBig() {
        print("\n --------- big clicked")
    }
    
    func clickSmall() {
        print("\n --------- small clicked")
    }
}

