//
//  ARMatchingNode.swift
//  AdrianRubio
//
//  Created by Adrián Rubio on 4/24/15.
//  Copyright (c) 2015 Ment. All rights reserved.
//

import Foundation
import UIKit

class ARMatchingNode: ARNode {
    
    let animationDuration = 0.4
    
    let colors = [
        UIColor(red:0.06, green:0.44, blue:0.59, alpha:1.0),
        UIColor(red:0.79, green:0.0, blue:0.16, alpha:1.0),
        UIColor(red:0.88, green:0.76, blue:0.01, alpha:1.0),
        UIColor(red:0.03, green:0.84, blue:0.51, alpha:1.0)
    ]
    
    var colorIndex = 0 {
        didSet{
            
            if self.colorIndex > (colors.count-1) { self.colorIndex = 0 }
            if self.colorIndex < 0 { self.colorIndex = (colors.count-1) }
            
            var identity = CATransform3DIdentity;
            identity.m34 = 1.0 / -500;
            identity = CATransform3DRotate(identity, CGFloat(180 * M_PI / 180.0), CGFloat(0), CGFloat(1), CGFloat(0));
            
            UIView.animateWithDuration(self.animationDuration, delay: 0.0, options: UIViewAnimationOptions.BeginFromCurrentState, animations: { () -> Void in
                self.layer.transform = identity
                self.backgroundColor = self.colors[self.colorIndex]
                
                }) { (f:Bool) -> Void in
                    
                    self.layer.transform = CATransform3DIdentity
            }
            
            
            
            
        }
    }
    
    override init(radius: CGFloat, center: CGPoint) {
        super.init(radius: radius, center: center)
        self.randomize()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        self.swapColor()
    }
    
    func randomize()
    {
        self.colorIndex = Int( arc4random_uniform(CUnsignedInt(self.colors.count)) )
    }
    
    func swapColor()
    {
       self.colorIndex++
    }
    
}