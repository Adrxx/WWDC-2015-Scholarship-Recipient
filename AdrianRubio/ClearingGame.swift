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
    func shuffleNodes(inout nodes:[ARClearingNode],inRect rect:CGRect)
    {
        let inset:CGFloat = 100
        let insetRect = CGRectInset(rect, inset, inset)
        for i in nodes {
            let randX = Int(inset) + Int( arc4random_uniform(CUnsignedInt( insetRect.width )))
            let randY = Int(inset) + Int( arc4random_uniform(CUnsignedInt( insetRect.height )))
            
            i.center = CGPoint(x: randX, y: randY)
        }
    }
}

class ClearingGame: GameViewController {
    
    let nodeRadius:CGFloat = 20
    let nodeCount = 7
    var animator:UIDynamicAnimator!
    var pusher:UIPushBehavior!
    var nodes = [ARClearingNode]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.animator = UIDynamicAnimator(referenceView: self.view)

        let swiper = UIPanGestureRecognizer(target: self, action: "swiped:")
        
        self.view.addGestureRecognizer(swiper)


        for i in 0..<self.nodeCount {
            
            let n = ARClearingNode(radius: self.nodeRadius, center: CGPointZero)
            self.nodes.append(n)
            self.view.addSubview(n)
        }
        
        self.shuffleNodes(&self.nodes, inRect: self.view.frame)

        self.pusher = UIPushBehavior(items: self.nodes , mode: UIPushBehaviorMode.Instantaneous)
        self.animator.addBehavior(pusher)
        

        
        let collisionBehavior = UICollisionBehavior(items: self.nodes)
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        
        self.animator.addBehavior(collisionBehavior)
        
    }
    
    func swiped(sender:UIPanGestureRecognizer) {
        
        //print("dhkas")
        let v = sender.velocityInView(self.view)
        //let node = sender.view as! ARClearingNode
        self.pusher.pushDirection = CGVectorMake(v.x, v.y)
        self.pusher.magnitude = 0.1
        self.pusher.active = true

        
    }
    
}