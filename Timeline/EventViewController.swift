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
    
    var playerLayer: AVPlayerLayer!
    var playerLayerFrame: CGRect!
    var sourceCell: EventCell!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerLayer.removeFromSuperlayer()
        containerView.layer.addSublayer(playerLayer)
        
        playerLayer.frame = view.convert(playerLayerFrame, to: containerView)
        
        sourceCell.generateMediaView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: Notification.Name.AVPlayerItemDidPlayToEndTime, object: playerLayer.player?.currentItem)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.4) {
            self.playerLayer.frame = self.containerView.bounds
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        playerLayer.removeFromSuperlayer()
        
        UIView.animate(withDuration: 0.4) {
            self.playerLayer.frame = self.playerLayerFrame
        }
    }
    
    @objc private func playerDidFinishPlaying(notification: Notification) {
        dismiss(animated: true)
        
        NotificationCenter.default.removeObserver(self)
    }
}
