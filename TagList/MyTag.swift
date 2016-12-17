//
//  MyTag.swift
//  TagList
//
//  Created by 王继荣 on 17/12/2016.
//  Copyright © 2016 wonderbear. All rights reserved.
//

import UIKit

class MyTag: Tag {

    override func tagStateDidChange(state: UIControlState) {
        switch state {
        case UIControlState.selected:
            backgroundColor = UIColor.orange
        case UIControlState.highlighted:
            backgroundColor = UIColor.red
        default:
            backgroundColor = UIColor.gray
        }
    }

}
