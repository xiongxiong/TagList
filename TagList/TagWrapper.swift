//
//  Accessory.swift
//  TagList
//
//  Created by 王继荣 on 13/12/2016.
//  Copyright © 2016 wonderbear. All rights reserved.
//

import UIKit

protocol TagWrapperDelegate: TagActionable, TagActionDelegate, TagStatable, TagStateDelegate {
    
//    func wrap<T : UIView>(target: inout T) -> TagWrapper where T: TagActionable, T : TagStatable
    func wrap(target: TagContent) -> TagWrapper
    func wrap(wrapper: TagWrapper) -> TagWrapper
}

extension TagWrapperDelegate {
    
    public func tagActionTriggered(action: TagAction) {
        actionDelegate?.tagActionTriggered(action: action)
    }
    
    public func tagStateDidChange(state: UIControlState) {
        stateDelegate?.tagStateDidChange(state: state)
    }
}

open class TagWrapper: UIView, TagWrapperDelegate {
    
    public weak var actionDelegate: TagActionDelegate?
    public weak var stateDelegate: TagStateDelegate?
    
    var target: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        isUserInteractionEnabled = false
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override var intrinsicContentSize: CGSize {
        return target?.intrinsicContentSize ?? CGSize.zero
    }
    
//    public func wrap<T: UIView>(target: inout T) -> TagWrapper where T: TagActionable, T : TagStatable {
//        self.target = target
//        target.actionDelegate = self
//        target.stateDelegate = self
//        
//        subviews.forEach { (view) in
//            view.removeFromSuperview()
//        }
//        arrangeViews(target: target)
//        
//        return self
//    }
    
    func wrap(target: TagContent) -> TagWrapper {
        self.target = target
        actionDelegate = target
        target.stateDelegate = self
        
        subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        arrangeViews(target: target)
        
        return self
    }
    
    func wrap(wrapper: TagWrapper) -> TagWrapper {
        self.target = wrapper
        actionDelegate = wrapper
        wrapper.stateDelegate = self
        
        subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        arrangeViews(target: wrapper)
        
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
