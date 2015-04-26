//
//  ARClearingNode.swift
//  AdrianRubio
//
//  Created by Adrián Rubio on 4/25/15.
//  Copyright (c) 2015 Ment. All rights reserved.
//

import Foundation
import UIKit

class ARClearingNode: ARNode {
    
    weak var pusher:UIPushBehavior!

    
    override init(radius: CGFloat, center: CGPoint) {
        super.init(radius: radius, center: center)
        
        self.backgroundColor = UIColor.brownColor()
        
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}