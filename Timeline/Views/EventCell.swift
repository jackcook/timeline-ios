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
    
    static let topIdentifier = "EventCellTop"
    static let topNib = UINib(nibName: EventCell.topIdentifier, bundle: Bundle.main)
    
    static let bottomIdentifier = "EventCellBottom"
    static let bottomNib = UINib(nibName: EventCell.bottomIdentifier, bundle: Bundle.main)
    
    // MARK: - Variables
    
    @IBOutlet weak var label: UILabel!
    
    var event: Event? {
        didSet {
            guard let event = event else {
                return
            }
            
            label.text = event.name
        }
    }
    
    // MARK: - View Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
