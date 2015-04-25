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
    
    let colors:[UIColor] = [
        .yellowColor(),
        .cyanColor(),
        .orangeColor(),
        .redColor(),
        .greenColor()
    ]
    
    var colorIndex = 0 {
        didSet{
            print("CHAN")
            if self.colorIndex > (colors.count-1) { self.colorIndex = 0 }
            if self.colorIndex < 0 { self.colorIndex = (colors.count-1) }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.colorIndex = Int( arc4random_uniform(CUnsignedInt(self.colors.count)) )
        self.swapColor() // Needed for a color to take effect.
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        self.swapColor()
        self.shrink()
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesEnded(touches, withEvent: event)
        self.unshrink()
    }
    
    func swapColor()
    {
       self.colorIndex++
        
        UIView.animateWithDuration(SHRINKING_DURATION, delay: 0.0, usingSpringWithDamping: 0.1, initialSpringVelocity: 5.0, options: UIViewAnimationOptions.AllowUserInteraction | UIViewAnimationOptions.BeginFromCurrentState, animations: { () -> Void in
            
            self.backgroundColor = self.colors[self.colorIndex]
            
            }, completion:nil)
    }
    
}