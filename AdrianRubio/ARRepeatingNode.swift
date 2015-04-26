//
//  ARRepeatingNode.swift
//  AdrianRubio
//
//  Created by Adrián Rubio on 4/24/15.
//  Copyright (c) 2015 Ment. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class ARRepeatingNode: ARNode {
    
    let tapDuration = 0.15
    let flasherSize:CGFloat = 15
    let flashColor = UIColor.orangeColor()
    let normalColor = UIColor.redColor()
    let tappedColor = UIColor.greenColor()
    
    weak var gameController:RepeatingGame?
    var buttonNode:ARNode!
    var flasherNode:ARNode!
    var identifier:Int!
    
    override init(radius: CGFloat, center: CGPoint) {
        super.init(radius: radius, center: center)
        
        self.flasherNode = ARNode(radius: radius/2, center: CGPoint(
            x: CGRectGetMidX(self.bounds),
            y: CGRectGetMidY(self.bounds)))
        self.flasherNode.backgroundColor = self.flashColor
        self.addSubview(self.flasherNode)
        
        self.buttonNode = ARNode(radius: radius, center: CGPoint(
            x: CGRectGetMidX(self.bounds),
            y: CGRectGetMidY(self.bounds)))
        
        self.buttonNode.backgroundColor = self.normalColor
        self.addSubview(self.buttonNode)
        
        let tapper = UITapGestureRecognizer(target: self, action: "tap")
        tapper.numberOfTapsRequired = 1
        tapper.numberOfTouchesRequired = 1
        
        self.buttonNode.addGestureRecognizer(tapper)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func flash()
    {
        let b = CABasicAnimation(keyPath: "bounds")
        b.fromValue = NSValue(CGRect: self.frame)
        b.toValue = NSValue(CGRect: CGRectInset(self.frame, -flasherSize, -flasherSize))
        
        let c = CABasicAnimation(keyPath:"cornerRadius")
        c.fromValue = self.frame.width/2
        c.toValue = CGRectInset(self.frame, -flasherSize, -flasherSize).width/2
        
        let o = CABasicAnimation(keyPath:"opacity")
        o.fromValue = 1
        o.toValue = 0
        
        let group = CAAnimationGroup()
        group.duration = 0.5
        
        group.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        group.animations = [b,c,o]
        
        self.flasherNode.layer.addAnimation(group, forKey: "expand")
    }
    
    func tap()
    {
        self.flash()
        
        if let g = self.gameController
        {
            g.tappedNodeWithIdentifier(self.identifier)
        }
        
        UIView.animateWithDuration(self.tapDuration, delay: 0.0, options: UIViewAnimationOptions.AllowUserInteraction | UIViewAnimationOptions.BeginFromCurrentState, animations: { () -> Void in
            self.buttonNode.backgroundColor = self.tappedColor

            }) { (finished: Bool) -> Void in
            
                UIView.animateWithDuration(self.tapDuration, delay: 0.0, options: UIViewAnimationOptions.AllowUserInteraction | UIViewAnimationOptions.BeginFromCurrentState, animations: { () -> Void in
                    self.buttonNode.backgroundColor = self.normalColor
                 
                    
                }, completion:nil)
        }
        
    }
}