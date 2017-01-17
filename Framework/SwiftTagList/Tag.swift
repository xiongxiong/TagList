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

open class Tag: UIView {

    weak var delegate: TagDelegate?
    weak var stateDelegate: TagStateDelegate?
    
    public private(set) var content: TagPresentable
    public var wrappers: [TagWrapper] = [] {
        didSet {
            update()
        }
    }
    public var padding: UIEdgeInsets = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3) {
        didSet {
            update()
        }
    }
    public var enableSelect: Bool = true {
        didSet {
            update()
        }
    }
    public var isSelected: Bool {
        get {
            return content.isSelected
        }
        set {
            if isSelected != newValue {
                content.isSelected = newValue
                onSelect?(self)
                update()
            }
        }
    }
    
    private var tagContent: TagContent!
    private var wrapped: TagWrapper!
    private var tapGestureRecognizer: UITapGestureRecognizer!
    private var onSelect: ((Tag) -> Void)?
    
    open override var intrinsicContentSize: CGSize {
        let size = wrapped.intrinsicContentSize
        return CGSize(width: size.width + padding.left + padding.right, height: size.height + padding.top + padding.bottom)
    }
    
    public init(content: TagPresentable, onInit: ((Tag) -> Void)? = nil, onSelect: ((Tag) -> Void)? = nil) {
        self.content = content
        self.onSelect = onSelect
        super.init(frame: CGRect.zero)
        onInit?(self)
        
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTap))
        addGestureRecognizer(tapGestureRecognizer)
        tapGestureRecognizer.numberOfTapsRequired = 1
        
        clipsToBounds = true
        update()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update() {
        subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        
        tagContent = content.createTagContent()
        tagContent.actionDelegate = self
        stateDelegate = tagContent
        
        stateDelegate?.tagSelected(isSelected)
        wrapped = TagWrapper().wrap(target: tagContent)
        wrapped = wrappers.reduce(wrapped) { (result, element) in
            element.wrap(wrapper: result)
        }
        
        addSubview(wrapped)
        wrapped.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: wrapped, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: wrapped, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        delegate?.tagUpdated()
    }
    
    func onTap() {
        if enableSelect {
            isSelected = !isSelected
        } else {
            isSelected = false
        }
        tagActionTriggered(action: .tap)
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
