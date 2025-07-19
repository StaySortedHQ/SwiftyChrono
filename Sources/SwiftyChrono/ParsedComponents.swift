//
//  ParsedComponents.swift
//  SwiftyChrono
//
//  Created by Jerry Chen on 1/17/17.
//  Copyright © 2017 Potix. All rights reserved.
//

import Foundation

public struct ParsedComponents {
    
    // ------------------
    // MARK: - Properties
    // ------------------

    public var knownValues = [ComponentUnit: Int]()
    
    public var impliedValues = [ComponentUnit: Int]()
    
    // ------------
    // MARK: - Init
    // ------------

    init(components: [ComponentUnit: Int]?, ref: Date?) {
        
        if let components = components {
            
            knownValues = components
            
        }
        
        if let ref = ref {
            
            imply(.day, to: ref.day)
            
            imply(.month, to: ref.month)
            
            imply(.year, to: ref.year)
            
        }
        
        imply(.hour, to: Chrono.defaultImpliedHour)
        
        imply(.minute, to: Chrono.defaultImpliedMinute)
        
        imply(.second, to: Chrono.defaultImpliedSecond)
        
        imply(.millisecond, to: Chrono.defaultImpliedMillisecond)
        
    }
    
    private init(parsedComponents: ParsedComponents) {
        
        knownValues = parsedComponents.knownValues
        
        impliedValues = parsedComponents.impliedValues
        
    }
    
    // -------------
    // MARK: - Clone
    // -------------
    
    public func clone() -> ParsedComponents {
        
        ParsedComponents(parsedComponents: self)
        
    }
    
    // -----------------
    // MARK: - Subscript
    // -----------------
    
    public subscript(component: ComponentUnit) -> Int? {
        
        if knownValues.keys.contains(component) {
            
            return knownValues[component]!
            
        }
        
        if impliedValues.keys.contains(component) {
            
            return impliedValues[component]!
            
        }
        
        return nil
        
    }
    
    // --------------
    // MARK: - Assign
    // --------------
    
    public mutating func assign(_ component: ComponentUnit, value: Int?) {
        
        if let value = value {
            
            knownValues[component] = value
            
            impliedValues.removeValue(forKey: component)
            
        }
        
    }
    
    // -------------
    // MARK: - Imply
    // -------------
    
    public mutating func imply(_ component: ComponentUnit, to value: Int?) {
        
        guard let value = value else {
            
            return
            
        }
        
        if knownValues.keys.contains(component) { return }
        
        impliedValues[component] = value
        
    }
    
    // ------------------
    // MARK: - Is Certain
    // ------------------
    
    public func isCertain(component: ComponentUnit) -> Bool {
        
        knownValues.keys.contains(component)
        
    }
    
    // ------------------------
    // MARK: - Is Possible Date
    // ------------------------
    
    public func isPossibleDate() -> Bool {
        
        var date = moment
        
        var isUTC = false
        
        if isCertain(component: .timeZoneOffset) {
            
            // iOS only: in moment.js lib, set utcOffset will turn on isUTC, so the getter will count on utc based time zone
            isUTC = true
            
            date.utcOffset = self[.timeZoneOffset]!
            
        }
        
        if (isUTC ? date.utcYear : date.year) != self[.year] { return false }
        
        if (isUTC ? date.utcMonth : date.month) != self[.month] { return false }
        
        if (isUTC ? date.utcDay : date.day) != self[.day] { return false }
        
        if (isUTC ? date.utcHour : date.hour) != self[.hour] { return false }
        
        if (isUTC ? date.utcMinute : date.minute) != self[.minute] { return false }
        
        return true
        
    }
    
    // ------------
    // MARK: - Date
    // ------------
    
    public var date: Date {
        
        moment
        
    }
    
    // --------------
    // MARK: - Moment
    // --------------
    
    public var moment: Date {
        
        var comps = DateComponents()
        
        if let year = self[.year] {
            
            comps.year = year
            
        }
        
        if let month = self[.month] {
            
            comps.month = month
            
        }
        
        if let day = self[.day] {
            
            comps.day = day
            
        }
        
        if let hour = self[.hour] {
            
            comps.hour = hour
            
        }
        
        if let minute = self[.minute] {
            
            comps.minute = minute
            
        }
        
        if let second = self[.second] {
            
            comps.second = second
            
        }
        
        if let millisecond = self[.millisecond] {
            
            comps.nanosecond = millisecondsToNanoSeconds(millisecond)
            
        }
        
        let date = cal.date(from: comps)!
        
        let currenttimeZoneOffset = date.utcOffset
        
        let targettimeZoneOffset = isCertain(component: .timeZoneOffset) ? self[.timeZoneOffset]! : currenttimeZoneOffset
        
        let adjustedtimeZoneOffset = targettimeZoneOffset - currenttimeZoneOffset
        
        let newDate = date.added(-adjustedtimeZoneOffset, .minute)
        
        if Chrono.sixMinutesFixBefore1900 && newDate.utcYear < 1900 {
            
            return newDate.added(6, .minute)
            
        }
        
        return newDate
        
    }
    
}
