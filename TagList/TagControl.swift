//
//  Tag.swift
//  TagList
//
//  Created by 王继荣 on 13/12/2016.
//  Copyright © 2016 wonderbear. All rights reserved.
//

import UIKit

public protocol TagActionable {
    
    var actionDelegate: TagActionDelegate? { get set }
}

public protocol TagActionDelegate: NSObjectProtocol {
    
    func tagActionTriggered(action: String)
}

extension TagActionDelegate {
    
    func tagActionTriggered(action: String) {}
}

public protocol TagStatable {
    
    var stateDelegate: TagStateDelegate? { get set }
}

public protocol TagStateDelegate: NSObjectProtocol {
    
    func tagStateDidChange(state: UIControlState)
}

extension TagStateDelegate {
    
    func tagStateDidChange(state: UIControlState) {}
}

open class TagControl: UIControl, TagActionable, TagStatable {
    
    public weak var actionDelegate: TagActionDelegate?
    public weak var stateDelegate: TagStateDelegate?
    
    private(set) var content: TagPresentable
    public var enableSelect = false
    
    public required init(content: TagPresentable) {
        self.content = content
        super.init(frame: CGRect.zero)
        
        clipsToBounds = true
//        addObserver(self, forKeyPath: "state", options: [.initial, .new], context: nil)
        addTarget(self, action: #selector(onTap), for: .touchUpInside)
//        addTarget(self, action: #selector(onTap), for: .allTouchEvents)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    deinit {
//        removeObserver(self, forKeyPath: "state")
//    }
    
//    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        switch keyPath {
//        case .some("state"):
//            tagStateDidChange(state: state)
//        default:
//            break
//        }
//    }
    
    func onTap() {
        if enableSelect {
            isSelected = !isSelected
            content.isSelected = isSelected
        }
        actionDelegate?.tagActionTriggered(action: "tap")
    }
}

extension TagControl: TagStateDelegate {

    public func tagStateDidChange(state: UIControlState) {
        stateDelegate?.tagStateDidChange(state: state)
    }
}

