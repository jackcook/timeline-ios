//
//  Date+Extensions.swift
//  Timeline
//
//  Created by Jack Cook on 9/19/17.
//  Copyright © 2017 Jack Cook. All rights reserved.
//

import Foundation

extension Date {
    
    static var zero = Date(timeIntervalSince1970: 0)
    
    var day: Int {
        return Calendar.current.dateComponents([.day], from: self).day ?? 0
    }
    
    var month: Int {
        return Calendar.current.dateComponents([.month], from: self).month ?? 0
    }
    
    var monthName: String {
        return DateFormatter().monthSymbols[month - 1]
    }
    
    var year: Int {
        return Calendar.current.dateComponents([.year], from: self).year ?? 0
    }
}
