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

extension UIColor
{
    func darkerColor() -> UIColor
    {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0

        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return UIColor(red: r-0.2, green: g-0.2, blue: b-0.2, alpha: a)
    }
}

class ARRepeatingNode: ARNode {
    
    let tapDuration = 0.15
    let flasherSize:CGFloat = 20
    
    weak var gameController:RepeatingGame?
    var buttonNode:ARNode!
    var flasherNode:ARNode!
    var identifier:Int!
    var color:UIColor
    
    init(radius: CGFloat, center: CGPoint,color: UIColor) {
        self.color = color
        super.init(radius: radius, center: center)
        
        self.flasherNode = ARNode(radius: radius/2, center: CGPoint(
            x: CGRectGetMidX(self.bounds),
            y: CGRectGetMidY(self.bounds)))
        self.flasherNode.backgroundColor = self.color
        self.addSubview(self.flasherNode)
        
        self.buttonNode = ARNode(radius: radius, center: CGPoint(
            x: CGRectGetMidX(self.bounds),
            y: CGRectGetMidY(self.bounds)))
        
        self.buttonNode.backgroundColor = self.color
        self.addSubview(self.buttonNode)
        
        let tapper = UITapGestureRecognizer(target: self, action: "tap")
        tapper.numberOfTapsRequired = 1
        tapper.numberOfTouchesRequired = 1
        
        self.buttonNode.addGestureRecognizer(tapper)
    }

    required init(coder aDecoder: NSCoder) {
        self.color = UIColor.whiteColor()
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
        
        UIView.animateWithDuration(self.tapDuration, delay: 0.0, options: [UIViewAnimationOptions.AllowUserInteraction, UIViewAnimationOptions.BeginFromCurrentState], animations: { () -> Void in
            self.buttonNode.backgroundColor = self.color.darkerColor()

            }) { (finished: Bool) -> Void in
            
                UIView.animateWithDuration(self.tapDuration, delay: 0.0, options: [UIViewAnimationOptions.AllowUserInteraction, UIViewAnimationOptions.BeginFromCurrentState], animations: { () -> Void in
                    self.buttonNode.backgroundColor = self.color
                 
                    
                }, completion:nil)
        }
        
    }
}