//
//  DrawCollectionViewLayout.swift
//  Draw
//
//  Created by Марк Шнейдерман on 29.05.2021.
//

import UIKit

class ToolsCollectionViewLayout: UICollectionViewLayout {

    // MARK: Private properties
    private var itemCount = 0
    private let itemSize = CGSize(width: 80, height: 80)
    private let itemXSpacing: CGFloat = 15.0
    private var itemAndSpacingWidth: CGFloat {
        return itemSize.width
    }
    
    private var contentWidth: CGFloat {
        let totalItemAndSpacingWidth =  (CGFloat(itemCount) + itemAndSpacingWidth )
        return totalItemAndSpacingWidth
    }

    private var leadingOffsetX: CGFloat {
        guard let cv = collectionView else { return insetWidth }
        return  cv.frame.width / 7.0
    }
    private var trailingOffsetX: CGFloat {
        var widthAdjustment = insetWidth
        if  let cv = collectionView {
            widthAdjustment = cv.frame.width / 2.0
        }
        return collectionViewContentSize.width - widthAdjustment
    }

    private let insetWidth: CGFloat = 16000

    private var hasSetInitialContentOffsetOnce = false

    private var hasEnoughContentToWrap: Bool {
        guard let cv = collectionView else { return false }
        return contentWidth > (cv.frame.width + itemAndSpacingWidth)
    }
    
    private var layoutAttributes: [UICollectionViewLayoutAttributes] = []
    private var adjustedLayoutAttributes: [UICollectionViewLayoutAttributes] = []
}

// MARK: UICollectionViewLayout overrides
extension ToolsCollectionViewLayout {
    override var collectionViewContentSize: CGSize {
        guard let cv = collectionView else { return .zero }

        let totalContentWidth: CGFloat
        let extraWidth = itemAndSpacingWidth
        totalContentWidth = contentWidth + cv.frame.width - extraWidth
        return CGSize(width: totalContentWidth, height: cv.frame.height)
    }

    override func prepare() {
        super.prepare()
        guard let cv = collectionView else { return }

        itemCount = cv.numberOfItems(inSection: 0)

        if layoutAttributes.count == 0 {
            var currentX = leadingOffsetX
            layoutAttributes = []
            for item in 0..<itemCount {
                let indexPath = IndexPath(item: item, section: 0)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.size = itemSize
                let xCenter : CGFloat =  currentX
                let yCenter = cv.bounds.maxY / 2.0
                attributes.center = CGPoint(x: xCenter, y: yCenter)
                layoutAttributes.append(attributes)
                currentX += itemSize.width + itemXSpacing
            }
        }
        if itemCount == 0 { return }
        adjustedLayoutAttributes = layoutAttributes
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return adjustedLayoutAttributes.filter { rect.intersects($0.frame) }
    }
}

