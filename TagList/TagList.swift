//
//  TagList.swift
//  TagList
//
//  Created by 王继荣 on 13/12/2016.
//  Copyright © 2016 wonderbear. All rights reserved.
//

import UIKit

public protocol TagListDelegate: NSObjectProtocol {
    
    func tagActionTriggered(action: String, content: TagPresentable, index: Int)
}

open class TagList: UIView {
    
    public weak var delegate: TagListDelegate?
    
    public var alignment: TagAlignment = .left
    public var tagMargin = UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 10)
    public var separatorWrapper = SeparatorWrapper()
    public var isTagSeparated = true
    public var isTagSelectable = false

    private var tagData: [(content: TagPresentable, type: TagControl.Type)] = []
    private var rows: [(tagViews: [UIView], height: CGFloat)] = []
    private var tagViews: [UIView] = []
    
    public var tags: [TagPresentable] {
        return tagData.map({ (content, _) -> TagPresentable in
            content
        })
    }
    open override var intrinsicContentSize: CGSize {
        let height = rows.reduce(0) { (result, row) -> CGFloat in
            result + row.height
        }
        return CGSize(width: frame.width, height: height)
    }
    public var stripeSize: CGSize {
        return tagViews.reduce(CGSize.zero) { (result, view) -> CGSize in
            let width = result.width + view.intrinsicContentSize.width + tagMargin.left + tagMargin.right
            let height = max(result.height, view.intrinsicContentSize.height)
            return CGSize(width: width, height: height)
        }
    }
    
    // MARK: - Layout
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        rows = []
        subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        
        tagViews = tagData.enumerated().map { (index, data) -> UIView in
            var tagView: UIView = Tag(content: data.content, type: data.type)
            if isTagSeparated && index < tagData.count - 1 {
                tagView = SeparatorWrapper().wrap(tagView)
            }
            return tagView
        }
        tagViews.enumerated().forEach { (index, tagView) in
            let rowIndex = (rows.count - 1) > 0 ? rows.count - 1 : 0
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
        }
        rows.enumerated().forEach { (rowIndex, row) in
            let accumulatedHeight = rows.enumerated().reduce(0) { (result, row) in
                result + (row.offset < rowIndex ? row.element.height : 0)
            }
            row.tagViews.enumerated().forEach({ (tagIndex, tagView) in
                addSubview(tagView)
                tagView.translatesAutoresizingMaskIntoConstraints = false
                addConstraint(NSLayoutConstraint(item: tagView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: accumulatedHeight + row.height / 2))
                if tagIndex == 0 {
                    switch alignment {
                    case .left:
                        addConstraint(NSLayoutConstraint(item: tagView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: tagMargin.left))
                    case .right:
                        addConstraint(NSLayoutConstraint(item: tagView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: tagMargin.left))
                    case .center:
                        let rowWidth = rows[rowIndex].tagViews.reduce(0) { (result, tagView) in
                            result + getSurroundSize(view: tagView).width
                        }
                        let spaceLeading = (frame.width - rowWidth) / 2
                        addConstraint(NSLayoutConstraint(item: tagView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: spaceLeading))
                    }
                } else {
                    let viewPrevious = row.tagViews[tagIndex - 1]
                    addConstraint(NSLayoutConstraint(item: tagView, attribute: .centerY, relatedBy: .equal, toItem: viewPrevious, attribute: .centerY, multiplier: 1, constant: 0))
                    addConstraint(NSLayoutConstraint(item: tagView, attribute: .leading, relatedBy: .equal, toItem: viewPrevious, attribute: .trailing, multiplier: 1, constant: tagMargin.left + tagMargin.right))
                }
            })
        }
    }
    
    // MARK: - Manage tags
    
    public func setTags(_ tagData: [(content: TagPresentable, type: TagControl.Type)]) {
        self.tagData = tagData
    }
    
    public func appendTag(_ content: TagPresentable, type: TagControl.Type = TextTagControl.self) {
        tagData.append((content, type))
    }
    
    public func insertTag(_ content: TagPresentable, at index: Int, type: TagControl.Type = TextTagControl.self) {
        tagData.insert((content, type), at: index)
    }

    public func removeTag(_ content: TagPresentable) {
        if let index = index(of: content) {
            tagData.remove(at: index)
        }
    }
    
    public func removeAllTags() {
        self.tagData = []
    }

    public func selectedTags() -> [TagPresentable] {
        return tags.filter {
            $0.isSelected
        }
    }
    
    // MARK: - Custom
    public func index(of content: TagPresentable) -> Int? {
        return tagData.index(where: {
            $0.content.tag == content.tag
        })
    }
    
    func getSurroundSize(view: UIView) -> CGSize {
        return CGSize(width: view.intrinsicContentSize.width + tagMargin.left + tagMargin.right, height: view.intrinsicContentSize.height + tagMargin.top + tagMargin.bottom)
    }
}

extension TagList: TagDelegate {
    
    public func tagActionTriggered(action: String, content: TagPresentable) {
        if let index = index(of: content) {
            delegate?.tagActionTriggered(action: action, content: content, index: index)
        }
    }
}

public enum TagAlignment {
    
    case left
    case center
    case right
}
