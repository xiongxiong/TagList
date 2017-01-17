//
//  Tag.swift
//  TagList
//
//  Created by 王继荣 on 13/12/2016.
//  Copyright © 2016 wonderbear. All rights reserved.
//

import UIKit

protocol TagActionable {
    
    var actionDelegate: TagActionDelegate? { get set }
}

protocol TagActionDelegate: NSObjectProtocol {
    
    func tagActionTriggered(action: TagAction)
}

protocol TagStatable {
    
    var stateDelegate: TagStateDelegate? { get set }
}

protocol TagStateDelegate: NSObjectProtocol {
    
    func tagSelected(_ isSelected: Bool)
}

open class TagContent: UIView, TagActionable, TagStatable {
    
    weak var actionDelegate: TagActionDelegate?
    weak var stateDelegate: TagStateDelegate?
    
    private(set) var content: String
    
    public init(tag: String) {
        self.content = tag
        super.init(frame: CGRect.zero)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TagContent: TagActionDelegate {
    
    public func tagActionTriggered(action: TagAction) {
        actionDelegate?.tagActionTriggered(action: action)
    }
}

extension TagContent: TagStateDelegate {

    public func tagSelected(_ isSelected: Bool) {
        stateDelegate?.tagSelected(isSelected)
    }
}

