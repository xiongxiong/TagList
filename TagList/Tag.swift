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
    
    public var type: TagControl.Type
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
        self.type = type
        super.init(frame: CGRect.zero)
        
        tagControl = type.init(content: content)
        tagControl.delegate = self
        
        wrapped = TagWrapper().wrap(target: tagControl)
        wrapped = wrappers.reduce(wrapped) { (result, element) in
            element.wrap(target: result)
        }
        
        addSubview(wrapped)
        wrapped.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: wrapped, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: wrapped, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Tag: TagActionDelegate {
    
    public func tagActionTriggered(action: String) {
        delegate?.tagActionTriggered(action: action, content: content)
    }
}
