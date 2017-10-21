//
//  EventCell.swift
//  Timeline
//
//  Created by Jack Cook on 8/8/17.
//  Copyright © 2017 Jack Cook. All rights reserved.
//

import AVKit
import UIKit

class EventCell: UICollectionViewCell {
    
    // MARK: - Constants
    
    static let topIdentifier = "EventCellTop"
    static let topNib = UINib(nibName: EventCell.topIdentifier, bundle: Bundle.main)
    
    static let bottomIdentifier = "EventCellBottom"
    static let bottomNib = UINib(nibName: EventCell.bottomIdentifier, bundle: Bundle.main)
    
    // MARK: - Properties
    
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
            
            guard let video = event.video, let mediaView = mediaView, let path = Bundle.main.path(forResource: video, ofType: "mp4") else {
                return
            }
            
            let url = URL(fileURLWithPath: path)
            
            let player = AVPlayer(url: url)
            playerLayer = AVPlayerLayer(player: player)
            playerLayer?.frame = mediaView.bounds
            
            guard let playerLayer = playerLayer else {
                fatalError("issue creating player layer")
            }
            
            mediaView.layer.addSublayer(playerLayer)
            player.play()
        }
    }
    
    // MARK: - View Life Cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        playerLayer?.removeFromSuperlayer()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        playerLayer?.frame = mediaView?.bounds ?? .zero
    }
}
