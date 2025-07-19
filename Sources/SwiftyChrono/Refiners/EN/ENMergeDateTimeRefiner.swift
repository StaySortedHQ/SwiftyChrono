//
//  ENMergeDateTimeRefiner.swift
//  SwiftyChrono
//
//  Created by Jerry Chen on 1/19/17.
//  Copyright © 2017 Potix. All rights reserved.
//

import Foundation

final class ENMergeDateTimeRefiner: MergeDateTimeRefiner {
    
    override var PATTERN: String {
        
        "^\\s*(T|at|after|before|on|of|,|-)?\\s*$"
        
    }
    
    override var TAGS: TagUnit {
        
        .enMergeDateAndTimeRefiner
        
    }
    
}
