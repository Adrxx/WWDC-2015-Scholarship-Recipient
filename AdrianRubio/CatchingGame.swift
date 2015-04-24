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

let SPINNING_NODE_RADIUS:CGFloat = 120
let FULL_CIRCLE_DURATION = 0.9
let SEMICIRCLE_RANGE:CGFloat = 20

class CatchingGame : GameViewController, SKSceneDelegate {
    
    var buttonNode:ARButtonNode!
    var spinningNode:ARButtonNode!
    var spinningContainer:SKNode!
    var spinningContainerOpposite:SKNode!

    //var winningSection:SKShapeNode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let skView = self.view as! SKView
        let scene = SKScene(size: self.view.frame.size)
        scene.delegate = self
        scene.backgroundColor = UIColor.whiteColor()
        
        //Create winning section node
        /*
        var arc = UIBezierPath()
        arc.addArcWithCenter(CGPointMake(scene.frame.midX, scene.frame.midY), radius:SPINNING_NODE_RADIUS + 15, startAngle: (90 + SEMICIRCLE_RANGE/2) * CGFloat(M_PI)/180, endAngle: (90 - SEMICIRCLE_RANGE/2) * CGFloat(M_PI)/180, clockwise: false)
        arc.addLineToPoint(CGPointMake(scene.frame.midX, scene.frame.midY))
        arc.closePath()
        self.winningSection = SKShapeNode(path: arc.CGPath)
        self.winningSection.alpha = 0.5

        
        scene.addChild(self.winningSection)
        */
        
        //Create button node
        self.buttonNode = ARButtonNode(circleOfRadius: 30)
        self.buttonNode.position = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2)
        
        //Spinning container
        self.spinningContainer = SKNode()
        self.spinningContainer.position = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2)
        let rot1 = SKAction.rotateToAngle(-CGFloat(M_PI), duration: FULL_CIRCLE_DURATION/2)
        let rot2 = SKAction.rotateToAngle(0, duration: FULL_CIRCLE_DURATION/2, shortestUnitArc: true)
        let seq = SKAction.sequence([rot1,rot2])
        self.spinningContainer.runAction(SKAction.repeatActionForever(seq))

        //Spinning Node
        self.spinningNode = ARButtonNode(circleOfRadius: 8)
        self.spinningNode.position = CGPoint(x: self.spinningContainer.frame.width/2 + SPINNING_NODE_RADIUS, y: self.spinningContainer.frame.height/2)
        
        //Spinning node particles... Didn't like it
        /*
        let em = SKEmitterNode(fileNamed: "trail")
        em.position = CGPoint(x: self.spinningContainer.frame.width/2 + SPINNING_NODE_RADIUS
            , y: self.spinningContainer.frame.height/2)
        em.targetNode = scene
    
        
        self.spinningContainer.addChild(em) */
        
        self.spinningContainer.addChild(self.spinningNode)
        
        scene.addChild(self.spinningContainer)
        scene.addChild(buttonNode)

        skView.presentScene(scene)
        
    }
    
    func update(currentTime: NSTimeInterval, forScene scene: SKScene) {
        
        let rot = self.spinningContainer.zRotation
        let maxLimit = (90 + SEMICIRCLE_RANGE) * CGFloat(M_PI)/180
        let minLimit = (90 - SEMICIRCLE_RANGE) * CGFloat(M_PI)/180

        if (rot < maxLimit && rot > minLimit)
        {
            self.winningSection.fillColor = UIColor.greenColor()
            self.winningSection.strokeColor = UIColor.greenColor()
        }
        else
        {
            self.winningSection.fillColor = UIColor.redColor()
            self.winningSection.strokeColor = UIColor.redColor()

        }
        

    }
    
}