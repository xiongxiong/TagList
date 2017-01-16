//
//  TagList.swift
//  TagList
//
//  Created by 王继荣 on 13/12/2016.
//  Copyright © 2016 wonderbear. All rights reserved.
//

import UIKit

public protocol TagListDelegate: NSObjectProtocol {
    
    func tagListUpdated(tagList: TagList)
    func tagActionTriggered(tagList: TagList, action: TagAction, content: TagPresentable, index: Int)
}

extension TagListDelegate {
    
    func tagUpdated(tagList: TagList) {}
    func tagActionTriggered(tagList: TagList, action: TagAction, content: TagPresentable, index: Int) {}
}

open class TagList: UIView {
    
    public weak var delegate: TagListDelegate?
    
    public dynamic var tags: [Tag] = []
    public var horizontalAlignment: TagHorizontalAlignment = .left {
        didSet {
            update()
        }
    }
    public var verticalAlignment: TagVerticalAlignment = .center {
        didSet {
            update()
        }
    }
    public var tagMargin = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3) {
        didSet {
            update()
        }
    }
    public var separator: SeparatorInfo = SeparatorInfo() {
        didSet {
            update()
        }
    }
    public var isSeparatorEnabled = false {
        didSet {
            update()
        }
    }
    public var isAutowrap = true
    public var selectionMode: TagSelectionMode = .none

    private var rows: [(tagViews: [UIView], height: CGFloat)] = []
    
    open override var intrinsicContentSize: CGSize {
        if isAutowrap {
            let height = rows.reduce(0) { (result, row) -> CGFloat in
                result + row.height
            }
            return CGSize(width: frame.width, height: height)
        } else {
            let tagViews = getTagViews()
            return tagViews.reduce(CGSize(width: 0, height: frame.height)) { (result, tagView) in
                let surroundSize = getSurroundSize(view: tagView)
                return CGSize(width: result.width + surroundSize.width, height: max(result.height, surroundSize.height))
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        clipsToBounds = true
        addObserver(self, forKeyPath: "tags", options: [.initial, .new], context: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        removeObserver(self, forKeyPath: "tags")
    }
    
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        switch keyPath {
        case .some("tags"):
            tags.forEach({ (tag) in
                tag.delegate = self
            })
            update()
        default:
            break
        }
    }
    
    // MARK: - Layout
    func update() {
        rows = []
        subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        
        let tagViews = getTagViews()
        if isAutowrap {
            tagViews.enumerated().forEach { (index, tagView) in
                let tagViewSurroundSize = getSurroundSize(view: tagView)
                if rows.count > 0 {
                    let rowIndex = rows.count - 1
                    let accumulatedWidth = rows[rowIndex].tagViews.reduce(0) { (result, tagView) -> CGFloat in
                        result + tagView.intrinsicContentSize.width + tagMargin.left + tagMargin.right
                    }
                    if tagViewSurroundSize.width + accumulatedWidth > frame.width {
                        rows.append(([tagView], tagViewSurroundSize.height))
                    } else {
                        rows[rowIndex].tagViews.append(tagView)
                        rows[rowIndex].height = max(rows[rowIndex].height, tagViewSurroundSize.height)
                    }
                } else {
                    rows.append(([tagView], tagViewSurroundSize.height))
                }
            }
            if translatesAutoresizingMaskIntoConstraints {
                frame = CGRect(origin: frame.origin, size: intrinsicContentSize)
            }
            var rowViews = rows.map { _,_ in
                UIView()
            }
            rows.enumerated().forEach { (rowIndex, row) in
                let rowView = rowViews[rowIndex]
                addSubview(rowView)
                rowView.translatesAutoresizingMaskIntoConstraints = false
                if rowIndex == 0 {
                    addConstraint(NSLayoutConstraint(item: rowView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
                } else {
                    addConstraint(NSLayoutConstraint(item: rowView, attribute: .top, relatedBy: .equal, toItem: rowViews[rowIndex - 1], attribute: .bottom, multiplier: 1, constant: 0))
                }
                if rowIndex == rows.count - 1 {
                    addConstraint(NSLayoutConstraint(item: rowView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
                }
                addConstraint(NSLayoutConstraint(item: rowView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0))
                addConstraint(NSLayoutConstraint(item: rowView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0))
                addConstraint(NSLayoutConstraint(item: rowView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: row.height))
                
                row.tagViews.enumerated().forEach({ (tagIndex, tagView) in
                    rowView.addSubview(tagView)
                    tagView.translatesAutoresizingMaskIntoConstraints = false
                    switch verticalAlignment {
                    case .top:
                        rowView.addConstraint(NSLayoutConstraint(item: tagView, attribute: .top, relatedBy: .equal, toItem: rowView, attribute: .top, multiplier: 1, constant: tagMargin.top))
                    case .center:
                        rowView.addConstraint(NSLayoutConstraint(item: tagView, attribute: .centerY, relatedBy: .equal, toItem: rowView, attribute: .centerY, multiplier: 1, constant: 0))
                    case .bottom:
                        rowView.addConstraint(NSLayoutConstraint(item: tagView, attribute: .bottom, relatedBy: .equal, toItem: rowView, attribute: .bottom, multiplier: 1, constant: tagMargin.bottom * -1))
                    }
                    if tagIndex == 0 {
                        switch horizontalAlignment {
                        case .left:
                            rowView.addConstraint(NSLayoutConstraint(item: tagView, attribute: .leading, relatedBy: .equal, toItem: rowView, attribute: .leading, multiplier: 1, constant: tagMargin.left))
                        case .center:
                            let rowWidth = rows[rowIndex].tagViews.reduce(0) { (result, tagView) in
                                result + getSurroundSize(view: tagView).width
                            }
                            let spaceLeading = (frame.width - rowWidth) / 2
                            rowView.addConstraint(NSLayoutConstraint(item: tagView, attribute: .leading, relatedBy: .equal, toItem: rowView, attribute: .leading, multiplier: 1, constant: spaceLeading))
                        case .right:
                            rowView.addConstraint(NSLayoutConstraint(item: tagView, attribute: .trailing, relatedBy: .equal, toItem: rowView, attribute: .trailing, multiplier: 1, constant: tagMargin.right * -1))
                        }
                    } else {
                        switch horizontalAlignment {
                        case .left, .center:
                            rowView.addConstraint(NSLayoutConstraint(item: tagView, attribute: .leading, relatedBy: .equal, toItem: row.tagViews[tagIndex - 1], attribute: .trailing, multiplier: 1, constant: tagMargin.left + tagMargin.right))
                        case .right:
                            rowView.addConstraint(NSLayoutConstraint(item: tagView, attribute: .trailing, relatedBy: .equal, toItem: row.tagViews[tagIndex - 1], attribute: .leading, multiplier: 1, constant: (tagMargin.left + tagMargin.right) * -1))
                        }
                    }
                })
            }
        } else {
            if translatesAutoresizingMaskIntoConstraints {
                frame = CGRect(origin: frame.origin, size: intrinsicContentSize)
            }
            tagViews.enumerated().forEach { (index, tagView) in
                addSubview(tagView)
                tagView.translatesAutoresizingMaskIntoConstraints = false
                switch verticalAlignment {
                case .top:
                    addConstraint(NSLayoutConstraint(item: tagView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: tagMargin.top))
                case .center:
                    addConstraint(NSLayoutConstraint(item: tagView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
                case .bottom:
                    addConstraint(NSLayoutConstraint(item: tagView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: tagMargin.bottom * -1))
                }
                if index == 0 {
                    switch horizontalAlignment {
                    case .left:
                        addConstraint(NSLayoutConstraint(item: tagView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: tagMargin.left))
                    case .center:
                        let width = tagViews.reduce(0) { (result, tagView) in
                            result + getSurroundSize(view: tagView).width
                        }
                        let spaceLeading = (frame.width - width) / 2
                        addConstraint(NSLayoutConstraint(item: tagView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: spaceLeading))
                    case .right:
                        addConstraint(NSLayoutConstraint(item: tagView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: tagMargin.right * -1))
                    }
                } else if index == tagViews.count - 1 {
                    switch horizontalAlignment {
                    case .left, .center:
                        addConstraint(NSLayoutConstraint(item: tagView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: tagMargin.right * -1))
                    case .right:
                        addConstraint(NSLayoutConstraint(item: tagView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: tagMargin.left))
                    }
                } else {
                    switch horizontalAlignment {
                    case .left, .center:
                        addConstraint(NSLayoutConstraint(item: tagView, attribute: .leading, relatedBy: .equal, toItem: tagViews[index - 1], attribute: .trailing, multiplier: 1, constant: tagMargin.left + tagMargin.right))
                    case .right:
                        addConstraint(NSLayoutConstraint(item: tagView, attribute: .trailing, relatedBy: .equal, toItem: tagViews[index - 1], attribute: .leading, multiplier: 1, constant: (tagMargin.left + tagMargin.right) * -1))
                    }
                }
            }
        }
        
        delegate?.tagListUpdated(tagList: self)
    }
    
    // MARK: - Manage tags
    /// TagList's TagPresentables
    public func tagPresentables() -> [TagPresentable] {
        return tags.map { (tag) -> TagPresentable in
            tag.content
        }
    }
    
    /// TagList's selected TagPresentables
    public func selectedTagPresentables() -> [TagPresentable] {
        return tags.map({ (tag) -> TagPresentable in
            tag.content
        }).filter({ (tag) -> Bool in
            tag.isSelected
        })
    }
    
    /// Clear TagList's tags' selected state
    public func clearSelected() {
        tags.forEach { (tag) in
            tag.isSelected = false
        }
    }
    
    func index(of tag: Tag) -> Int? {
        return tags.index(where: {
            $0 == tag
        })
    }
    
    // MARK: - Custom
    func getTagViews() -> [UIView] {
        return tags.enumerated().map { (index, tag) -> UIView in
            tag.delegate = self
            var tagView: UIView = tag
            if isSeparatorEnabled && index < tags.count - 1 {
                let wrapper = SeparatorWrapper(info: separator)
                tagView = wrapper.wrap(tagView)
            }
            return tagView
        }
    }
    
    func getSurroundSize(view: UIView) -> CGSize {
        return CGSize(width: view.intrinsicContentSize.width + tagMargin.left + tagMargin.right, height: view.intrinsicContentSize.height + tagMargin.top + tagMargin.bottom)
    }
    
    func onTagTap(tag: Tag) {
        switch selectionMode {
        case .single:
            if tag.isSelected {
                tags.forEach({ (other) in
                    if other != tag {
                        other.isSelected = false
                    }
                })
            }
        default:
            break
        }
    }
}

extension TagList: TagDelegate {
    
    func tagUpdated() {
        update()
        delegate?.tagListUpdated(tagList: self)
    }
    
    func tagActionTriggered(tag: Tag, action: TagAction) {
        if let index = index(of: tag) {
            delegate?.tagActionTriggered(tagList: self, action: action, content: tag.content, index: index)
        }
        switch action {
        case .tap:
            onTagTap(tag: tag)
        case .remove:
            if let index = index(of: tag) {
                tags.remove(at: index)
            }
        default:
            break
        }
    }
}

public enum TagHorizontalAlignment {
    
    case left
    case center
    case right
}

public enum TagVerticalAlignment {
    
    case top
    case center
    case bottom
}

public enum TagSelectionMode {
    
    case none
    case single
    case multiple
}
