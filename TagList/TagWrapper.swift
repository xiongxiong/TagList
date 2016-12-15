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
    
    @discardableResult
    public func wrap<T: UIView>(target: T) -> TagWrapper where T: TagStateDelegate {
        self.target = target
        target.stateDelegate = self
        
        removeConstraints(constraints)
        addSubview(target)
        target.translatesAutoresizingMaskIntoConstraints = false
        
        return self
    }
}

extension TagWrapper: TagStateDelegate {

    public func stateDidChange(state: UIControlState) {
        stateDelegate?.stateDidChange(state: state)
    }
}

open class TagWrapperRemover: TagWrapper {
    
    let deleteButton = UIButton()
    var space: CGFloat = 8
    
    open override var intrinsicContentSize: CGSize {
        let targetSize = target?.intrinsicContentSize ?? CGSize.zero
        return CGSize(width: targetSize.width + space + targetSize.height, height: targetSize.height)
    }
    
    init() {
        super.init(frame: CGRect.zero)
        
        addSubview(deleteButton)
        deleteButton.contentMode = .scaleAspectFit
        deleteButton.setImage(#imageLiteral(resourceName: "icon_delete"), for: .normal)
        deleteButton.addTarget(self, action: #selector(didRemove), for: .touchUpInside)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func wrap<T : UIView>(target: T) -> TagWrapper where T : TagStateDelegate {
        super.wrap(target: target)
        
        addConstraint(NSLayoutConstraint(item: target, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: target, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: deleteButton, attribute: .leading, relatedBy: .equal, toItem: target, attribute: .trailing, multiplier: 1, constant: space))
        addConstraint(NSLayoutConstraint(item: deleteButton, attribute: .width, relatedBy: .equal, toItem: target, attribute: .height, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: deleteButton, attribute: .centerY, relatedBy: .equal, toItem: target, attribute: .centerY, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: deleteButton, attribute: .height, relatedBy: .equal, toItem: target, attribute: .height, multiplier: 1, constant: 0))
        
        return self
    }
    
    func didRemove() {
        delegate?.tagActionTriggered(action: "remove")
    }
}
