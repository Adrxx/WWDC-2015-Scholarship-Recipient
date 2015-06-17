//
//  InflatingGame.swift
//  
//
//  Created by Adrián Rubio on 4/21/15.
//
//

import Foundation
import UIKit
import Darwin

class InflatingGame: GameViewController {
    
    let nodeColor = UIColor(red:0.44, green:0.54, blue:0.75, alpha:1.0)
    let bgColor = UIColor(red:0.29, green:0.36, blue:0.5, alpha:1.0)
    let clueColor = UIColor(red:0.52, green:0.67, blue:0.9, alpha:1.0)
    
    var arnode:ARInflatingNode!
    var animator:UIDynamicAnimator!
    var gravityMapper:ARInflatingNode.mapper!
    var pusher:UIPushBehavior!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.gravityMapper.active = true
        self.gravityMapper.mapValue(0)
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = self.bgColor
        
        let clue = self.generateClue("Grow",color:self.clueColor)
        
        clue.center = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height - clue.frame.size.height/2)
        self.view.addSubview(clue)
        

        
        let hypotenuse = sqrt(pow(self.view.frame.height/2, 2) + pow(self.view.frame.width/2,2))
        
        self.arnode = ARInflatingNode(inflation: 45, goal: hypotenuse, center: CGPoint(x: CGRectGetMidX(self.view.frame), y: CGRectGetMidY(self.view.frame)))
        self.arnode.backgroundColor = self.nodeColor
        
        self.arnode.gameViewController = self
        self.view.addSubview(self.arnode)
        
        //Tap gesture recognizer
        let tapper = UITapGestureRecognizer(target: self, action: "nodeTapped")
        tapper.numberOfTapsRequired = 1
        tapper.numberOfTouchesRequired = 1
        self.arnode.addGestureRecognizer(tapper)
        
        //Gravity mapper helps me to take the goodies of UIDynamics into any property I need, in this case the "inflation" of the arnode
        // I also use it as an indicator to show the user how much inflation needs to win. 
        // Didn't like it... making it invisible...
        let indicatorSize = CGSize(width: 5, height: 5)
        self.gravityMapper = ARInflatingNode.mapper(frame: CGRect(
            x: indicatorSize.width,
            y: indicatorSize.height,
            width: indicatorSize.width,
            height: indicatorSize.height))
        
        //self.gravityMapper.backgroundColor = UIColor.whiteColor()
        self.gravityMapper.goalValue = self.view.frame.height
        self.gravityMapper.target = self.arnode
        self.view.addSubview(self.gravityMapper)
        
        // UIDynamics
        self.animator = UIDynamicAnimator(referenceView: self.view)

        let gravityBehavior = UIGravityBehavior(items: [self.gravityMapper])
        gravityBehavior.gravityDirection = CGVector(dx: 0, dy: -1)
        self.animator.addBehavior(gravityBehavior)
        
        let collisionBehavior = UICollisionBehavior(items: [self.gravityMapper])
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        self.animator.addBehavior(collisionBehavior)
        
        let itemBehavior = UIDynamicItemBehavior(items: [self.gravityMapper])
        itemBehavior.elasticity = 0.6
        itemBehavior.allowsRotation = false
        itemBehavior.density = 8
        self.animator.addBehavior(itemBehavior)
        
        self.pusher = UIPushBehavior(items: [self.gravityMapper], mode: UIPushBehaviorMode.Instantaneous)
        self.animator.addBehavior(self.pusher)
                
    }
    
    
    func nodeTapped()
    {
        self.pusher.angle = CGFloat(M_PI/2)
        self.pusher.magnitude = 0.04
        self.pusher.active = true

    }
    
    override func challengeWon() {
        super.challengeWon()
        self.gravityMapper.active = false
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let d = segue.destinationViewController as! StoryViewController
        d.endingColor =  UIColor(red:0.72, green:0.56, blue:0.8, alpha:1.0)
    }
    

    
}