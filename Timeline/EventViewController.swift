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
    
    var image: UIImage?
    var videoURL: URL?
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    
    private var imageView: UIImageView?
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    
    private var imageViewFrame: CGRect {
        if let naturalSize = imageView?.image?.size {
            let screen = UIScreen.main.bounds
            let fullHeight = screen.size.height * 0.75
            let width = screen.size.width * 0.75
            let height = width * (naturalSize.height / naturalSize.width)
            return CGRect(x: 0, y: (fullHeight - height) / 2, width: width, height: height)
        } else {
            return .zero
        }
    }
    
    private var playerLayerFrame: CGRect {
        if let naturalSize = player?.currentItem?.asset.tracks(withMediaType: .video).first?.naturalSize {
            let screen = UIScreen.main.bounds
            let fullHeight = screen.size.height * 0.75
            let width = screen.size.width * 0.75
            let height = width * (naturalSize.height / naturalSize.width)
            return CGRect(x: 0, y: (fullHeight - height) / 2, width: width, height: height)
        } else {
            return .zero
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let videoURL = videoURL {
            player = AVPlayer(url: videoURL)
            playerLayer = AVPlayerLayer(player: player)
            containerView.layer.addSublayer(playerLayer!)
            
            playerLayer?.frame = playerLayerFrame
            playerLayer?.shadowColor = UIColor.black.cgColor
            playerLayer?.shadowOffset = CGSize(width: 0, height: 5)
            playerLayer?.shadowOpacity = 1
            playerLayer?.shadowRadius = 8
            
            NotificationCenter.default.addObserver(self, selector: #selector(shouldDismiss), name: Notification.Name.AVPlayerItemDidPlayToEndTime, object: playerLayer?.player?.currentItem)
        } else if let image = image {
            imageView = UIImageView(image: image)
            imageView?.frame = imageViewFrame
            containerView.addSubview(imageView!)
            
            imageView?.layer.shadowColor = UIColor.black.cgColor
            imageView?.layer.shadowOffset = CGSize(width: 0, height: 5)
            imageView?.layer.shadowOpacity = 1
            imageView?.layer.shadowRadius = 8
            
            let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(shouldDismiss))
            visualEffectView.addGestureRecognizer(gestureRecognizer)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        player?.play()
        
        imageView?.frame = imageViewFrame
        playerLayer?.frame = playerLayerFrame
    }
    
    @objc private func shouldDismiss() {
        dismiss(animated: true)
        
        NotificationCenter.default.removeObserver(self)
    }
}
