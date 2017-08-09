//
//  TimelineViewController.swift
//  Timeline
//
//  Created by Jack Cook on 8/8/17.
//  Copyright © 2017 Jack Cook. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var events: [[Event]] = [
        [
            .easyMeasure
        ],
        [
            .elementAnimation,
            .mcproHosting,
            .beamCreation,
            .hackTheNorth,
            .hackUpstate,
            .hackRU,
            .firstLocalHackDay
        ],
        [
            .hackGenY,
            .mcHacks,
            .atomHacks,
            .secondHackRU,
            .secondLocalHackDay
        ],
        [
            .techStars,
            .hackNY,
            .thirdHackRU,
            .techCrunchDisrupt,
            .secondAtomHacks,
            .microsoftAcquisition,
            .thirdLocalHackDay
        ],
        [
            .topCharts,
            .thirdAtomHacks,
            .mixerRebrand
        ]
    ]
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let layout = TimelineLayout(events: events)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        
        collectionView.register(StartCell.nib, forCellWithReuseIdentifier: StartCell.identifier)
        
        collectionView.register(FillCell.topNib, forCellWithReuseIdentifier: FillCell.topIdentifier)
        collectionView.register(FillCell.bottomNib, forCellWithReuseIdentifier: FillCell.bottomIdentifier)
        
        collectionView.register(EventCell.topNib, forCellWithReuseIdentifier: EventCell.topIdentifier)
        collectionView.register(EventCell.bottomNib, forCellWithReuseIdentifier: EventCell.bottomIdentifier)
    }
    
    // MARK: - UICollectionViewDataSource Methods
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1 + events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? 1 : events[section - 1].count + 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell
        
        switch indexPath.section {
        case 0:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: StartCell.identifier, for: indexPath)
        default:
            guard let layoutAttributes = collectionView.layoutAttributesForItem(at: indexPath) else {
                fatalError()
            }
            
            let identifier: String
            
            if indexPath.row == 0 || indexPath.row == events[indexPath.section - 1].count + 1 {
                identifier = layoutAttributes.frame.origin.y == 0 ? FillCell.topIdentifier : FillCell.bottomIdentifier
                
                guard let fillCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? FillCell else {
                    fatalError("Could not get collection view cell")
                }
                
                cell = fillCell
            } else {
                identifier = layoutAttributes.frame.origin.y == 0 ? EventCell.topIdentifier : EventCell.bottomIdentifier
                
                guard let eventCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? EventCell else {
                    fatalError("Could not get collection view cell")
                }
                
                eventCell.event = events[indexPath.section - 1][indexPath.row - 1]
                cell = eventCell
            }
        }
        
        let colors = UIColor.sectionColors
        var colorIndex = indexPath.section
        
        while colorIndex > colors.count - 1 {
            colorIndex -= colors.count
        }
        
        cell.backgroundColor = colors[colorIndex]
        
        return cell
    }
    
    // MARK: UICollectionViewDelegateFlowLayout Methods
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return view.frame.size
        default:
            switch indexPath.row {
            case 0, events[indexPath.section - 1].count + 1:
                return CGSize(width: view.frame.size.width / 4, height: view.frame.size.height / 2)
            default:
                return CGSize(width: view.frame.size.width / 2, height: view.frame.size.height / 2)
            }
        }
    }
}
