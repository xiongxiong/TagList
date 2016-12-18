//
//  Tag.swift
//  TagList
//
//  Created by 王继荣 on 14/12/2016.
//  Copyright © 2016 wonderbear. All rights reserved.
//

import UIKit

protocol TagDelegate: NSObjectProtocol {
    
    func tagUpdated()
    func tagActionTriggered(tag: Tag, action: TagAction)
}

open class Tag: UIControl {

    weak var delegate: TagDelegate?
    public weak var stateDelegate: TagStateDelegate?
    
    public var content: TagPresentable {
        didSet {
            update()
        }
    }
    public var type: TagContent.Type {
        didSet {
            update()
        }
    }
    public var wrappers: [TagWrapper] = [] {
        didSet {
            update()
        }
    }
    public var padding: UIEdgeInsets = UIEdgeInsets.zero {
        didSet {
            update()
        }
    }
    
    private var tagContent: TagContent!
    private var wrapped: TagWrapper!
    
    open override var isEnabled: Bool {
        didSet {
            tagStateDidChange()
        }
    }
    
    open override var isSelected: Bool {
        didSet {
            tagStateDidChange()
        }
    }
    
    open override var isHighlighted: Bool {
        didSet {
            tagStateDidChange()
        }
    }
    
    open override var intrinsicContentSize: CGSize {
        let size = wrapped.intrinsicContentSize
        return CGSize(width: size.width + padding.left + padding.right, height: size.height + padding.top + padding.bottom)
    }
    
    init(content: TagPresentable, type: TagContent.Type, wrappers: [TagWrapper] = [], padding: UIEdgeInsets = UIEdgeInsets.zero) {
        self.content = content
        self.type = type
        self.wrappers = wrappers
        self.padding = padding
        super.init(frame: CGRect.zero)
        
        clipsToBounds = true
        addTarget(self, action: #selector(onTap), for: .touchUpInside)
        update()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func onTap() {
        tagActionTriggered(action: .tap)
    }
    
    func update() {
        subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        
        tagContent = type.init(content: content)
        tagContent.actionDelegate = self
        stateDelegate = tagContent
        wrapped = TagWrapper().wrap(target: tagContent)
        wrapped = wrappers.reduce(wrapped) { (result, element) in
            element.wrap(wrapper: result)
        }
        
        addSubview(wrapped)
        wrapped.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: wrapped, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: wrapped, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        tagStateDidChange()
    }
    
    public func tagStateDidChange() {
        delegate?.tagUpdated()
        stateDelegate?.tagStateDidChange(state: state)
    }
}

extension Tag: TagActionDelegate {
    
    public func tagActionTriggered(action: TagAction) {
        delegate?.tagActionTriggered(tag: self, action: action)
    }
}

public enum TagAction {
    
    case tap
    case remove
    case custom(action: String)
}
