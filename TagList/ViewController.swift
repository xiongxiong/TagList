//
//  ViewController.swift
//  TagList
//
//  Created by 王继荣 on 13/12/2016.
//  Copyright © 2016 wonderbear. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var tagList = TagList()
    var tagArr = [String]()
    var btnAdd = UIButton()
    var btnMod = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tagList)
        tagList.alignment = .center
        tagList.tagMargin = UIEdgeInsets(top: 3, left: 5, bottom: 3, right: 5)
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
        
        let str = "In 1886 he moved to Paris where he met members of the avant-garde"
        tagArr = str.components(separatedBy: .whitespaces)
    }
    
    func addTag() {
        let tagStr = tagArr[Int(arc4random_uniform(UInt32(tagArr.count)))]
        let tag = Tag(content: TagPresentableText(tagStr), type: TagControlText.self)
        tag.padding = UIEdgeInsets(top: 3, left: 5, bottom: 3, right: 5)
        tag.backgroundColor = UIColor.orange
        tag.layer.borderColor = UIColor.black.cgColor
        tag.layer.borderWidth = 0.5
        tag.layer.cornerRadius = 5
        tagList.appendTag(tag)
        tagList.backgroundColor = UIColor.green
        tagList.setNeedsLayout()
        tagList.layoutIfNeeded()
    }
    
    func modify() {
        tagList.tags.forEach { (tag) in
            print("before -- \(tag.content.tag)")
        }
        tagList.tags.forEach { (tag) in
            tagList.tags.first?.content.tag += "_"
        }
        tagList.tags.forEach { (tag) in
            print("after -- \(tag.content.tag)")
        }
        tagList.update()
    }
}
