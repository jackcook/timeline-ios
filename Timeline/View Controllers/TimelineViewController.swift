//
//  TimelineViewController.swift
//  Timeline
//
//  Created by Jack Cook on 8/8/17.
//  Copyright © 2017 Jack Cook. All rights reserved.
//

import AVKit
import UIKit

class TimelineViewController: UIViewController, EventCellDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let events: [[Event]] = {
        var events = Event.loadAllEvents()
        var years = [[Event]]()
        
        for event in events {
            // 2013 is the year of the first event
            if years.count <= event.date.year - 2013 {
                years.append([event])
            } else {
                years[years.count - 1].append(event)
            }
        }
        
        return years
    }()
    
    private var yearLabels = [UILabel]()
    private var yearLabelBackgrounds = [CAGradientLayer]()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let layout = TimelineLayout(events: events)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        
        collectionView.register(StartCell.nib, forCellWithReuseIdentifier: StartCell.identifier)
        collectionView.register(EndCell.nib, forCellWithReuseIdentifier: EndCell.identifier)
        
        collectionView.register(FillCell.topNib, forCellWithReuseIdentifier: FillCell.topIdentifier)
        collectionView.register(FillCell.bottomNib, forCellWithReuseIdentifier: FillCell.bottomIdentifier)
        
        collectionView.register(EventCell.topNib, forCellWithReuseIdentifier: EventCell.topIdentifier)
        collectionView.register(EventCell.bottomNib, forCellWithReuseIdentifier: EventCell.bottomIdentifier)
        
        for (idx, section) in events.enumerated() {
            let colors = [0, 1, 1, 0].map { alpha -> CGColor in
                return UIColor.sectionColors[idx + 1].withAlphaComponent(alpha).cgColor
            }
            
            let layer = CAGradientLayer()
            layer.colors = colors
            layer.startPoint = CGPoint(x: 0, y: 0.5)
            layer.endPoint = CGPoint(x: 1, y: 0.5)
            yearLabelBackgrounds.append(layer)
            view.layer.addSublayer(layer)
            
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
            label.text = "\(section[0].date.year)"
            label.textColor = UIColor.white
            
            yearLabels.append(label)
            view.addSubview(label)
        }
    }
    
    // MARK: - EventCellDelegate Methods
    
    func eventCell(_ cell: EventCell, didTapVideoWith url: URL) {
        guard presentedViewController == nil, let eventController = UIStoryboard.main.instantiateViewController(withIdentifier: "EventViewController") as? EventViewController else {
            return
        }
        
        eventController.videoURL = url
        present(eventController, animated: true)
    }
    
    func eventCell(_ cell: EventCell, didTapPhotoWith photo: UIImage) {
        guard presentedViewController == nil, let eventController = UIStoryboard.main.instantiateViewController(withIdentifier: "EventViewController") as? EventViewController else {
            return
        }
        
        eventController.image = photo
        present(eventController, animated: true)
    }
    
    // MARK: - UICollectionViewDataSource Methods
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2 + events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (section == 0 || section == numberOfSections(in: collectionView) - 1) ? 1 : events[section - 1].count + 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell
        
        switch indexPath.section {
        case 0:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: StartCell.identifier, for: indexPath)
        case numberOfSections(in: collectionView) - 1:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: EndCell.identifier, for: indexPath)
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
                
                eventCell.delegate = self
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
    
    // MARK: UICollectionViewDelegate Methods
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        for (idx, label) in yearLabels.enumerated() {
            let firstIndexPath = IndexPath(item: 0, section: idx + 1)
            let lastIndexPath = IndexPath(item: collectionView.numberOfItems(inSection: idx + 1) - 1, section: idx + 1)
            
            guard let firstCellFrame = collectionView.layoutAttributesForItem(at: firstIndexPath)?.frame, let lastCellFrame = collectionView.layoutAttributesForItem(at: lastIndexPath)?.frame else {
                continue
            }
            
            label.sizeToFit()
            
            let labelPadding = (view.frame.size.height * (1 / 8) - label.frame.size.height) / 2
            
            let startPoint = firstCellFrame.origin.x
            let endPoint = lastCellFrame.origin.x + lastCellFrame.size.width - collectionView.frame.size.width
            
            let currentPoint = view.convert(CGPoint.zero, to: collectionView).x
            let percentage = endPoint - startPoint == 0 ? 0 : (currentPoint - startPoint) / (endPoint - startPoint)
            
            let minimumPoint = collectionView.convert(CGPoint(x: startPoint, y: 0), to: view).x + labelPadding
            let maximumPoint = collectionView.convert(CGPoint(x: endPoint, y: 0), to: view).x + collectionView.frame.size.width - label.frame.size.width - labelPadding
            let x = min(max(labelPadding + percentage * (collectionView.frame.size.width - label.frame.size.width - labelPadding * 2), minimumPoint), maximumPoint)
            let y = view.frame.size.height - 50 - label.frame.size.height / 2
            
            let frame = CGRect(x: x, y: y, width: label.frame.size.width, height: label.frame.size.height)
            label.frame = frame
            
            let horizontalMargin: CGFloat = min(48, x - minimumPoint, maximumPoint - (x + label.frame.size.width))
            
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            yearLabelBackgrounds[idx].frame = CGRect(x: x - horizontalMargin, y: y, width: label.frame.size.width + 2 * horizontalMargin, height: label.frame.size.height)
            CATransaction.commit()
        }
    }
    
    // MARK: UICollectionViewDelegateFlowLayout Methods
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return view.frame.size
        default:
            switch indexPath.row {
            case 0, events[indexPath.section - 1].count + 1:
                return CGSize(width: view.frame.size.width / 4, height: view.frame.size.height * (7 / 16))
            default:
                return CGSize(width: view.frame.size.width / 2, height: view.frame.size.height * (7 / 16))
            }
        }
    }
}
