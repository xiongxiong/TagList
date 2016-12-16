//
//  Tag.swift
//  TagList
//
//  Created by 王继荣 on 13/12/2016.
//  Copyright © 2016 wonderbear. All rights reserved.
//

import UIKit

public protocol TagActionDelegate: NSObjectProtocol {
    
    func tagActionTriggered(action: String)
}

extension TagActionDelegate {
    
    func tagActionTriggered(action: String) {}
}

public protocol TagStateDelegate: NSObjectProtocol {
    
    var stateDelegate: TagStateDelegate? { get set }
    func stateDidChange(state: UIControlState)
}

extension TagStateDelegate {
    
    func stateDidChange(state: UIControlState) {}
}

open class TagControl: UIControl {
    
    public weak var delegate: TagActionDelegate?
    public weak var stateDelegate: TagStateDelegate?
    
    var content: TagPresentable
    public var enableSelect = false
    
    // MARK: - init
    public required init(content: TagPresentable) {
        self.content = content
        super.init(frame: CGRect.zero)
        
        clipsToBounds = true
        addObserver(self, forKeyPath: "state", options: NSKeyValueObservingOptions.new, context: nil)
        addTarget(self, action: #selector(onTap), for: .touchUpInside)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        removeObserver(self, forKeyPath: "state")
    }
    
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "state" {
            stateDidChange(state: state)
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    func onTap() {
        if enableSelect {
            isSelected = !isSelected
            content.isSelected = isSelected
        }
        delegate?.tagActionTriggered(action: "tap")
    }
}

extension TagControl: TagStateDelegate {

    public func stateDidChange(state: UIControlState) {
        stateDelegate?.stateDidChange(state: state)
    }
}

public class TagControlText: TagControl {
    
    public var label = UILabel()
    
    open override var intrinsicContentSize: CGSize {
        return label.intrinsicContentSize
    }
    
    public required init(content: TagPresentable) {
        super.init(content: content)
        
        addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: label, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: label, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0))
        
        label.text = content.tag
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class TagControlIcon: TagControl {
    
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
    
    public required init(content: TagPresentable) {
        super.init(content: content)
        
        addSubview(icon)
        
        icon.contentMode = .scaleAspectFit
        icon.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: icon, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: icon, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: icon, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: icon, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0))
        
        icon.image = UIImage(named: content.tag)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class TagControlIconText: TagControl {
    
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
    
    public required init(content: TagPresentable) {
        super.init(content: content)
        
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
        
        icon.image = UIImage(named: content.tag)
        label.text = content.tag
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
