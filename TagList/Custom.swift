//
//  MyTag.swift
//  TagList
//
//  Created by 王继荣 on 17/12/2016.
//  Copyright © 2016 wonderbear. All rights reserved.
//

import UIKit

class MyTag: Tag {

    override func tagStateDidChange() {
        switch state {
        case UIControlState.selected:
            backgroundColor = UIColor.orange
        default:
            backgroundColor = UIColor.gray
        }
    }
}
