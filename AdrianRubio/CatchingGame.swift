//
//  CatchingGame.swift
//  AdrianRubio
//
//  Created by Adrián Rubio on 4/23/15.
//  Copyright (c) 2015 Ment. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

let SPINNING_PATH_RADIUS:CGFloat = 220
let NODE_SPIN_DURATION = 0.72
let NODE_SPIN_DURATION_OPPOSITE = 1.05
let NODE_SIZE:CGFloat = 14

class CatchingGame : GameViewController, SKSceneDelegate {
    
    let bgColor = UIColor(red:0.72, green:0.56, blue:0.8, alpha:1.0)
    let clueColor = UIColor.whiteColor()
    
    var spinningNode:ARCatchingNode!
    var spinningNodeOpposite:ARCatchingNode!
    var scene:SKScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let skView = self.view as! SKView
        self.scene = SKScene(size: self.view.frame.size)
        self.scene.delegate = self
        self.scene.backgroundColor = self.bgColor
        
        let clue = self.generateClue("Sync",color:self.clueColor)
        
        clue.center = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2)
        self.view.addSubview(clue)
        
        let circlePath = CGPathCreateWithEllipseInRect(CGRect(x: self.scene.frame.width/2 - SPINNING_PATH_RADIUS/2, y: self.scene.frame.height/2 - SPINNING_PATH_RADIUS/2, width: SPINNING_PATH_RADIUS, height: SPINNING_PATH_RADIUS), nil)

        //Spinning Node
        let followPath = SKAction.followPath(circlePath, asOffset: false, orientToPath: false, duration: NODE_SPIN_DURATION)
        
        //followPath.timingMode = SKActionTimingMode.EaseInEaseOut

        
        self.spinningNode = ARCatchingNode(circleOfRadius: NODE_SIZE)
        self.spinningNode.runAction(SKAction.repeatActionForever(followPath))
        
        //Spinning Node oposite
        let followPathOpposite = SKAction.followPath(circlePath, asOffset: false, orientToPath: false, duration: NODE_SPIN_DURATION_OPPOSITE)
        
        self.spinningNodeOpposite = ARCatchingNode(circleOfRadius: NODE_SIZE)
        self.spinningNodeOpposite.runAction(SKAction.repeatActionForever(followPathOpposite))

        
        self.scene.addChild(self.spinningNodeOpposite)
        self.scene.addChild(self.spinningNode)
        skView.presentScene(self.scene)
        
    }
    
    func update(currentTime: NSTimeInterval, forScene scene: SKScene) {
        
        if CGRectIntersectsRect(self.spinningNodeOpposite.frame, self.spinningNode.frame)
        {
            self.spinningNode.state = ARCatchingNode.nodeState.On
            self.spinningNodeOpposite.state = ARCatchingNode.nodeState.On
        }
        else
        {
            self.spinningNode.state = ARCatchingNode.nodeState.Neutral
            self.spinningNodeOpposite.state = ARCatchingNode.nodeState.Neutral
        }

    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        
        if CGRectIntersectsRect(self.spinningNodeOpposite.frame, self.spinningNode.frame) {
            self.challengeWon()
        }
        
    }
    
    override func challengeWon() {
        
        
        self.transitionToStory()
    }
    
}