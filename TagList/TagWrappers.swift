//
//  TagWrappers.swift
//  TagList
//
//  Created by 王继荣 on 16/12/2016.
//  Copyright © 2016 wonderbear. All rights reserved.
//

import UIKit

open class TagWrapperRemover: TagWrapper {
    
    let deleteButton = UIButton()
    var space: CGFloat = 8
    
    open override var intrinsicContentSize: CGSize {
        let targetSize = target?.intrinsicContentSize ?? CGSize.zero
        return CGSize(width: targetSize.width + space + targetSize.height, height: targetSize.height)
    }
    
    init() {
        super.init(frame: CGRect.zero)
        
        deleteButton.contentMode = .scaleAspectFit
        deleteButton.setImage(#imageLiteral(resourceName: "icon_delete").withRenderingMode(.alwaysTemplate), for: .normal)
        deleteButton.addTarget(self, action: #selector(didRemove), for: .touchUpInside)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func arrangeViews<T : UIView>(target: T) {
        addSubview(target)
        
        target.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: target, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: target, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        addSubview(deleteButton)
        let buttonSize = CGSize(width: target.intrinsicContentSize.height, height: target.intrinsicContentSize.height)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: deleteButton, attribute: .leading, relatedBy: .equal, toItem: target, attribute: .trailing, multiplier: 1, constant: space))
        addConstraint(NSLayoutConstraint(item: deleteButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: buttonSize.width))
        addConstraint(NSLayoutConstraint(item: deleteButton, attribute: .centerY, relatedBy: .equal, toItem: target, attribute: .centerY, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: deleteButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: buttonSize.height))
        addConstraint(NSLayoutConstraint(item: deleteButton, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0))
    }
    
    func didRemove() {
        actionDelegate?.tagActionTriggered(action: .remove)
    }
    
    public override func tagSelected(_ isSelected: Bool) {
        super.tagSelected(isSelected)
        
        deleteButton.tintColor = isSelected ? UIColor.white : UIColor.black
    }
}
