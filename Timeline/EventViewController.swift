//
//  EventViewController.swift
//  Timeline
//
//  Created by Jack Cook on 9/22/17.
//  Copyright © 2017 Jack Cook. All rights reserved.
//

import UIKit

class EventViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        visualEffectView.effect = nil
    }
    
    func animate() {
        UIView.animate(withDuration: 0.4) {
            self.visualEffectView.effect = UIBlurEffect(style: .light)
        }
    }
}
