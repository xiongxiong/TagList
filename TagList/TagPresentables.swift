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
    public var isSelected: Bool = false
    
    init(_ tag: String) {
        self.tag = tag
    }
}
