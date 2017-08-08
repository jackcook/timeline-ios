//
//  Event.swift
//  Timeline
//
//  Created by Jack Cook on 8/8/17.
//  Copyright © 2017 Jack Cook. All rights reserved.
//

import Foundation

struct Event {
    let name: String
    let date: Date
    
    var month: Int {
        return Calendar.current.dateComponents([.month], from: Date(timeIntervalSince1970: 0), to: date).month ?? 0
    }
}
