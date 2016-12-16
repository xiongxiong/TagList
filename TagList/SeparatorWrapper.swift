//
//  info.swift
//  TagList
//
//  Created by 王继荣 on 15/12/2016.
//  Copyright © 2016 wonderbear. All rights reserved.
//

import UIKit

public class SeparatorWrapper: UIView {
    
    var info: SeparatorInfo
    var target: UIView?
    
    public init(info: SeparatorInfo) {
        self.info = info
        super.init(frame: CGRect.zero)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override var intrinsicContentSize: CGSize {
        let targetSize = target?.intrinsicContentSize ?? CGSize.zero
        return CGSize(width: targetSize.width + info.size.width + info.margin.left + info.margin.right, height: targetSize.height)
    }
    
    public func wrap(_ target: UIView) -> UIView {
        self.target = target
        
        subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        arrangeViews(target: target)
        
        return self
    }
    
    func arrangeViews(target: UIView) {
        addSubview(target)
        let view = UIImageView(image: info.icon)
        addSubview(view)
        
        target.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: target, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: target, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: target, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
        
        view.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: target, attribute: .trailing, multiplier: 1, constant: info.margin.left))
        addConstraint(NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: info.size.width))
        addConstraint(NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: target, attribute: .centerY, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: info.size.height))
        addConstraint(NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: info.margin.right * -1))
    }
}

public struct SeparatorInfo {
    
    var icon: UIImage = UIImage()
    var size: CGSize = CGSize.zero
    var margin: UIEdgeInsets = UIEdgeInsets.zero
}
