//
//  Tag.swift
//  TagList
//
//  Created by 王继荣 on 14/12/2016.
//  Copyright © 2016 wonderbear. All rights reserved.
//

import UIKit

public protocol TagDelegate: NSObjectProtocol {
    
    func tagActionTriggered(action: String, content: TagPresentable)
}

open class Tag: UIView {

    public weak var delegate: TagDelegate?
    
    public var wrappers: [TagWrapper] = []
    public var padding: UIEdgeInsets = UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 10)
    
    private(set) var content: TagPresentable
    private var tagControl: TagControl!
    private var wrapped: TagWrapper!
    
    open override var intrinsicContentSize: CGSize {
        let size = wrapped.intrinsicContentSize
        return CGSize(width: size.width + padding.left + padding.right, height: size.height + padding.top + padding.bottom)
    }
    
    init(content: TagPresentable, type: TagControl.Type) {
        self.content = content
        super.init(frame: CGRect.zero)
        
        tagControl = type.init(content: content)
        wrapped = TagWrapper().wrap(target: tagControl)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func layoutSubviews() {
        updateContent()
        
        super.layoutSubviews()
    }
    
    public func updateContent() {
        wrapped.removeFromSuperview()
        
        wrapped = wrappers.reduce(wrapped) { (result, wrapper) in
            wrapper.wrap(target: wrapped)
        }
        
        addSubview(wrapped)
        wrapped.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: wrapped, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: padding.left))
        addConstraint(NSLayoutConstraint(item: wrapped, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: padding.right * -1))
        addConstraint(NSLayoutConstraint(item: wrapped, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: padding.top))
        addConstraint(NSLayoutConstraint(item: wrapped, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: padding.bottom * -1))
    }
}

extension Tag: TagActionDelegate {
    
    public func tagActionTriggered(action: String) {
        delegate?.tagActionTriggered(action: action, content: content)
    }
}
