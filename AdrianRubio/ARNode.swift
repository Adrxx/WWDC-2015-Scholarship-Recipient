
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

let SHRINKING_DURATION = 0.5

class ARNode: UIView
{
    weak var gameViewController:GameViewController? //So a node can send challengeWon()
    private var originalFrame = CGRectZero
    private var originalRadius:CGFloat = 0
    let shrinkValue:CGFloat = 15
    
    override var frame:CGRect {
        get {
            return self.originalFrame
        }
        set {
            //This is to make the nodes grow from their center
            self.originalFrame = newValue
            self.layer.cornerRadius = self.frame.width/2
            super.frame = CGRect(
                x:self.originalFrame.origin.x - newValue.size.width/2,
                y:self.originalFrame.origin.y - newValue.size.height/2,
                width: newValue.width,
                height: newValue.height)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.originalRadius = self.frame.width/2
    }
    
    convenience init(radius: CGFloat, center: CGPoint) {
        self.init(frame: CGRect(x: center.x, y: center.y, width: radius*2, height: radius*2))
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

    
    
}