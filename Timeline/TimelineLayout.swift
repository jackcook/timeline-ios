//
//  TimelineLayout.swift
//  Timeline
//
//  Created by Jack Cook on 8/8/17.
//  Copyright © 2017 Jack Cook. All rights reserved.
//

import UIKit

class TimelineLayout: UICollectionViewFlowLayout {
    
    private let events: [Event]
    
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
        
        let width = collectionView.frame.size.width + (eventWidth / 2) * CGFloat(events.count + 1)
        return CGSize(width: width, height: collectionView.frame.size.height)
    }
    
    init(events: [Event]) {
        self.events = events
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else {
            return nil
        }
        
        return attributes.flatMap {
            let indexPath = $0.indexPath
            
            switch indexPath.section {
            case 1 ... 2:
                return self.layoutAttributesForItem(at: indexPath)
            default:
                return super.layoutAttributesForItem(at: indexPath)
            }
        }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let collectionView = collectionView else {
            return nil
        }
        
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        
        switch indexPath.section {
        case 1:
            attributes.frame = CGRect(x: collectionView.frame.size.width, y: 0, width: eventWidth / 2, height: eventHeight)
        case 2:
            attributes.frame = CGRect(x: collectionView.frame.size.width + CGFloat(indexPath.item) * (eventWidth / 2), y: indexPath.item % 2 == 0 ? eventHeight : 0, width: eventWidth, height: eventHeight)
        default:
            return nil
        }
        
        return attributes
    }
}
