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
    
    init(_ name: String, _ month: Int, _ day: Int, _ year: Int) {
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
    
    // 2013
    static let easyMeasure = Event("EasyMeasure is released", 08, 20, 13)
    
    // 2014
    static let elementAnimation = Event("Element Animation is released", 01, 14, 14)
    static let mcproHosting = Event("Joined MCProHosting", 06, 26, 14)
    static let beamCreation = Event("Started Beam", 08, 19, 14)
    static let hackTheNorth = Event("Attended Hack the North", 09, 19, 14)
    static let hackUpstate = Event("Won 2nd place overall at Hack Upstate", 10, 03, 14)
    static let hackRU = Event("Won Pebble API prize at HackRU", 10, 11, 14)
    static let firstHackNY = Event("Attended hackNY Fall 2014", 10, 18, 14)
    static let codeDay = Event("Attended CodeDay NY 2014", 11, 08, 14)
    static let wildHacks = Event("Attended WildHacks 2014", 11, 22, 14)
    static let firstLocalHackDay = Event("Gave a talk on iOS development at the first Local Hack Day", 12, 06, 14)
    
    // 2015
    static let mHacks = Event("Attended MHacks V", 01, 16, 15)
    static let hackGenY = Event("Won 2nd place overall at Hack Gen Y", 01, 24, 15)
    static let uoftHacks = Event("Attended UofTHacks", 01, 30, 15)
    static let hackCooper = Event("Attended HackCooper", 02, 14, 15)
    static let mcHacks = Event("Won 3rd place overall at McHacks", 02, 21, 15)
    static let hackDFW = Event("Attended HackDFW 2015", 02, 28, 15)
    static let atomHacks = Event("Organized the first AtomHacks", 05, 30, 15)
    static let secondHackRU = Event("Won best solo hack at HackRU", 10, 03, 15)
    static let secondLocalHackDay = Event("Organized Bronx Science's first LocalHackDay", 10, 10, 15)
    
    // 2016
    static let techStars = Event("Began our time at TechStars Seattle", 02, 23, 16)
    static let hackNY = Event("Won first place overall at hackNY", 04, 04, 16)
    static let thirdHackRU = Event("Finalist at HackRU", 04, 18, 16)
    static let techCrunchDisrupt = Event("Beam wins TechCrunch Disrupt NY", 05, 11, 16)
    static let secondAtomHacks = Event("Organized the second AtomHacks", 05, 14, 16)
    static let microsoftAcquisition = Event("Beam is acquired by Microsoft", 08, 11, 16)
    static let thirdLocalHackDay = Event("Organized Bronx Science's second LocalHackDay", 12, 03, 16)
    
    // 2017
    static let topCharts = Event("Mixer places in the top 30 entertainment apps", 03, 31, 17)
    static let thirdAtomHacks = Event("Organized Bronx Science's third AtomHacks", 05, 13, 17)
    static let mixerRebrand = Event("Beam rebrands to Mixer", 05, 25, 17)
    static let microsoftSummer = Event("Spent my summer at Microsoft", 08, 29, 17)
}
