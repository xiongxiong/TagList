//
//  TagContents.swift
//  TagList
//
//  Created by 王继荣 on 16/12/2016.
//  Copyright © 2016 wonderbear. All rights reserved.
//

import UIKit

public class TagContentText: TagContent {
    
    public var label = UILabel()
    
    open override var intrinsicContentSize: CGSize {
        return label.intrinsicContentSize
    }
    
    public override init(tag: String) {
        super.init(tag: tag)
        
        addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: label, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: label, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0))
        
        label.text = tag
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class TagContentIcon: TagContent {
    
    public var icon = UIImageView()
    public var height: CGFloat = 0
    
    open override var intrinsicContentSize: CGSize {
        var size = CGSize.zero
        if let image = icon.image {
            if image.size.height != 0 {
                let ratio = image.size.width / image.size.height
                size = CGSize(width: height * ratio, height: height)
            }
        }
        return size
    }
    
    public override init(tag: String) {
        super.init(tag: tag)
        
        addSubview(icon)
        
        icon.contentMode = .scaleAspectFit
        icon.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: icon, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: icon, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: icon, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: icon, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0))
        
        icon.image = UIImage(named: tag)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class TagContentIconText: TagContent {
    
    public var icon = UIImageView()
    public var label = UILabel()
    public var space: CGFloat = 8
    
    open override var intrinsicContentSize: CGSize {
        let labelSize = label.intrinsicContentSize
        var imageSize = CGSize.zero
        if let image = icon.image {
            if image.size.height != 0 {
                let ratio = image.size.width / image.size.height
                imageSize = CGSize(width: labelSize.height * ratio, height: labelSize.height)
            }
        }
        return CGSize(width: imageSize.width + labelSize.height + space, height: labelSize.height)
    }
    
    public override init(tag: String) {
        super.init(tag: tag)
        
        addSubview(icon)
        addSubview(label)
        
        icon.contentMode = .scaleAspectFit
        icon.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: icon, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: icon, attribute: .width, relatedBy: .equal, toItem: label, attribute: .height, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: icon, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: icon, attribute: .height, relatedBy: .equal, toItem: label, attribute: .height, multiplier: 1, constant: 0))
        
        label.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal, toItem: icon, attribute: .trailing, multiplier: 1, constant: space))
        addConstraint(NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        icon.image = UIImage(named: tag)
        label.text = tag
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
