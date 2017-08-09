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
    
    private var events = [
        [
            Event(name: "Testing", date: Calendar.current.date(byAdding: .hour, value: -3, to: Date())!),
            Event(name: "Testing", date: Calendar.current.date(byAdding: .hour, value: -2, to: Date())!),
            Event(name: "Testing", date: Calendar.current.date(byAdding: .hour, value: -1, to: Date())!),
            Event(name: "Testing", date: Calendar.current.date(byAdding: .hour, value: 0, to: Date())!)
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
        switch indexPath.section {
        case 0:
            return collectionView.dequeueReusableCell(withReuseIdentifier: StartCell.identifier, for: indexPath)
        case 1:
            guard let layoutAttributes = collectionView.layoutAttributesForItem(at: indexPath) else {
                fatalError()
            }
            
            let identifier: String
            
            if indexPath.row == 0 || indexPath.row == events[indexPath.section - 1].count + 1 {
                identifier = layoutAttributes.frame.origin.y == 0 ? FillCell.topIdentifier : FillCell.bottomIdentifier
            } else {
                identifier = layoutAttributes.frame.origin.y == 0 ? EventCell.topIdentifier : EventCell.bottomIdentifier
            }
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
            
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    // MARK: UICollectionViewDelegateFlowLayout Methods
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return view.frame.size
        case 1:
            switch indexPath.row {
            case 0, events[indexPath.section - 1].count + 1:
                return CGSize(width: view.frame.size.width / 4, height: view.frame.size.height / 2)
            default:
                return CGSize(width: view.frame.size.width / 2, height: view.frame.size.height / 2)
            }
        default:
            return .zero
        }
    }
}
