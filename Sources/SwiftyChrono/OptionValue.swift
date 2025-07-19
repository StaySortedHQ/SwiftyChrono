//
//  OptionValue.swift
//  SwiftyChrono
//
//  Created by Changwat Tumwattana on 19/7/2025.
//

public enum OptionValue {
    
    // -------------
    // MARK: - Cases
    // -------------

    case time(hour: Int, minute: Int)
    case on
    
    // ------------------
    // MARK: - Properties
    // ------------------

    var hour: Int {
        
        switch self {
        case .time(let hour, _): hour
        case .on: 0
        }
        
    }
    
    var minute: Int {
        
        switch self {
        case .time(_, let minute): minute
        case .on: 0
        }
        
    }
    
}
