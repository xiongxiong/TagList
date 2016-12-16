//
//  Accessory.swift
//  TagList
//
//  Created by 王继荣 on 13/12/2016.
//  Copyright © 2016 wonderbear. All rights reserved.
//

import UIKit

protocol TagWrapperDelegate {
    
    var delegate: TagActionDelegate? { get set }
    var stateDelegate: TagStateDelegate? { get set }
    
    func wrap<T : UIView>(target: T) -> TagWrapper where T : TagStateDelegate
}

open class TagWrapper: UIView, TagWrapperDelegate {
    
    public weak var delegate: TagActionDelegate?
    public weak var stateDelegate: TagStateDelegate?
    
    var target: UIView?
    
    open override var intrinsicContentSize: CGSize {
        return target?.intrinsicContentSize ?? CGSize.zero
    }
    
    @discardableResult
    public func wrap<T: UIView>(target: T) -> TagWrapper where T: TagStateDelegate {
        self.target = target
        target.stateDelegate = self
        
        subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        arrangeViews(target: target)
        
        return self
    }
    
    func arrangeViews<T: UIView>(target: T) {
        addSubview(target)
        target.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: target, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: target, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: target, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: target, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
    }
}

extension TagWrapper: TagStateDelegate {

    public func stateDidChange(state: UIControlState) {
        stateDelegate?.stateDidChange(state: state)
    }
}
