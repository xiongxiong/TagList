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
    
    // MARK: - init
    public init() {
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
    
    func stateDidChange(state: UIControlState) {
        stateDelegate?.stateDidChange(state: state)
    }
    
    func onTap() {
        delegate?.tagActionTriggered(action: "tap")
    }
    
    func setContent(content: String) {
        
    }
}

class TextTag: TagControl {
    
    public var label = UILabel()
    
    open override var intrinsicContentSize: CGSize {
        return label.intrinsicContentSize
    }
    
    override init() {
        super.init()
        
        addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: label, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: label, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0))
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setContent(content: String) {
        label.text = content
    }
}

class IconTag: TagControl {
    
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
    
    override init() {
        super.init()
        
        addSubview(icon)
        
        icon.contentMode = .scaleAspectFit
        icon.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: icon, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: icon, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: icon, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: icon, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0))
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setContent(content: String) {
        icon.image = UIImage(named: content)
    }
}

class IconTextTag: TagControl {
    
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
    
    override init() {
        super.init()
        
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
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setContent(content: String) {
        icon.image = UIImage(named: content)
        label.text = content
    }
}
