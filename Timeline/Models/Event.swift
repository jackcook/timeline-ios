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
    
    init(_ name: String, _ day: Int, _ month: Int, _ year: Int) {
        self.name = name
        
        var components = DateComponents()
        components.day = day
        components.month = month
        components.year = 2000 + year
        
        if let date = Calendar.current.date(from: components) {
            self.date = date
        } else {
            fatalError("Could not parse date")
        }
    }
    
    static let easyMeasure = Event("EasyMeasure is released", 08, 20, 13)
    static let elementAnimation = Event("Element Animation is released", 01, 14, 14)
    static let mcproHosting = Event("Joined MCProHosting", 06, 26, 14)
    static let beamCreation = Event("Started Beam", 08, 19, 14)
    static let hackTheNorth = Event("Attended Hack the North", 09, 19, 14)
    static let hackUpstate = Event("Won 2nd place overall at Hack Upstate", 10, 03, 14)
    static let hackRU = Event("Won Pebble API prize at HackRU", 10, 11, 14)
    static let firstLocalHackDay = Event("Gave a talk on iOS development at the first Local Hack Day", 12, 06, 14)
    static let hackGenY = Event("Won 2nd place overall at Hack Gen Y", 01, 24, 15)
}
