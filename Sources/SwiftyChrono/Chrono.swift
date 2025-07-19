//
//  Chrono.swift
//  SwiftyChrono
//
//  Created by Jerry Chen on 1/18/17.
//  Copyright © 2017 Potix. All rights reserved.
//

import Foundation

public struct Chrono {
    
    // --------------
    // MARK: - Static
    // --------------
    
    public static let strict = Chrono(modeOption: strictModeOption())
    
    public static let casual = Chrono(modeOption: casualModeOption())
    
    // ------------------
    // MARK: - Properties
    // ------------------
    
    /// iOS's Calender.Component to date that has 6 minutes less if the date is before 1900 (compared to JavaScript or Java)
    /// If your use case will include both be ealier than 1900 and its minutes, seconds, nanoseconds, (milliseconds)
    /// you should turn on this fix.
    public static var sixMinutesFixBefore1900 = false
    
    /// you can set default imply hour
    public static var defaultImpliedHour: Int = 12
    
    /// you can set default imply minute
    public static var defaultImpliedMinute: Int = 0
    
    /// you can set default imply second
    public static var defaultImpliedSecond: Int = 0
    
    /// you can set default imply millisecond
    public static var defaultImpliedMillisecond: Int = 0
    
    let modeOption: ModeOption
    
    var parsers: [Parser] { modeOption.parsers }
    
    var refiners: [Refiner] { modeOption.refiners }
    
    // ------------
    // MARK: - Init
    // ------------

    public init(modeOption: ModeOption = casualModeOption()) {
        
        self.modeOption = modeOption
        
    }
    
    // -------------
    // MARK: - Parse
    // -------------
    
    public func parse(
        text: String,
        refDate: Date = Date(),
        languages: Set<Language> = [.english],
        opt: [OptionType: OptionValue] = [:]
    ) -> [ParsedResult] {
        
        var allResults = [ParsedResult]()
        
        if text.isEmpty {
            
            return allResults
            
        }
        
        // first phase: preferredLanguage parsers
        for parser in parsers {
            
            if languages.contains(parser.language) {
                
                allResults += parser.execute(text: text, ref: refDate, opt: opt)
                
            }
            
        }
        
        allResults.sort { $0.index < $1.index }
        
        for refiner in refiners {
            
            allResults = refiner.refine(text: text, results: allResults, opt: opt)
            
        }
        
        return allResults
        
    }
    
    public func parseDate(
        text: String,
        refDate: Date = Date(),
        languages: Set<Language> = [.english],
        opt: [OptionType: OptionValue] = [:]
    ) -> Date? {
        
        Chrono.casual.parse(text: text, refDate: refDate, languages: languages, opt: opt)
            .first?
            .start
            .date
        
    }
    
}
