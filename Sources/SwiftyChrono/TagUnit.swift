//
//  TagUnit.swift
//  SwiftyChrono
//
//  Created by Changwat Tumwattana on 19/7/2025.
//

public enum TagUnit {
    
    case none
    
    case enCasualTimeParser
    case enCasualDateParser
    case enDeadlineFormatParser
    case enISOFormatParser
    case enMonthNameLittleEndianParser
    case enMonthNameMiddleEndianParser
    case enMonthNameParser
    case enRelativeDateFormatParser
    case enSlashDateFormatParser
    case enSlashDateFormatStartWithYearParser
    case enSlashMonthFormatParser
    case enTimeAgoFormatParser
    case enTimeExpressionParser
    case enWeekdayParser
    
    case esCasualDateParser
    case esDeadlineFormatParser
    case esMonthNameLittleEndianParser
    case esSlashDateFormatParser
    case esTimeAgoFormatParser
    case esTimeExpressionParser
    case esWeekdayParser
    
    case frCasualDateParser
    case frDeadlineFormatParser
    case frMonthNameLittleEndianParser
    case frSlashDateFormatParser
    case frTimeAgoFormatParser
    case frTimeExpressionParser
    case frWeekdayParser
    
    case jpCasualDateParser
    case jpStandardParser
    
    case deCasualTimeParser
    case deCasualDateParser
    case deDeadlineFormatParser
    case deMonthNameLittleEndianParser
    case deSlashDateFormatParser
    case deTimeAgoFormatParser
    case deTimeExpressionParser
    case deWeekdayParser
    case deMorgenTimeParser
    
    case zhHantCasualDateParser
    case zhHantDateParser
    case zhHantDeadlineFormatParser
    case zhHantTimeExpressionParser
    case zhHantWeekdayParser
    
    case extractTimezoneAbbrRefiner
    case extractTimezoneOffsetRefiner
    case forwardDateRefiner
    
    case enMergeDateAndTimeRefiner
    case enMergeDateRangeRefiner
    case enPrioritizeSpecificDateRefiner
    
    case frMergeDateRangeRefiner
    case frMergeDateAndTimeRefiner
    
    case deMergeDateAndTimeRefiner
    case deMergeDateRangeRefiner
    
}
