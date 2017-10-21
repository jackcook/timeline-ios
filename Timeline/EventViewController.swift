//
//  EventViewController.swift
//  Timeline
//
//  Created by Jack Cook on 9/22/17.
//  Copyright © 2017 Jack Cook. All rights reserved.
//

import AVKit
import UIKit

class EventViewController: UIViewController {
    
    var videoURL: URL!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    
    private var player: AVPlayer!
    private var playerLayer: AVPlayerLayer!
    
    private var playerLayerFrame: CGRect {
        if let naturalSize = player.currentItem?.asset.tracks(withMediaType: .video).first?.naturalSize {
            let screen = UIScreen.main.bounds
            let fullHeight = screen.size.height * 0.75
            let width = screen.size.width * 0.75
            let height = width * (fullHeight / naturalSize.height)
            return CGRect(x: 0, y: (fullHeight - height) / 2, width: width, height: height)
        } else {
            return .zero
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        player = AVPlayer(url: videoURL)
        playerLayer = AVPlayerLayer(player: player)
        containerView.layer.addSublayer(playerLayer)
        
        playerLayer.frame = playerLayerFrame
        playerLayer.shadowColor = UIColor.black.cgColor
        playerLayer.shadowOffset = CGSize(width: 0, height: 5)
        playerLayer.shadowOpacity = 1
        playerLayer.shadowRadius = 8
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: Notification.Name.AVPlayerItemDidPlayToEndTime, object: playerLayer.player?.currentItem)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        player.play()
        
        playerLayer.frame = playerLayerFrame
    }
    
    @objc private func playerDidFinishPlaying(notification: Notification) {
        dismiss(animated: true)
        
        NotificationCenter.default.removeObserver(self)
    }
}
