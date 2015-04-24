//
//  ARMixingNode.swift
//  AdrianRubio
//
//  Created by Adrián Rubio on 4/22/15.
//  Copyright (c) 2015 Ment. All rights reserved.
//

import Foundation
import SpriteKit

class ARMixingNode: SKShapeNode {
    weak var gameViewController:GameViewController?
    var dragOffset = CGPointZero
    
    override init()
    {
        super.init()
        self.userInteractionEnabled = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        for touch: AnyObject in touches {
            
            self.dragOffset = touch.locationInNode(self)
            
        }
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesMoved(touches, withEvent: event)

        for touch: AnyObject in touches {
            if let p = self.parent
            {
                let location = touch.locationInNode(p)
                self.position = CGPoint(x: location.x - self.dragOffset.x, y: location.y - self.dragOffset.y)
            }
    
    
        }
    }
}