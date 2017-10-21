//
//  EventCell.swift
//  Timeline
//
//  Created by Jack Cook on 8/8/17.
//  Copyright © 2017 Jack Cook. All rights reserved.
//

import AVKit
import UIKit

protocol EventCellDelegate {
    func eventCell(_ cell: EventCell, didTapVideoWith playerLayer: AVPlayerLayer, frame: CGRect)
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
    @IBOutlet weak var mediaView: UIView!
    @IBOutlet weak var monthLabel: UILabel?
    
    private var playerLayer: AVPlayerLayer?
    
    var event: Event? {
        didSet {
            guard let event = event else {
                return
            }
            
            label.text = event.name
            monthLabel?.text = event.date.monthName
            
            generateMediaView()
        }
    }
    
    // MARK: - View Life Cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        playerLayer?.removeFromSuperlayer()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let playerLayer = playerLayer, let naturalSize = playerLayer.player?.currentItem?.asset.tracks(withMediaType: .video).first?.naturalSize else {
            return
        }
        
        let adjustedSize = CGSize(width: naturalSize.width * (mediaView.frame.size.height / naturalSize.height), height: mediaView.frame.size.height)
        playerLayer.frame = CGRect(x: (mediaView.frame.size.width - adjustedSize.width) / 2, y: 0, width: adjustedSize.width, height: adjustedSize.height)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let playerLayer = playerLayer, mediaView.frame.contains(point) else {
            return nil
        }
        
        delegate?.eventCell(self, didTapVideoWith: playerLayer, frame: convert(playerLayer.frame, to: self))
        
        return self
    }
    
    // MARK: - Public Methods
    
    func generateMediaView() {
        guard let video = event?.video, let mediaView = mediaView, let path = Bundle.main.path(forResource: video, ofType: "mp4") else {
            return
        }
        
        let url = URL(fileURLWithPath: path)
        
        let player = AVPlayer(url: url)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.borderColor = UIColor.white.cgColor
        playerLayer?.borderWidth = 2
        playerLayer?.cornerRadius = 4
        
        guard let playerLayer = playerLayer, let naturalSize = playerLayer.player?.currentItem?.asset.tracks(withMediaType: .video).first?.naturalSize else {
            fatalError("issue creating player layer")
        }
        
        let adjustedSize = CGSize(width: naturalSize.width * (mediaView.frame.size.height / naturalSize.height), height: mediaView.frame.size.height)
        playerLayer.frame = CGRect(x: (mediaView.frame.size.width - adjustedSize.width) / 2, y: 0, width: adjustedSize.width, height: adjustedSize.height)
        
        mediaView.layer.addSublayer(playerLayer)
    }
}
