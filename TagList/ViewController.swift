//
//  ViewController.swift
//  TagList
//
//  Created by 王继荣 on 13/12/2016.
//  Copyright © 2016 wonderbear. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var addText: UITextField = {
        let view = UITextField()
        view.placeholder = "input new tag"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var addBtn: UIButton = {
        let view = UIButton()
        view.setTitle("add tag", for: .normal)
        view.setTitleColor(UIColor.black, for: .normal)
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
        view.showsHorizontalScrollIndicator = true
        view.showsVerticalScrollIndicator = true
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(addText)
        view.addSubview(addBtn)
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
        selectSegment.addTarget(self, action: #selector(switchSelect), for: .valueChanged)
        alignHorizontalSegment.addTarget(self, action: #selector(switchHorizontalAlign), for: .valueChanged)
        alignVerticalSegment.addTarget(self, action: #selector(switchVerticalAlign), for: .valueChanged)
        switchSeparateBtn.addTarget(self, action: #selector(switchSeparate), for: .valueChanged)
        switchDeleteBtn.addTarget(self, action: #selector(switchDelete), for: .valueChanged)
        selectedTagList.delegate = self
        tagList.delegate = self
        
        // ==================================
        view.addConstraint(NSLayoutConstraint(item: addText, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: addText, attribute: .trailing, relatedBy: .equal, toItem: addBtn, attribute: .leading, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: addText, attribute: .top, relatedBy: .equal, toItem: topLayoutGuide, attribute: .bottom, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: addText, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 50))
        
        view.addConstraint(NSLayoutConstraint(item: addBtn, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: addBtn, attribute: .top, relatedBy: .equal, toItem: addText, attribute: .top, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: addBtn, attribute: .height, relatedBy: .equal, toItem: addText, attribute: .height, multiplier: 1, constant: 0))
        // ==================================
        view.addConstraint(NSLayoutConstraint(item: selectLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: selectLabel, attribute: .trailing, relatedBy: .equal, toItem: selectSegment, attribute: .leading, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: selectLabel, attribute: .top, relatedBy: .equal, toItem: addText, attribute: .bottom, multiplier: 1, constant: 0))
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
        let tagArr = str.components(separatedBy: .whitespaces)
        let tagStr = tagArr[Int(arc4random_uniform(UInt32(tagArr.count)))]
        let tag = Tag(content: TagPresentableText(tagStr) {
            $0.label.font = UIFont.systemFont(ofSize: 16)
            }, onInit: {
                $0.padding = UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 10)
                $0.layer.borderColor = UIColor.cyan.cgColor
                $0.layer.borderWidth = 2
                $0.layer.cornerRadius = 5
            }, onSelect: {
            $0.backgroundColor = $0.isSelected ? UIColor.orange : UIColor.white
        })
        tagList.tags.append(tag)
    }
    
    func switchSelect() {
        tagList.selectionMode = [TagSelectionMode.none, TagSelectionMode.single, TagSelectionMode.multiple][selectSegment.selectedSegmentIndex]
    }
    
    func switchSeparate() {
        tagList.isSeparated = switchSeparateBtn.isOn
    }
    
    func switchDelete() {
        if switchDeleteBtn.isOn {
            tagList.tags.forEach { (tag) in
                tag.wrappers = []
            }
        } else {
            tagList.tags.forEach { (tag) in
                tag.wrappers = [TagWrapperRemover(onInit: {
                    $0.space = 8
                }) {
                    $0.deleteButton.tintColor = $1 ? UIColor.white : UIColor.black
                    }]
            }
        }
    }
    
    func switchHorizontalAlign() {
        tagList.horizontalAlignment = [TagHorizontalAlignment.left, TagHorizontalAlignment.center, TagHorizontalAlignment.right][alignHorizontalSegment.selectedSegmentIndex]
    }
    
    func switchVerticalAlign() {
        tagList.verticalAlignment = [TagVerticalAlignment.top, TagVerticalAlignment.center, TagVerticalAlignment.bottom][alignHorizontalSegment.selectedSegmentIndex]
    }
}

extension ViewController: TagListDelegate {

    func tagListUpdated(tagList: TagList) {
        if tagList == selectedTagList {
            areaSelected.contentSize = tagList.intrinsicContentSize
        } else {
            areaList.contentSize = tagList.intrinsicContentSize
        }
    }
    
    func tagActionTriggered(tagList: TagList, action: TagAction, content: TagPresentable, index: Int) {
        if tagList != selectedTagList {
            selectedTagList.tags = tagList.selectedTagPresentables().map({ (tag) -> Tag in
                Tag(content: TagPresentableText(tag.tag) {
                    $0.label.font = UIFont.systemFont(ofSize: 16)
                    }, onInit: {
                        $0.padding = UIEdgeInsets(top: 3, left: 5, bottom: 3, right: 5)
                        $0.layer.borderColor = UIColor.cyan.cgColor
                        $0.layer.borderWidth = 2
                        $0.layer.cornerRadius = 5
                }, onSelect: {
                    $0.backgroundColor = $0.isSelected ? UIColor.orange : UIColor.white
                })
            })
        }
    }
}

