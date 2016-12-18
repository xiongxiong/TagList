//
//  MyTag.swift
//  TagList
//
//  Created by 王继荣 on 17/12/2016.
//  Copyright © 2016 wonderbear. All rights reserved.
//

import UIKit

class MyTag: Tag {

    override func tagSelected() {
        super.tagSelected()
        
        backgroundColor = isSelected ? UIColor.orange : UIColor.white
    }
}
