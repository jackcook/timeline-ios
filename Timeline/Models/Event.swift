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
    
    var year: Int {
        return Calendar.current.dateComponents([.year], from: Date(timeIntervalSince1970: 0), to: date).year ?? 0
    }
    
    init(data: [String: Any]) {
        guard let name = data["Name"] as? String, let date = data["Date"] as? Date else {
            fatalError("Error loading events from plist file")
        }
        
        self.name = name
        self.date = date
    }
    
    static func loadAllEvents() -> [Event] {
        if let url = Bundle.main.url(forResource: "Events", withExtension: "plist"), let contents = NSArray(contentsOf: url) as? [[String: Any]] {
            var events = [Event]()
            
            for data in contents {
                let event = Event(data: data)
                events.append(event)
            }
            
            return events.sorted(by: { $0.date < $1.date })
        }
        
        return [Event]()
    }
}
