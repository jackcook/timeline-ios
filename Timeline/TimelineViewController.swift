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
    
    private var cells: [TimelineCell] = [
        .start,
        .event,
        .event
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        
        collectionView.register(StartCell.nib, forCellWithReuseIdentifier: StartCell.identifier)
        collectionView.register(EventCell.bottomNib, forCellWithReuseIdentifier: EventCell.bottomIdentifier)
        collectionView.register(EventCell.topNib, forCellWithReuseIdentifier: EventCell.topIdentifier)
    }
    
    // MARK: - Private Methods
    
    private func cellModel(for indexPath: IndexPath) -> TimelineCell {
        return cells[indexPath.item]
    }
    
    // MARK: - UICollectionViewDataSource Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = cellModel(for: indexPath)

        guard let layoutAttributes = collectionView.layoutAttributesForItem(at: indexPath) else {
            fatalError()
        }
        
        let position: TimelineCellPosition = layoutAttributes.frame.origin.y == 0 ? .top : .bottom
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: model.identifier(position: position), for: indexPath)
        
        return cell
    }
    
    // MARK: UICollectionViewDelegateFlowLayout Methods
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch cellModel(for: indexPath) {
        case .start:
            return view.frame.size
        case .event:
            return CGSize(width: view.frame.size.width / 2, height: view.frame.size.height / 2)
        default:
            return .zero
        }
    }
}
