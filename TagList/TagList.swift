//
//  TagList.swift
//  TagList
//
//  Created by 王继荣 on 13/12/2016.
//  Copyright © 2016 wonderbear. All rights reserved.
//

import UIKit

public protocol TagListDelegate: NSObjectProtocol {
    
    func tagActionTriggered(tagList: TagList, action: TagAction, content: TagPresentable, index: Int)
    func tagUpdated(tagList: TagList)
}

extension TagListDelegate {
    
    func tagActionTriggered(tagList: TagList, action: TagAction, content: TagPresentable, index: Int) {}
    func tagUpdated(tagList: TagList) {}
}

open class TagList: UIView {
    
    public weak var delegate: TagListDelegate?
    
    public dynamic var tags: [Tag] = []
    public var alignment: TagAlignment = .left
    public var tagMargin = UIEdgeInsets.zero
    public var separator: SeparatorInfo = SeparatorInfo()
    public var isSeparated = false
    public var selectionMode: TagSelectionMode = .single

    private var rows: [(tagViews: [UIView], height: CGFloat)] = []
    
    open override var intrinsicContentSize: CGSize {
        let height = rows.reduce(0) { (result, row) -> CGFloat in
            result + row.height
        }
        return CGSize(width: frame.width, height: height)
    }
    public var stripeSize: CGSize {
        let tagViews = getTagViews()
        return tagViews.reduce(CGSize.zero) { (result, view) -> CGSize in
            let width = result.width + view.intrinsicContentSize.width + tagMargin.left + tagMargin.right
            let height = max(result.height, view.intrinsicContentSize.height)
            return CGSize(width: width, height: height)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
        tagViews.enumerated().forEach { (index, tagView) in
            if rows.count > 0 {
                let rowIndex = rows.count - 1
                let accumulatedWidth = rows[rowIndex].tagViews.reduce(0) { (result, tagView) -> CGFloat in
                    result + tagView.intrinsicContentSize.width + tagMargin.left + tagMargin.right
                }
                let tagViewSurroundSize = getSurroundSize(view: tagView)
                if tagViewSurroundSize.width + accumulatedWidth > frame.width {
                    rows.append(([tagView], tagViewSurroundSize.height))
                } else {
                    rows[rowIndex].tagViews.append(tagView)
                    rows[rowIndex].height = max(rows[rowIndex].height, tagViewSurroundSize.height)
                }
            } else {
                let tagViewSurroundSize = getSurroundSize(view: tagView)
                rows.append(([tagView], tagViewSurroundSize.height))
            }
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
                rowView.addConstraint(NSLayoutConstraint(item: tagView, attribute: .centerY, relatedBy: .equal, toItem: rowView, attribute: .centerY, multiplier: 1, constant: 0))
                if tagIndex == 0 {
                    switch alignment {
                    case .left:
                        rowView.addConstraint(NSLayoutConstraint(item: tagView, attribute: .leading, relatedBy: .equal, toItem: rowView, attribute: .leading, multiplier: 1, constant: tagMargin.left))
                    case .right:
                        rowView.addConstraint(NSLayoutConstraint(item: tagView, attribute: .trailing, relatedBy: .equal, toItem: rowView, attribute: .trailing, multiplier: 1, constant: tagMargin.right * -1))
                    case .center:
                        let rowWidth = rows[rowIndex].tagViews.reduce(0) { (result, tagView) in
                            result + getSurroundSize(view: tagView).width
                        }
                        let spaceLeading = (frame.width - rowWidth) / 2
                        rowView.addConstraint(NSLayoutConstraint(item: tagView, attribute: .leading, relatedBy: .equal, toItem: rowView, attribute: .leading, multiplier: 1, constant: spaceLeading))
                    }
                } else {
                    switch alignment {
                    case .left, .center:
                        rowView.addConstraint(NSLayoutConstraint(item: tagView, attribute: .leading, relatedBy: .equal, toItem: row.tagViews[tagIndex - 1], attribute: .trailing, multiplier: 1, constant: tagMargin.left + tagMargin.right))
                    case .right:
                        rowView.addConstraint(NSLayoutConstraint(item: tagView, attribute: .trailing, relatedBy: .equal, toItem: row.tagViews[tagIndex - 1], attribute: .leading, multiplier: 1, constant: (tagMargin.left + tagMargin.right) * -1))
                    }
                }
            })
        }
    }
    
    // MARK: - Manage tags
    
    public func appendTag(_ tag: Tag) {
        tags.append(tag)
    }
    
    public func insertTag(_ tag: Tag, at index: Int) {
        tags.insert(tag, at: index)
    }

    public func removeTag(_ content: TagPresentable) {
        if let index = index(of: content) {
            tags.remove(at: index)
        }
    }

    public func selectedTags() -> [Tag] {
        return tags.filter {
            $0.content.isSelected == true
        }
    }
    
    public func index(of content: TagPresentable) -> Int? {
        return tags.index(where: {
            $0.content.tag == content.tag
        })
    }
    
    // MARK: - Custom
    
    func getTagViews() -> [UIView] {
        return tags.enumerated().map { (index, tag) -> UIView in
            tag.delegate = self
            var tagView: UIView = tag
            if isSeparated && index < tags.count - 1 {
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
            tag.isSelected = !tag.isSelected
            if tag.isSelected {
                tags.forEach({ (tag) in
                    tag.isSelected = false
                })
            }
        case .multiple:
            tag.isSelected = !tag.isSelected
        default:
            break
        }
    }
}

extension TagList: TagDelegate {
    
    func tagUpdated() {
        update()
        delegate?.tagUpdated(tagList: self)
    }
    
    func tagActionTriggered(tag: Tag, action: TagAction) {
        switch action {
        case .tap:
            onTagTap(tag: tag)
        case .remove:
            removeTag(tag.content)
        default:
            break
        }
        if let index = index(of: tag.content) {
            delegate?.tagActionTriggered(tagList: self, action: action, content: tag.content, index: index)
        }
    }
}

public enum TagAlignment {
    
    case left
    case center
    case right
}

public enum TagSelectionMode {
    
    case none
    case single
    case multiple
}
