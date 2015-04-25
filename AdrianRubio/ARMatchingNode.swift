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
    
    let animationDuration = 0.1
    
    let colors:[UIColor] = [
        .yellowColor(),
        .cyanColor(),
        .orangeColor(),
        .redColor(),
        .greenColor()
    ]
    
    var colorIndex = 0 {
        didSet{
            
            if self.colorIndex > (colors.count-1) { self.colorIndex = 0 }
            if self.colorIndex < 0 { self.colorIndex = (colors.count-1) }
            
            UIView.animateWithDuration(animationDuration, delay: 0.0, options: UIViewAnimationOptions.AllowUserInteraction | UIViewAnimationOptions.BeginFromCurrentState, animations: { () -> Void in
                
                self.backgroundColor = self.colors[self.colorIndex]
                
                }, completion:nil)
            
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