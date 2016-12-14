//
//  TagList.swift
//  TagList
//
//  Created by 王继荣 on 13/12/2016.
//  Copyright © 2016 wonderbear. All rights reserved.
//

import UIKit

public protocol TagListActionDelegate: NSObjectProtocol {
    
    func tagPressed(tagView: TagControl, index: Int)
}

@IBDesignable
open class TagList: UIView {
    
    @IBInspectable open var alignment: TagAlignment = .left
    
    public weak var delegate: TagListActionDelegate?
    public var tagMargin = UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 10)
    public var useSeparator = true
    public var separator = UIImageView()
    public var separatorMargin = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 15)

    open var tagControls: [TagControl] = []
    private(set) var tagViews: [UIView] = []
    private(set) var rows: [(tagViews: [UIView], height: CGFloat)] = []
    
    // MARK: - Layout
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        tagViews.forEach { (view) in
            view.removeFromSuperview()
        }
        rows = []
        
        tagViews = tagControls.map { (tagControl) -> UIView in
            wrapTag(tagControl)
        }
        if useSeparator {
            tagViews = tagViews.enumerated().map({ (index, tagView) -> UIView in
                if index < tagViews.count - 1 {
                    return TagWrapperSeparator().wrap(target: tagView)
                } else {
                    return tagView
                }
            })
        }
        tagViews.enumerated().forEach { (index, tagView) in
            let rowIndex = (rows.count - 1) > 0 ? rows.count - 1 : 0
            let accumulatedWidth = rows[rowIndex].tagViews.reduce(0) { (result, tagView) -> CGFloat in
                result + tagView.intrinsicContentSize.width + tagMargin.left + tagMargin.right
            }
        }
    }
    
    func wrapTag(_ tagControl: TagControl) -> UIView {
        return tagControl.wrapper(TagWrapperRemover())
    }
    
    private func rearrangeViews() {
            
//            switch alignment {
//            case .left:
//                currentRowView.frame.origin.x = 0
//            case .center:
//                currentRowView.frame.origin.x = (frame.width - (currentRowWidth - marginX)) / 2
//            case .right:
//                currentRowView.frame.origin.x = frame.width - (currentRowWidth - marginX)
//            }
//            currentRowView.frame.size.width = currentRowWidth
//            currentRowView.frame.size.height = max(tagViewHeight, currentRowView.frame.height)
//        }
//        rows = currentRow
//        
//        invalidateIntrinsicContentSize()
    }
    
    // MARK: - Manage tags
    
    override open var intrinsicContentSize: CGSize {
        let height = rows.reduce(0) { (result, row) -> CGFloat in
            result + row.height
        }
        return CGSize(width: frame.width, height: height)
    }
    
//    @discardableResult
//    open func addTag(_ title: String) -> TagControl {
//        return addTagControl(createNewTagControl(title))
//    }
//    
//    @discardableResult
//    open func insertTag(_ title: String, at index: Int) -> TagControl {
//        return insertTagControl(createNewTagControl(title), at: index)
//    }
//    
//    @discardableResult
//    open func addTagControl(_ tagView: TagControl) -> TagControl {
//        tagViews.append(tagView)
//        tagBackgroundViews.append(UIView(frame: tagView.bounds))
//        rearrangeViews()
//        
//        return tagView
//    }
//    
//    @discardableResult
//    open func insertTagControl(_ tagView: TagControl, at index: Int) -> TagControl {
//        tagViews.insert(tagView, at: index)
//        tagBackgroundViews.insert(UIView(frame: tagView.bounds), at: index)
//        rearrangeViews()
//        
//        return tagView
//    }
//    
//    open func removeTag(_ title: String) {
//        // loop the array in reversed order to remove items during loop
//        for index in stride(from: (tagViews.count - 1), through: 0, by: -1) {
//            let tagView = tagViews[index]
//            if tagView.currentTitle == title {
//                removeTagControl(tagView)
//            }
//        }
//    }
//    
//    open func removeTagControl(_ tagView: TagControl) {
//        tagView.removeFromSuperview()
//        if let index = tagViews.index(of: tagView) {
//            tagViews.remove(at: index)
//            tagBackgroundViews.remove(at: index)
//        }
//        
//        rearrangeViews()
//    }
//    
//    open func removeAllTags() {
//        let views = tagViews as [UIView] + tagBackgroundViews
//        for view in views {
//            view.removeFromSuperview()
//        }
//        tagViews = []
//        tagBackgroundViews = []
//        rearrangeViews()
//    }
//    
//    open func selectedTags() -> [TagControl] {
//        return tagViews.filter() { $0.isSelected == true }
//    }
//    
//    // MARK: - Events
//    
//    func tagPressed(_ sender: TagControl!) {
//        sender.onTap?(sender)
//        delegate?.tagPressed?(sender.currentTitle ?? "", tagView: sender, sender: self)
//    }
//    
//    func removeButtonPressed(_ closeButton: CloseButton!) {
//        if let tagView = closeButton.tagView {
//            delegate?.tagRemoveButtonPressed?(tagView.currentTitle ?? "", tagView: tagView, sender: self)
//        }
//    }
    
}

public enum TagAlignment {
    
    case left
    case center
    case right
}

public enum WrapperType {
    
    case remover
}
