//
//  Date.swift
//  SwiftyChrono
//
//  Created by Jerry Chen on 1/17/17.
//  Copyright © 2017 Potix. All rights reserved.
//

import Foundation

var cal: Calendar { Calendar.current }

var utcCal: Calendar {
    
    var cal = Calendar(identifier: Calendar.Identifier.gregorian)
    
    cal.timeZone = utcTimeZone
    
    return cal
    
}

let utcTimeZone: TimeZone = TimeZone(identifier: "UTC")!

private let noneZeroComponents: Set<Calendar.Component> = [.year, .month, .day]

extension Date {
    
    func setOrAdded(_ value: Int, _ component: Calendar.Component) -> Date {
        
        let d = self
        
        var value = value
        
        switch component {
        case .year:
            
            value -= d.year
            
        case .month:
            
            value -= d.month
            
        case .day:
            
            value -= d.day
            
        case .hour:
            
            value -= d.hour
            
        case .minute:
            
            value -= d.minute
            
        case .second:
            
            value -= d.second
            
        case .nanosecond:
            
            value -= d.nanosecond
            
        case .weekday:
            
            value -= d.weekday
            
        default:
            
            assert(false, "unsupported component...")
            
        }
        
        return d.added(value, component)
        
    }
    
    func isAfter(_ other: Date) -> Bool {
        
        self.timeIntervalSince1970 > other.timeIntervalSince1970
        
    }
    
    var year: Int {
        
        cal.component(.year, from: self)
        
    }
    
    var month: Int {
        
        cal.component(.month, from: self)
        
    }
    
    var day: Int {
        
        cal.component(.day, from: self)
        
    }
    
    var hour: Int {
        
        cal.component(.hour, from: self)
        
    }
    
    var minute: Int {
        
        cal.component(.minute, from: self)
        
    }
    
    var second: Int {
        
        cal.component(.second, from: self)
        
    }
    
    var millisecond: Int {
        
        nanoSecondsToMilliseconds(cal.component(.nanosecond, from: self))
        
    }
    
    var nanosecond: Int {
        
        cal.component(.nanosecond, from: self)
        
    }
    
    var weekday: Int {
        
        // by default, start from 1. we mimic the moment.js' SPEC, start from 0
        cal.component(.weekday, from: self) - 1
        
    }
    
    var utcYear: Int {
        
        utcCal.component(.year, from: self)
        
    }
    
    var utcMonth: Int {
        
        utcCal.component(.month, from: self)
        
    }
    
    var utcDay: Int {
        
        utcCal.component(.day, from: self)
        
    }
    
    var utcHour: Int {
        
        utcCal.component(.hour, from: self)
        
    }
    
    var utcMinute: Int {
        
        utcCal.component(.minute, from: self)
        
    }
    
    var utcSecond: Int {
        
        utcCal.component(.second, from: self)
        
    }
    
    var utcMillisecond: Int {
        
        nanoSecondsToMilliseconds(utcCal.component(.nanosecond, from: self))
        
    }
    
    var utcNanosecond: Int {
        
        utcCal.component(.nanosecond, from: self)
        
    }
    
    var utcWeekday: Int {
        
        // by default, start from 1. we mimic the moment.js' SPEC, start from 0
        utcCal.component(.weekday, from: self) - 1
        
    }
    
    /// ask number of day in the current month.
    ///
    /// e.g. the "unit" will be .day, the "baseUnit" will be .month
    
    #warning("TODO: Rename inA to in")
    
    func numberOf(_ unit: Calendar.Component, inA baseUnit: Calendar.Component) -> Int? {
        
        if let range = cal.range(of: unit, in: baseUnit, for: self) {
            
            return range.upperBound - range.lowerBound
            
        }
        
        return nil
        
    }
    
    func differenceOfTimeInterval(to date: Date) -> TimeInterval {
        
        timeIntervalSince1970 - date.timeIntervalSince1970
        
    }
    
    /// offset minutes between UTC and current time zone, the value could be 60, 0, -60, etc.
    var utcOffset: Int {
        
        get {
            
            let timeZone = NSTimeZone.local
            
            let offsetSeconds = timeZone.secondsFromGMT(for: self)
            
            return offsetSeconds / 60
            
        }
        
        set {
            
            let interval = TimeInterval(newValue * 60)
            
            self = Date(timeInterval: interval, since: self)
            
        }
        
    }
    
    func added(_ value: Int, _ unit: Calendar.Component) -> Date {
        
        cal.date(byAdding: unit, value: value, to: self)!
        
    }
    
}

func millisecondsToNanoSeconds(_ milliseconds: Int) -> Int {
    
    milliseconds * 1000000
    
}

func nanoSecondsToMilliseconds(_ nanoSeconds: Int) -> Int {
    
    /// this convert is used to prevent from nanoseconds error
    /// test case, create a date with nanoseconds 11000000, and get it via Calendar.Component, you will get 10999998
    let doubleMs = Double(nanoSeconds) / 1000000
    
    let ms = Int(doubleMs)
    
    return doubleMs > Double(ms) ? ms + 1 : ms
    
}
