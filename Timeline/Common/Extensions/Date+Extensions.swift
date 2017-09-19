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
        return Calendar.current.dateComponents([.day], from: .zero, to: self).day ?? 0
    }
    
    var month: Int {
        return Calendar.current.dateComponents([.month], from: .zero, to: self).month ?? 0
    }
    
    var year: Int {
        return Calendar.current.dateComponents([.year], from: .zero, to: self).year ?? 0
    }
}
