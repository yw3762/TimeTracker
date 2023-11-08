//
//  Extensions.swift
//  TimeTracking
//
//  Created by Alex Wang on 11/6/23.
//

import Foundation

typealias TimeMS = Int64

extension TimeMS {
    var hourMinuteSecond: String {
        String(format:"%d:%02d:%02d", hour, minute, second)
    }
    var minuteSecondMS: String {
        String(format:"%d:%02d.%03d", minute, second, millisecond)
    }
    var hour: Int {
        Int((Double(self)/3600000))
    }
    var minute: Int {
        Int((Double(self)/60000).truncatingRemainder(dividingBy: 60))
    }
    var second: Int {
        Int((Double(self)/1000).truncatingRemainder(dividingBy: 60))
    }
    var millisecond: Int {
        Int((Double(self)).truncatingRemainder(dividingBy: 1000))
    }
}

extension Date {
    var millisecondsSince1970:TimeMS {
        Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:TimeMS) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}
