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
    
    private(set) var content: TagPresentable
    public var enableSelect = false
    
    public required init(content: TagPresentable) {
        self.content = content
        super.init(frame: CGRect.zero)
        
        clipsToBounds = true
        addObserver(self, forKeyPath: "state", options: [.initial, .new], context: nil)
        addObserver(self, forKeyPath: "content.tag", options: [.initial, .new], context: nil)
        addTarget(self, action: #selector(onTap), for: .touchUpInside)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        removeObserver(self, forKeyPath: "state")
        removeObserver(self, forKeyPath: "content.tag")
    }
    
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        switch keyPath {
        case .some("state"):
            stateDidChange(state: state)
        case .some("content.tag"):
            break
        default:
            break
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

