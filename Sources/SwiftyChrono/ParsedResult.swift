//
//  ParsedResult.swift
//  SwiftyChrono
//
//  Created by Changwat Tumwattana on 19/7/2025.
//

import Foundation

public struct ParsedResult {
    
    // ------------------
    // MARK: - Properties
    // ------------------

    public let ref: Date
    
    public var index: Int
    
    public var text: String
    
    public var tags: [TagUnit: Bool]
    
    public var start: ParsedComponents
    
    public var end: ParsedComponents?
    
    // used for parsing logic control
    public let isMoveIndexMode: Bool
    
    // ------------
    // MARK: - Init
    // ------------
    
    public init(
        ref: Date,
        index: Int,
        text: String,
        tags: [TagUnit: Bool] = [TagUnit: Bool](),
        start: [ComponentUnit: Int]? = nil,
        end: [ComponentUnit: Int]? = nil,
        isMoveIndexMode: Bool = false
    ) {
        
        self.ref = ref
        
        self.index = index
        
        self.text = text
        
        self.tags = tags
        
        self.start = ParsedComponents(components: start, ref: ref)
        
        if let end = end {
            
            self.end = ParsedComponents(components: end, ref: ref)
            
        }
        
        self.isMoveIndexMode = isMoveIndexMode
        
    }
    
    // -----------------
    // MARK: - Functions
    // -----------------
    
    static func moveIndexMode(index: Int) -> ParsedResult {
        
        self.init(ref: Date(), index: index, text: "", isMoveIndexMode: true)
        
    }
    
    func clone() -> ParsedResult {
        
        var result = ParsedResult(ref: ref, index: index, text: text, tags: tags)
        
        result.start = start
        
        result.end = end
        
        return result
        
    }
    
    func hasPossibleDates() -> Bool {
        
        start.isPossibleDate() && (end == nil || end!.isPossibleDate())
        
    }
    
}
