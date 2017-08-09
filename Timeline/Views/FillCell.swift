//
//  FillCell.swift
//  Timeline
//
//  Created by Jack Cook on 8/8/17.
//  Copyright © 2017 Jack Cook. All rights reserved.
//

import UIKit

class FillCell: UICollectionViewCell {
    
    static let topIdentifier = "FillCellTop"
    static let topNib = UINib(nibName: FillCell.topIdentifier, bundle: Bundle.main)
    
    static let bottomIdentifier = "FillCellBottom"
    static let bottomNib = UINib(nibName: FillCell.bottomIdentifier, bundle: Bundle.main)
}
