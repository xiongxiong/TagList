//
//  ViewController.swift
//  TagList
//
//  Created by 王继荣 on 13/12/2016.
//  Copyright © 2016 wonderbear. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var container = Container()
    var button = UIButton()
    
    var i = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(container)
        view.addSubview(button)
        
        container.backgroundColor = UIColor.gray
        container.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraint(NSLayoutConstraint(item: container, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0))
//        view.addConstraint(NSLayoutConstraint(item: container, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: container, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0))
//        view.addConstraint(NSLayoutConstraint(item: container, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 40))
        
        button.setTitle("Click Click Click", for: .normal)
        button.backgroundColor = UIColor.blue
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(onClick), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraint(NSLayoutConstraint(item: button, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: button, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: button, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 50))
    }

    func onClick() {
        container.addLabel()
        
        i += 1
        container.setNeedsLayout()
        container.layoutIfNeeded()
    }
}

class Container: UIView {
    
    var labels: [UILabel] = []
    
//    override var intrinsicContentSize: CGSize {
//        return labels.reduce(CGSize.zero) { result, label in
//            let width = result.width + label.intrinsicContentSize.width
//            let height: CGFloat = 40
//            return CGSize(width: width, height: height)
//        }
//    }
    
    func addLabel() {
        let label = UILabel()
        label.text = " Hello "
//        label.frame = CGRect(x: 0, y: 0, width: 80, height: 40)
        label.textColor = UIColor.red
        label.backgroundColor = UIColor.yellow
        
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        if let last = labels.last {
            addConstraint(NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal, toItem: last, attribute: .trailing, multiplier: 1, constant: 0))
        } else {
            addConstraint(NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0))
        }
        addConstraint(NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        labels.append(label)
        print("addLabel... \(label.frame)")
//        invalidateIntrinsicContentSize()
//        setNeedsLayout()
//        layoutIfNeeded()
    }
}

