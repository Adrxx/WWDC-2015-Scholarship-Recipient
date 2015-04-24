
//
//  ARNode.swift
//  AdrianRubio
//
//  Created by Adrián Rubio on 4/18/15.
//  Copyright (c) 2015 Ment. All rights reserved.
//

import Foundation
import SpriteKit


/*
    Arnodes are the living creatures of this project...
    Arnodes love to play games and tell stories (in that order)
*/
class ARNode: UIView
{
    weak var gameViewController:GameViewController? //So a node can send challengeWon()
    var originalFrame = CGRectZero
    
    override var frame:CGRect {
        get
        {
            return self.originalFrame
        }
        set
        {
            self.originalFrame = newValue
            
            super.frame = CGRect(
                x:self.originalFrame.origin.x - newValue.size.width/2,
                y:self.originalFrame.origin.y - newValue.size.height/2,
                width: newValue.width,
                height: newValue.height)
        }
    }
    
    
}