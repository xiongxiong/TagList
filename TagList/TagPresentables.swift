//
//  TagPresentables.swift
//  TagList
//
//  Created by 王继荣 on 16/12/2016.
//  Copyright © 2016 wonderbear. All rights reserved.
//

import UIKit

public class TagPresentableText: TagPresentable {
    
    public private(set) var tag: String = ""
    private var onInit: ((TagContentText) -> Void)?
    
    init(_ tag: String, onInit: ((TagContentText) -> Void)? = nil) {
        self.tag = tag
        self.onInit = onInit
    }
    
    public func createTagContent() -> TagContent {
        let tagContent = TagContentText(tag: tag)
        onInit?(tagContent)
        return tagContent
    }
}

public class TagPresentableIcon: TagPresentable {
    
    public private(set) var tag: String = ""
    private var onInit: ((TagContentIcon) -> Void)?
    
    init(_ tag: String, onInit: ((TagContentIcon) -> Void)? = nil) {
        self.tag = tag
        self.onInit = onInit
    }
    
    public func createTagContent() -> TagContent {
        let tagContent = TagContentIcon(tag: tag)
        onInit?(tagContent)
        return tagContent
    }
}


public class TagPresentableIconText: TagPresentable {
    
    public private(set) var tag: String = ""
    private var onInit: ((TagContentIconText) -> Void)?
    
    init(_ tag: String, onInit: ((TagContentIconText) -> Void)? = nil) {
        self.tag = tag
        self.onInit = onInit
    }
    
    public func createTagContent() -> TagContent {
        let tagContent = TagContentIconText(tag: tag)
        onInit?(tagContent)
        return tagContent
    }
}
