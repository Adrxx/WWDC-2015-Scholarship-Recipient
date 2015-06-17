//
//  ARPairingNode.swift
//  AdrianRubio
//
//  Created by Adrián Rubio on 4/25/15.
//  Copyright (c) 2015 Ment. All rights reserved.
//

import Foundation
import UIKit


class ARPairingNode: ARNode {
    
    let animationsDuration = 0.5
    let unrevealedColor = UIColor.lightGrayColor()
    let pairColors = [
       UIColor(red:0.45, green:0.47, blue:0.79, alpha:1.0),
       UIColor(red:0.64, green:0.83, blue:0.71, alpha:1.0),
        UIColor(red:1.0, green:0.81, blue:0.61, alpha:1.0)  
    ]
    
    var pairId:Int
    var revealed = false
    
    init(radius: CGFloat, center: CGPoint, pairId:Int) {
        self.pairId = pairId
        super.init(radius: radius, center: center)
        
        self.backgroundColor = self.unrevealedColor
    }
    
    required init(coder aDecoder: NSCoder) {
        self.pairId = 0
        super.init(coder: aDecoder)
        
    }
    
    func reveal()
    {
        self.revealed = true
        var identity = CATransform3DIdentity;
        identity.m34 = 1.0 / -500;
        identity = CATransform3DRotate(identity, CGFloat(180 * M_PI / 180.0), CGFloat(0), CGFloat(1), CGFloat(0));
        
        UIView.animateWithDuration(self.animationsDuration, animations: { () -> Void in
            self.layer.transform = identity
            self.backgroundColor = self.pairColors[self.pairId]
        },completion:nil)
    }
    
    func unreveal()
    {
        self.revealed = false
        var identity = CATransform3DIdentity;
        identity.m34 = 1.0 / -500;
        identity = CATransform3DRotate(identity, CGFloat(0 * M_PI / 180.0), CGFloat(0), CGFloat(1), CGFloat(0));
        
        UIView.animateWithDuration(self.animationsDuration, animations: { () -> Void in
            self.layer.transform = identity
            self.backgroundColor = self.unrevealedColor

        }, completion:nil)
        
    }
    
    func fadeOut() {
        
        UIView.animateWithDuration(self.animationsDuration, delay: self.animationsDuration,options:[], animations: { () -> Void in
            self.alpha = 0.0
            
            }) { (finished: Bool) -> Void in
                self.removeFromSuperview()
        }
    }
    
    func reset()
    {
        self.revealed = false
        self.alpha = 1.0
        let identity = CATransform3DIdentity;
        self.layer.transform = identity
        self.backgroundColor = self.unrevealedColor
    }
    
    
}