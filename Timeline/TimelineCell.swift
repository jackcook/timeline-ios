//
//  TimelineCell.swift
//  Timeline
//
//  Created by Jack Cook on 8/8/17.
//  Copyright © 2017 Jack Cook. All rights reserved.
//

enum TimelineCell {
    case start
    case fill
    case event(Event)
    case end
    
    func identifier(position: TimelineCellPosition) -> String {
        switch self {
        case .fill:
            return FillCell.identifier
        case .start:
            return StartCell.identifier
        case .event(_):
            return position == .top ? EventCell.topIdentifier : EventCell.bottomIdentifier
        case .end:
            return "EndCell"
        }
    }
}

enum TimelineCellPosition {
    case top, bottom
}
