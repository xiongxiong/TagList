//
//  Tag.swift
//  TagList
//
//  Created by 王继荣 on 14/12/2016.
//  Copyright © 2016 wonderbear. All rights reserved.
//

import UIKit

protocol TagDescriptable {
    
    var tagContent: String { get }
}

protocol TagDelegate: NSObjectProtocol {
    
    func tagActionTriggered(action: String, tagContent: String)
}

open class Tag: UIView, TagDescriptable {

    public weak var delegate: TagDelegate?
    
    var tagContent: String = "" {
        didSet {
            tagControl.setContent(content: tagContent)
        }
    }
    var wrappers: [TagWrapper] = [] {
        didSet {
            wrappers.forEach { (wrapper) in
                wrapper.delegate = self
                wrapped = wrapper.wrap
            }
        }
    }
    var padding: UIEdgeInsets = UIEdgeInsets.zero
    var margin: UIEdgeInsets = UIEdgeInsets.zero
    
    var tagControl: TagControl = TagControl() {
        didSet {
            
        }
    }
    var wrapped: TagWrapper!
    
    override var intrinsicContentSize: CGSize {
        let size = wrapped.intrinsicContentSize
        return CGSize(width: size.width + padding.left + padding.right, height: size.height + padding.top + padding.bottom)
    }
    
    init(content: String) {
        self.tagContent = content
        super.init(frame: CGRect.zero)
        
        tagControl = CustomTag(content: content)
        wrapped = wrappers.reduce(tagControl, { (result, wrapper) -> UIView in
            wrapper.wrap(target: result)
        })
        
        addSubview(wrapped)
        wrapped.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: wrapped, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: padding.left))
        addConstraint(NSLayoutConstraint(item: wrapped, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: padding.right * -1))
        addConstraint(NSLayoutConstraint(item: wrapped, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: padding.top))
        addConstraint(NSLayoutConstraint(item: wrapped, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: padding.bottom * -1))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Tag: TagActionDelegate {
    
    func tagActionTriggered(action: String) {
        <#code#>
    }
}
