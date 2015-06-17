
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
    var radius:CGFloat = 0 {
        didSet
        {
            //nodes are circles
            self.layer.cornerRadius = self.radius
            let cent = self.center
            self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.radius*2, height: self.radius*2)
            self.center = cent
        }
    }
    
    
    init(radius: CGFloat, center: CGPoint) {
        self.radius = radius
        super.init(frame: CGRect(x: 0, y: 0, width: radius*2, height: radius*2))
        self.center = center
        self.layer.cornerRadius = self.radius

    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
}