//
//  ViewController.swift
//  TagList
//
//  Created by 王继荣 on 13/12/2016.
//  Copyright © 2016 wonderbear. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var viewFunction = UIView()
    var viewTagList = UIScrollView()
    var tagList = TagList()
    var btnAdd = UIButton()
    var btnMod = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tagList)
        tagList.delegate = self
        tagList.alignment = .center
        tagList.tagMargin = UIEdgeInsets(top: 3, left: 5, bottom: 3, right: 5)
        tagList.isSeparated = true
        tagList.selectionMode = .multiple
        tagList.separator.image = #imageLiteral(resourceName: "icon_arrow_right")
        tagList.separator.size = CGSize(width: 16, height: 16)
        tagList.separator.margin = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        tagList.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraint(NSLayoutConstraint(item: tagList, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: tagList, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: tagList, attribute: .top, relatedBy: .equal, toItem: topLayoutGuide, attribute: .bottom, multiplier: 1, constant: 0))
        
        view.addSubview(btnAdd)
        btnAdd.setTitle("Add Tag", for: .normal)
        btnAdd.backgroundColor = UIColor.blue
        btnAdd.addTarget(self, action: #selector(addTag), for: .touchUpInside)
        btnAdd.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraint(NSLayoutConstraint(item: btnAdd, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: btnAdd, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: btnAdd, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: btnAdd, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 40))
        
        view.addSubview(btnMod)
        btnMod.setTitle("Modify", for: .normal)
        btnMod.backgroundColor = UIColor.yellow
        btnMod.addTarget(self, action: #selector(modify), for: .touchUpInside)
        btnMod.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraint(NSLayoutConstraint(item: btnMod, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: btnMod, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: btnMod, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: btnMod, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 40))
        
    }
    
    func addTag() {
        let str = "In 1886 he moved to Paris where he met members of the avant-garde"
        let tagArr = str.components(separatedBy: .whitespaces)
        let tagStr = tagArr[Int(arc4random_uniform(UInt32(tagArr.count)))]
        let tag = MyTag(content: TagPresentableText(tagStr), type: TagContentText.self, wrappers: [TagWrapperRemover()], padding: UIEdgeInsets(top: 3, left: 5, bottom: 3, right: 5))
        tag.layer.borderColor = UIColor.cyan.cgColor
        tag.layer.borderWidth = 1
        tag.layer.cornerRadius = 5
        tagList.appendTag(tag)
        tagList.backgroundColor = UIColor.green
        tagList.setNeedsLayout()
        tagList.layoutIfNeeded()
    }
    
    func modify() {
        tagList.tags.last?.content = TagPresentableText("----------")
    }
}

extension ViewController: TagListDelegate {}

