//
//  DEMergeDateTimeRefiner.swift
//  SwiftyChrono
//
//  Created by Jerry Chen on 2/17/17.
//  Copyright © 2017 Potix. All rights reserved.
//

import Foundation

final class DEMergeDateTimeRefiner: MergeDateTimeRefiner {
    
    override var PATTERN: String {
        
        "^\\s*(T|vor|nach|um|,|-)?\\s*$"
        
    }
    
    override var TAGS: TagUnit {
        
        .deMergeDateAndTimeRefiner
        
    }
    
}
