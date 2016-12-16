//
//  SeparatorWrapper.swift
//  TagList
//
//  Created by 王继荣 on 15/12/2016.
//  Copyright © 2016 wonderbear. All rights reserved.
//

import UIKit

public class SeparatorWrapper: UIView {
    
    var target: UIView?
    var separator: UIView = UIView()
    var separatorMargin: UIEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 15)
    
    open override var intrinsicContentSize: CGSize {
        let targetSize = target?.intrinsicContentSize ?? CGSize.zero
        return CGSize(width: targetSize.width + separator.frame.width + separatorMargin.left + separatorMargin.right, height: max(targetSize.height, separator.frame.height + separatorMargin.top + separatorMargin.bottom))
    }
    
    func wrap(_ view: UIView) -> UIView {
        addSubview(view)
        addSubview(separator)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
        
        separator.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: separator, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: separatorMargin.left))
        addConstraint(NSLayoutConstraint(item: separator, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0))
        
        return self
    }
}
