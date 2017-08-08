//
//  EventCell.swift
//  Timeline
//
//  Created by Jack Cook on 8/8/17.
//  Copyright © 2017 Jack Cook. All rights reserved.
//

import UIKit

class EventCell: UICollectionViewCell {
    
    // MARK: - Constants
    
    static let bottomIdentifier = "EventCellBottom"
    static let bottomNib = UINib(nibName: "EventCellBottom", bundle: Bundle.main)
    
    static let topIdentifier = "EventCellTop"
    static let topNib = UINib(nibName: "EventCellTop", bundle: Bundle.main)
    
    // MARK: - View Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
