//
//  TagPresentable.swift
//  TagList
//
//  Created by 王继荣 on 15/12/2016.
//  Copyright © 2016 wonderbear. All rights reserved.
//

import UIKit

public protocol TagPresentable {
    
    var tag: String { get }
    var isSelected: Bool { get set }
    
    func createTagContent() -> TagContent
}
