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
        
        self.backgroundColor = UIColor(red:0.81, green:0.93, blue:0.59, alpha:1.0)
        
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}