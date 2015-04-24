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

    var animator:UIDynamicAnimator!
    var gravityMapper:ARInflatingNode.mapper!
    var pusher: UIPushBehavior!
    let arnode = ARInflatingNode()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        let clue = self.generateClue("Inflate",color: UIColor.blackColor())
        clue.alpha = 0.0
        clue.center = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height - clue.frame.size.height/2)
        self.view.addSubview(clue)
        
        UIView.animateWithDuration(5.0, delay: 6.0, options: nil, animations: { () -> Void in
            clue.alpha = 0.4
            }, completion: nil)
        
        
        self.arnode.gameViewController = self
        //Position arnode in center
        self.arnode.frame.origin = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2)
        //Set inflation goal to screen height
        
        let hypotenuse = sqrt(pow(self.view.frame.height, 2) + pow(self.view.frame.width,2))
        self.arnode.inflationGoal = hypotenuse;
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
    
    override func challengeWon()
    {
        self.arnode.userInteractionEnabled = false
        self.animator.removeAllBehaviors()
        self.transitionToStory()
    }
    

    
}