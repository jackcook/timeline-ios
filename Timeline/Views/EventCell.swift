//
//  EventCell.swift
//  Timeline
//
//  Created by Jack Cook on 8/8/17.
//  Copyright © 2017 Jack Cook. All rights reserved.
//

import MediaPlayer
import UIKit

protocol EventCellDelegate {
    func eventCell(_ cell: EventCell, didTapVideoWith url: URL)
    func eventCell(_ cell: EventCell, didTapPhotoWith photo: UIImage)
}

class EventCell: UICollectionViewCell {
    
    // MARK: - Constants
    
    static let topIdentifier = "EventCellTop"
    static let topNib = UINib(nibName: EventCell.topIdentifier, bundle: Bundle.main)
    
    static let bottomIdentifier = "EventCellBottom"
    static let bottomNib = UINib(nibName: EventCell.bottomIdentifier, bundle: Bundle.main)
    
    // MARK: - Properties
    
    var delegate: EventCellDelegate?
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var mediaView: UIImageView!
    @IBOutlet weak var mediaViewAspectRatio: NSLayoutConstraint!
    @IBOutlet weak var monthLabel: UILabel?
    
    var event: Event? {
        didSet {
            guard let event = event else {
                return
            }
            
            label.text = event.name
            monthLabel?.text = event.date.monthName
            
            if let video = event.video, let path = Bundle.main.path(forResource: video, ofType: "mp4") {
                let url = URL(fileURLWithPath: path)
                let asset = AVAsset(url: url)
                
                let generator = AVAssetImageGenerator(asset: asset)
                generator.generateCGImagesAsynchronously(forTimes: [NSValue(time: CMTimeMakeWithSeconds(0, 1))]) { time1, image, time2, result, error in
                    guard let image = image else {
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self.mediaView.clipsToBounds = true
                        self.mediaView.image = UIImage(cgImage: image)
                        self.mediaView.layer.borderColor = UIColor.white.cgColor
                        self.mediaView.layer.borderWidth = 2
                        self.mediaView.layer.cornerRadius = 4
                        self.mediaViewAspectRatio.constant = 0
                    }
                }
            } else if let name = event.photo, let photo = UIImage(named: name) {
                mediaView.clipsToBounds = true
                mediaView.image = photo
                mediaView.layer.borderColor = UIColor.white.cgColor
                mediaView.layer.borderWidth = 2
                mediaView.layer.cornerRadius = 4
                
                // Photo is portrait
                if photo.size.width / photo.size.height < 1 {
                    self.mediaViewAspectRatio.constant = -116
                } else {
                    self.mediaViewAspectRatio.constant = 0
                }
            }
        }
    }
    
    // MARK: - View Life Cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        mediaView.layer.borderWidth = 0
        mediaView.image = nil
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard mediaView.frame.contains(point) else {
            return nil
        }
        
        if let video = self.event?.video, let path = Bundle.main.path(forResource: video, ofType: "mp4") {
            let url = URL(fileURLWithPath: path)
            delegate?.eventCell(self, didTapVideoWith: url)
        } else if let name = self.event?.photo, let photo = UIImage(named: name) {
            delegate?.eventCell(self, didTapPhotoWith: photo)
        } else {
            return nil
        }
        
        return self
    }
}
