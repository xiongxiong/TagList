//
//  TagPresentables.swift
//  TagList
//
//  Created by 王继荣 on 16/12/2016.
//  Copyright © 2016 wonderbear. All rights reserved.
//

import UIKit

public struct TagPresentableText: TagPresentable {
    
    public private(set) var tag: String = ""
    public var isSelected: Bool = false
    private var onContentInit: ((TagContentText) -> Void)?
    
    public init(_ tag: String, onContentInit: ((TagContentText) -> Void)? = nil) {
        self.tag = tag
        self.onContentInit = onContentInit
    }
    
    public func createTagContent() -> TagContent {
        let tagContent = TagContentText(tag: tag)
        onContentInit?(tagContent)
        return tagContent
    }
}

public struct TagPresentableIcon: TagPresentable {
    
    public private(set) var tag: String = ""
    public private(set) var icon: String = ""
    public var isSelected: Bool = false
    private var onContentInit: ((TagContentIcon) -> Void)?
    
    public init(_ tag: String, icon: String, onContentInit: ((TagContentIcon) -> Void)? = nil) {
        self.tag = tag
        self.icon = icon
        self.onContentInit = onContentInit
    }
    
    public func createTagContent() -> TagContent {
        let tagContent = TagContentIcon(tag: tag)
        tagContent.icon.image = UIImage(named: icon)
        onContentInit?(tagContent)
        return tagContent
    }
}


public struct TagPresentableIconText: TagPresentable {
    
    public private(set) var tag: String = ""
    public private(set) var icon: String = ""
    public var isSelected: Bool = false
    private var onContentInit: ((TagContentIconText) -> Void)?
    
    public init(_ tag: String, icon: String, onContentInit: ((TagContentIconText) -> Void)? = nil) {
        self.tag = tag
        self.icon = icon
        self.onContentInit = onContentInit
    }
    
    public func createTagContent() -> TagContent {
        let tagContent = TagContentIconText(tag: tag)
        tagContent.icon.image = UIImage(named: icon)
        onContentInit?(tagContent)
        return tagContent
    }
}
