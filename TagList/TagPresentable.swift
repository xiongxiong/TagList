//
//  TagPresentable.swift
//  TagList
//
//  Created by 王继荣 on 15/12/2016.
//  Copyright © 2016 wonderbear. All rights reserved.
//

import UIKit

public protocol TagPresentable {
    
    var tag: String { get set }
    var isSelected: Bool { get set }
}

public class TagPresentableText: TagPresentable {

    public var tag: String = ""
    public var isSelected: Bool = false
    
    init(_ tag: String) {
        self.tag = tag
    }
}
