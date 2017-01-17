//
//  ViewController.swift
//  TagList
//
//  Created by 王继荣 on 13/12/2016.
//  Copyright © 2016 wonderbear. All rights reserved.
//

import UIKit
import SwiftTagList

class ViewController: UIViewController {
    
    var addBtn: UIButton = {
        let view = UIButton()
        view.setTitle("Add Tag", for: .normal)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.blue.cgColor
        view.layer.cornerRadius = 10
        view.setTitleColor(UIColor.blue, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var typeLabel: UILabel = {
        let view = UILabel()
        view.text = "tag type"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var typeSegment: UISegmentedControl = {
        let view = UISegmentedControl(items: ["text", "icon", "icon & text"])
        view.selectedSegmentIndex = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var selectLabel: UILabel = {
        let view = UILabel()
        view.text = "multi selection"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var selectSegment: UISegmentedControl = {
        let view = UISegmentedControl(items: ["none", "single", "multi"])
        view.selectedSegmentIndex = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var alignHorizontalLabel: UILabel = {
        let view = UILabel()
        view.text = "horizontal alignment"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var alignHorizontalSegment: UISegmentedControl = {
        let view = UISegmentedControl(items: ["left", "center", "right"])
        view.selectedSegmentIndex = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var alignVerticalLabel: UILabel = {
        let view = UILabel()
        view.text = "vertical alignment"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var alignVerticalSegment: UISegmentedControl = {
        let view = UISegmentedControl(items: ["top", "center", "bottom"])
        view.selectedSegmentIndex = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var switchSeparateLabel: UILabel = {
        let view = UILabel()
        view.text = "tag is separated"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var switchSeparateBtn: UISwitch = {
        let view = UISwitch()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var switchDeleteLabel: UILabel = {
        let view = UILabel()
        view.text = "tag is deletable"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var switchDeleteBtn: UISwitch = {
        let view = UISwitch()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var areaSelected: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = UIColor.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var selectedTagList: TagList = {
        let view = TagList()
        view.isAutowrap = false
        view.backgroundColor = UIColor.yellow
        view.tagMargin = UIEdgeInsets(top: 3, left: 5, bottom: 3, right: 5)
        view.separator.image = #imageLiteral(resourceName: "icon_arrow_right")
        view.separator.size = CGSize(width: 16, height: 16)
        view.separator.margin = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        return view
    }()
    var areaList: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = UIColor.cyan
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var tagList: TagList = {
        let view = TagList()
        view.backgroundColor = UIColor.green
        view.tagMargin = UIEdgeInsets(top: 3, left: 5, bottom: 3, right: 5)
        view.separator.image = #imageLiteral(resourceName: "icon_arrow_right")
        view.separator.size = CGSize(width: 16, height: 16)
        view.separator.margin = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        return view
    }()
    var areaListMask = UIView()
    
    var swiDelete: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(addBtn)
        view.addSubview(typeLabel)
        view.addSubview(typeSegment)
        view.addSubview(selectLabel)
        view.addSubview(selectSegment)
        view.addSubview(alignHorizontalLabel)
        view.addSubview(alignHorizontalSegment)
        view.addSubview(alignVerticalLabel)
        view.addSubview(alignVerticalSegment)
        view.addSubview(switchSeparateLabel)
        view.addSubview(switchSeparateBtn)
        view.addSubview(switchDeleteLabel)
        view.addSubview(switchDeleteBtn)
        view.addSubview(areaSelected)
        areaSelected.addSubview(selectedTagList)
        view.addSubview(areaList)
        areaList.addSubview(tagList)
        
        addBtn.addTarget(self, action: #selector(addTag), for: .touchUpInside)
        typeSegment.addTarget(self, action: #selector(switchType), for: .valueChanged)
        selectSegment.addTarget(self, action: #selector(switchSelect), for: .valueChanged)
        alignHorizontalSegment.addTarget(self, action: #selector(switchHorizontalAlign), for: .valueChanged)
        alignVerticalSegment.addTarget(self, action: #selector(switchVerticalAlign), for: .valueChanged)
        switchSeparateBtn.addTarget(self, action: #selector(switchSeparate), for: .valueChanged)
        switchDeleteBtn.addTarget(self, action: #selector(switchDelete), for: .valueChanged)
        selectedTagList.delegate = self
        tagList.delegate = self
        
        // ==================================
        view.addConstraint(NSLayoutConstraint(item: addBtn, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: addBtn, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: addBtn, attribute: .top, relatedBy: .equal, toItem: topLayoutGuide, attribute: .bottom, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: addBtn, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 40))
        // ==================================
        view.addConstraint(NSLayoutConstraint(item: typeLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: typeLabel, attribute: .trailing, relatedBy: .equal, toItem: selectSegment, attribute: .leading, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: typeLabel, attribute: .top, relatedBy: .equal, toItem: addBtn, attribute: .bottom, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: typeLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 50))
        
        view.addConstraint(NSLayoutConstraint(item: typeSegment, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: typeSegment, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 160))
        view.addConstraint(NSLayoutConstraint(item: typeSegment, attribute: .centerY, relatedBy: .equal, toItem: typeLabel, attribute: .centerY, multiplier: 1, constant: 0))
        // ==================================
        view.addConstraint(NSLayoutConstraint(item: selectLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: selectLabel, attribute: .trailing, relatedBy: .equal, toItem: selectSegment, attribute: .leading, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: selectLabel, attribute: .top, relatedBy: .equal, toItem: typeLabel, attribute: .bottom, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: selectLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 50))
        
        view.addConstraint(NSLayoutConstraint(item: selectSegment, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: selectSegment, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 160))
        view.addConstraint(NSLayoutConstraint(item: selectSegment, attribute: .centerY, relatedBy: .equal, toItem: selectLabel, attribute: .centerY, multiplier: 1, constant: 0))
        // ==================================
        view.addConstraint(NSLayoutConstraint(item: alignHorizontalLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: alignHorizontalLabel, attribute: .trailing, relatedBy: .equal, toItem: alignHorizontalSegment, attribute: .leading, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: alignHorizontalLabel, attribute: .top, relatedBy: .equal, toItem: selectLabel, attribute: .bottom, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: alignHorizontalLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 50))
        
        view.addConstraint(NSLayoutConstraint(item: alignHorizontalSegment, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: alignHorizontalSegment, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 160))
        view.addConstraint(NSLayoutConstraint(item: alignHorizontalSegment, attribute: .centerY, relatedBy: .equal, toItem: alignHorizontalLabel, attribute: .centerY, multiplier: 1, constant: 0))
        // ==================================
        view.addConstraint(NSLayoutConstraint(item: alignVerticalLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: alignVerticalLabel, attribute: .trailing, relatedBy: .equal, toItem: alignHorizontalSegment, attribute: .leading, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: alignVerticalLabel, attribute: .top, relatedBy: .equal, toItem: alignHorizontalLabel, attribute: .bottom, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: alignVerticalLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 50))
        
        view.addConstraint(NSLayoutConstraint(item: alignVerticalSegment, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: alignVerticalSegment, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 160))
        view.addConstraint(NSLayoutConstraint(item: alignVerticalSegment, attribute: .centerY, relatedBy: .equal, toItem: alignVerticalLabel, attribute: .centerY, multiplier: 1, constant: 0))
        // ==================================
        view.addConstraint(NSLayoutConstraint(item: switchSeparateLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: switchSeparateLabel, attribute: .trailing, relatedBy: .equal, toItem: switchSeparateBtn, attribute: .leading, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: switchSeparateLabel, attribute: .top, relatedBy: .equal, toItem: alignVerticalLabel, attribute: .bottom, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: switchSeparateLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 50))
        
        view.addConstraint(NSLayoutConstraint(item: switchSeparateBtn, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: switchSeparateBtn, attribute: .centerY, relatedBy: .equal, toItem: switchSeparateLabel, attribute: .centerY, multiplier: 1, constant: 0))
        // ==================================
        view.addConstraint(NSLayoutConstraint(item: switchDeleteLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: switchDeleteLabel, attribute: .trailing, relatedBy: .equal, toItem: switchDeleteBtn, attribute: .leading, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: switchDeleteLabel, attribute: .top, relatedBy: .equal, toItem: switchSeparateLabel, attribute: .bottom, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: switchDeleteLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 50))
        
        view.addConstraint(NSLayoutConstraint(item: switchDeleteBtn, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: switchDeleteBtn, attribute: .centerY, relatedBy: .equal, toItem: switchDeleteLabel, attribute: .centerY, multiplier: 1, constant: 0))
        // ==================================
        view.addConstraint(NSLayoutConstraint(item: areaSelected, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: areaSelected, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: areaSelected, attribute: .top, relatedBy: .equal, toItem: switchDeleteLabel, attribute: .bottom, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: areaSelected, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 80))
        // ==================================
        view.addConstraint(NSLayoutConstraint(item: areaList, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: areaList, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: areaList, attribute: .top, relatedBy: .equal, toItem: areaSelected, attribute: .bottom, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: areaList, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        selectedTagList.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 0, height: areaSelected.frame.height))
        tagList.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: areaList.frame.width, height: 0))
    }
    
    func addTag() {
        let str = "In 1886 he moved to Paris where he met members of the avant-garde"
        let icons = ["tag_0","tag_1","tag_2","tag_3","tag_4","tag_5","tag_6","tag_7","tag_8","tag_9"]
        let tagArr = str.components(separatedBy: .whitespaces)
        let tagStr = tagArr[Int(arc4random_uniform(UInt32(tagArr.count)))]
        var newPresent: TagPresentable!
        switch typeSegment.selectedSegmentIndex {
        case 1:
            newPresent = TagPresentableIcon(tag: tagStr, icon: icons[Int(arc4random_uniform(UInt32(icons.count)))], height: 30)
        case 2:
            newPresent = TagPresentableIconText(tag: tagStr, icon: icons[Int(arc4random_uniform(UInt32(icons.count)))]) {
                $0.label.font = UIFont.systemFont(ofSize: 16)
            }
        default:
            newPresent = TagPresentableText(tag: tagStr) {
                $0.label.font = UIFont.systemFont(ofSize: 16)
            }
        }
        let tag = Tag(content: newPresent, onInit: {
                $0.padding = UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 10)
                $0.layer.borderColor = UIColor.cyan.cgColor
                $0.layer.borderWidth = 2
                $0.layer.cornerRadius = 5
                $0.backgroundColor = UIColor.white
            }, onSelect: {
            $0.backgroundColor = $0.isSelected ? UIColor.orange : UIColor.white
        })
        if swiDelete {
            tag.wrappers = [TagWrapperRemover(onInit: {
                $0.space = 8
                $0.deleteButton.tintColor = UIColor.black
            }) {
                $0.deleteButton.tintColor = $1 ? UIColor.white : UIColor.black
                }]
        }
        tagList.tags.append(tag)
    }
    
    func switchType() {
        let icons = ["tag_0","tag_1","tag_2","tag_3","tag_4","tag_5","tag_6","tag_7","tag_8","tag_9"]
        tagList.tags = tagList.tagPresentables().map({ (present) -> Tag in
            var newPresent: TagPresentable!
            switch typeSegment.selectedSegmentIndex {
            case 1:
                newPresent = TagPresentableIcon(tag: present.tag, icon: icons[Int(arc4random_uniform(UInt32(icons.count)))], height: 30)
            case 2:
                newPresent = TagPresentableIconText(tag: present.tag, icon: icons[Int(arc4random_uniform(UInt32(icons.count)))]) {
                    $0.label.font = UIFont.systemFont(ofSize: 16)
                }
            default:
                newPresent = TagPresentableText(tag: present.tag) {
                    $0.label.font = UIFont.systemFont(ofSize: 16)
                }
            }
            let tag = Tag(content: newPresent, onInit: {
                $0.padding = UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 10)
                $0.layer.borderColor = UIColor.cyan.cgColor
                $0.layer.borderWidth = 2
                $0.layer.cornerRadius = 5
                $0.backgroundColor = UIColor.white
            }, onSelect: {
                $0.backgroundColor = $0.isSelected ? UIColor.orange : UIColor.white
            })
            if swiDelete {
                tag.wrappers = [TagWrapperRemover(onInit: {
                    $0.space = 8
                    $0.deleteButton.tintColor = UIColor.black
                }) {
                    $0.deleteButton.tintColor = $1 ? UIColor.white : UIColor.black
                    }]
            }
            return tag
        })
    }
    
    func switchSelect() {
        tagList.selectionMode = [TagSelectionMode.none, TagSelectionMode.single, TagSelectionMode.multiple][selectSegment.selectedSegmentIndex]
        if tagList.selectionMode == TagSelectionMode.none {
            tagList.clearSelected()
        }
    }
    
    func switchSeparate() {
        tagList.isSeparatorEnabled = switchSeparateBtn.isOn
    }
    
    func switchDelete() {
        swiDelete = switchDeleteBtn.isOn
        if switchDeleteBtn.isOn {
            tagList.tags.forEach { (tag) in
                tag.wrappers = [TagWrapperRemover(onInit: {
                    $0.space = 8
                    $0.deleteButton.tintColor = UIColor.black
                }) {
                    $0.deleteButton.tintColor = $1 ? UIColor.white : UIColor.black
                    }]
            }
        } else {
            tagList.tags.forEach { (tag) in
                tag.wrappers = []
            }
        }
    }
    
    func switchHorizontalAlign() {
        tagList.horizontalAlignment = [TagHorizontalAlignment.left, TagHorizontalAlignment.center, TagHorizontalAlignment.right][alignHorizontalSegment.selectedSegmentIndex]
    }
    
    func switchVerticalAlign() {
        tagList.verticalAlignment = [TagVerticalAlignment.top, TagVerticalAlignment.center, TagVerticalAlignment.bottom][alignHorizontalSegment.selectedSegmentIndex]
    }
    
    func updateSelectedTagList() {
        selectedTagList.tags = tagList.selectedTagPresentables().map({ (tag) -> Tag in
            Tag(content: TagPresentableText(tag: tag.tag) {
                $0.label.font = UIFont.systemFont(ofSize: 16)
                }, onInit: {
                    $0.padding = UIEdgeInsets(top: 3, left: 5, bottom: 3, right: 5)
                    $0.layer.borderColor = UIColor.cyan.cgColor
                    $0.layer.borderWidth = 2
                    $0.layer.cornerRadius = 5
            })
        })
    }
}

extension ViewController: TagListDelegate {

    func tagListUpdated(tagList: TagList) {
        if tagList == selectedTagList {
            areaSelected.contentSize = tagList.intrinsicContentSize
        } else {
            areaList.contentSize = tagList.intrinsicContentSize
            updateSelectedTagList()
        }
    }
    
    func tagActionTriggered(tagList: TagList, action: TagAction, content: TagPresentable, index: Int) {
        print("=========  action -- \(action), content -- \(content.tag), index -- \(index)")
    }
}

