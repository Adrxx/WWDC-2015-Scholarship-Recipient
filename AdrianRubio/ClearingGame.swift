//
//  ClearingGame.swift
//  AdrianRubio
//
//  Created by Adrián Rubio on 4/25/15.
//  Copyright (c) 2015 Ment. All rights reserved.
//

import Foundation
import UIKit

extension ClearingGame
{
    func shuffleNodes(nodes:[ARClearingNode],inRect rect:CGRect)
    {
        let insetX:CGFloat =  80
        let insetY:CGFloat =  40
        let insetRect = CGRectInset(rect,insetX, insetY)
        for i in nodes {
            let randX =  CGFloat( arc4random_uniform(CUnsignedInt( insetRect.width )))
            let randY =  CGFloat( arc4random_uniform(CUnsignedInt( insetRect.height )))
            
            i.center = CGPoint(x: randX + insetRect.origin.x , y:  insetRect.origin.y + randY)
        }
    }
    
    
}

class ClearingGame: GameViewController, UICollisionBehaviorDelegate {
    
    
    let clueColor = UIColor(red:0.96, green:0.7, blue:0.58, alpha:1.0)
    let bgColor = UIColor(red:0.29, green:0.26, blue:0.41, alpha:1.0)
    
    let nodeRadius:CGFloat = 20
    let nodeCount = 7
    var animator:UIDynamicAnimator!
    var pusher:UIPushBehavior!
    var nodes = [ARClearingNode]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = self.bgColor
        let clue = self.generateClue("Clear",color:self.clueColor)
        
        clue.center = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2)
        self.view.addSubview(clue)
        
        self.animator = UIDynamicAnimator(referenceView: self.view)
        
        for i in 0..<self.nodeCount {
            let n = ARClearingNode(radius: self.nodeRadius, center: CGPointZero)
            
            let swiper = UIPanGestureRecognizer(target: self, action: "swiped:")
            n.addGestureRecognizer(swiper)
            
            self.nodes.append(n)
            self.view.addSubview(n)
        }
        
        self.shuffleNodes(self.nodes, inRect: clue.frame)
        
        for i in self.nodes {
            let pusher = UIPushBehavior(items: [i] , mode: UIPushBehaviorMode.Instantaneous)
            i.pusher = pusher
            self.animator.addBehavior(pusher)
        }
        
        let collisionBehavior = UICollisionBehavior(items: self.nodes)
        
        let path = UIBezierPath(rect: CGRectInset(self.view.frame, -self.nodeRadius*2, -self.nodeRadius*2))
        
        collisionBehavior.addBoundaryWithIdentifier("boundary", forPath: path)
        collisionBehavior.collisionDelegate = self
        
        self.animator.addBehavior(collisionBehavior)
        
    }
    
    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying, atPoint p: CGPoint) {
        
        if "boundary" == (identifier as! String)
        {
            let v = item as! ARClearingNode
            v.removeFromSuperview()
            
            if let i = find(self.nodes, v)
            {
                self.nodes.removeAtIndex(i)
                if self.nodes.isEmpty
                {
                    self.challengeWon()
                }
            }
            
        }
        
    }
    
    func swiped(sender:UIPanGestureRecognizer) {
        
        if sender.state == UIGestureRecognizerState.Ended {
            
            let v = sender.velocityInView(self.view)
            let node = sender.view as! ARClearingNode
            
            node.pusher.pushDirection = CGVectorMake(v.x, v.y)
            
            let hyp = sqrt(v.x*v.x + v.y*v.y)
            node.pusher.magnitude = hyp/6000
            node.pusher.active = true
            
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let d = segue.destinationViewController as! StoryViewController
        d.endingColor =  UIColor(red:0.73, green:0.86, blue:0.85, alpha:1.0)
        
    }
    
}