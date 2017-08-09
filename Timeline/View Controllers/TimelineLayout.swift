//
//  TimelineLayout.swift
//  Timeline
//
//  Created by Jack Cook on 8/8/17.
//  Copyright © 2017 Jack Cook. All rights reserved.
//

import UIKit

class TimelineLayout: UICollectionViewFlowLayout {
    
    private let events: [[Event]]
    
    private var eventWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        
        return collectionView.frame.size.width / 2
    }
    
    private var eventHeight: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        
        return collectionView.frame.size.height / 2
    }
    
    override var collectionViewContentSize: CGSize {
        guard let collectionView = collectionView else {
            return .zero
        }
        
        let width = collectionView.frame.size.width + (eventWidth / 2) * CGFloat(events.flatMap({ $0 }).count + events.count - 1 + 1)
        return CGSize(width: width, height: collectionView.frame.size.height)
    }
    
    init(events: [[Event]]) {
        self.events = events
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func frameForCell(at indexPath: IndexPath) -> CGRect {
        guard let collectionView = collectionView else {
            return .zero
        }
        
        var eventsBeforeThisSection: CGFloat = 0
        
        for (idx, sectionEvents) in events.enumerated() where idx < indexPath.section - 1 {
            eventsBeforeThisSection += CGFloat(sectionEvents.count) / 2 + 0.5
        }
        
        let horizontalOffset = collectionView.frame.size.width + eventsBeforeThisSection * eventWidth
        
        switch indexPath.section {
        case 0:
            return CGRect(x: 0, y: 0, width: collectionView.frame.size.width, height: collectionView.frame.size.height)
        default:
            switch indexPath.row {
            case 0:
                return CGRect(x: horizontalOffset, y: 0, width: eventWidth / 2, height: eventHeight)
            case events[indexPath.section - 1].count + 1:
                return CGRect(x: horizontalOffset + (CGFloat(events[indexPath.section - 1].count) / 2) * eventWidth, y: indexPath.row % 2 == 0 ? 0 : eventHeight, width: eventWidth / 2, height: eventHeight)
            default:
                return CGRect(x: horizontalOffset + CGFloat(indexPath.item - 1) * (eventWidth / 2), y: (indexPath.item - 1) % 2 == 0 ? eventHeight : 0, width: eventWidth, height: eventHeight)
            }
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for section in 0 ..< (collectionView?.numberOfSections ?? 0) {
            for item in 0 ..< (collectionView?.numberOfItems(inSection: section) ?? 0) {
                let indexPath = IndexPath(item: item, section: section)
                let frame = frameForCell(at: indexPath)
                
                if rect.intersects(frame), let attributes = collectionView?.layoutAttributesForItem(at: indexPath) {
                    attributes.frame = frame
                    layoutAttributes.append(attributes)
                }
            }
        }
        
        return layoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attributes.frame = frameForCell(at: indexPath)
        
        return attributes
    }
}
