//
//  MixingGame.swift
//  AdrianRubio
//
//  Created by Adrián Rubio on 4/22/15.
//  Copyright (c) 2015 Ment. All rights reserved.
//

import Foundation
import SpriteKit
import Darwin

let SHAPES_RADIUS:CGFloat = 45.0
let TRIANGULAR_SEPARATION_RADIUS:CGFloat = 100.0
let ACCEPTABLE_DISTANCE:CGFloat = 40.0

extension MixingGame
{
    func distanceBetweenRects( rect1: CGRect,_ rect2: CGRect) -> CGFloat {
        let c1 = CGPointMake( CGRectGetMidX( rect1 ), CGRectGetMidY( rect1 ) )
        let c2 = CGPointMake( CGRectGetMidX( rect2 ), CGRectGetMidY( rect2 ) )
        
        let xDif = c2.x - c1.x
        let yDif = c2.y - c1.y
        
        return sqrt( ( xDif * xDif ) + ( yDif * yDif ) )
    }
    
    func midPointBetweenRects(rects: [CGRect]) -> CGPoint {
        var avgX:CGFloat = 0
        var avgY:CGFloat = 0
        for r in rects
        {
            let c = CGPointMake( CGRectGetMidX( r ), CGRectGetMidY( r ) )
            avgX += c.x
            avgY += c.y
        }
        
        avgX /= CGFloat(rects.count)
        avgY /= CGFloat(rects.count)

        return CGPoint(x: avgX, y: avgY)
    }
    
    
    func mixNodes(node1: SKNode, node2: SKNode, tolerance: CGFloat) -> Bool {
        
        let dist = self.distanceBetweenRects(node1.frame, node2.frame)

        if dist <= tolerance
        {
            let p = self.midPointBetweenRects([node1.frame, node2.frame])
            let move = SKAction.moveTo(p, duration: 0.2)
            move.timingMode = SKActionTimingMode.EaseInEaseOut
            node1.runAction(move)
            node2.runAction(move)
            
            return true
        }
        return false
    }
}

class MixingGame: GameViewController,SKSceneDelegate {

    let blueNode = ARMixingNode(circleOfRadius: SHAPES_RADIUS)
    let redNode = ARMixingNode(circleOfRadius: SHAPES_RADIUS)
    let greenNode = ARMixingNode(circleOfRadius: SHAPES_RADIUS)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let skView = self.view as! SKView
        let scene = SKScene(size: self.view.frame.size)
        scene.backgroundColor = UIColor.blackColor()
        scene.delegate = self
        
        self.blueNode.fillColor = UIColor.blueColor()
        self.blueNode.strokeColor = UIColor.blueColor()
        self.blueNode.blendMode = SKBlendMode.Screen
        
        self.blueNode.position = CGPoint(x: self.view.frame.size.width/2,y: self.view.frame.size.height/2 + TRIANGULAR_SEPARATION_RADIUS )
        scene.addChild(self.blueNode)
        
        self.redNode.fillColor = UIColor.redColor()
        self.redNode.strokeColor = UIColor.redColor()
        self.redNode.blendMode = SKBlendMode.Screen
        
        let redX = cos(210.0 * CGFloat(M_PI)/180.0) * TRIANGULAR_SEPARATION_RADIUS
        let redY = sin(210 * CGFloat(M_PI)/180) * TRIANGULAR_SEPARATION_RADIUS
        self.redNode.position = CGPoint(x: self.view.frame.size.width/2 + redX,y: self.view.frame.size.height/2 + redY)
        scene.addChild(self.redNode)
        
        self.greenNode.fillColor = UIColor.greenColor()
        self.greenNode.strokeColor = UIColor.greenColor()
        self.greenNode.blendMode = SKBlendMode.Screen
        
        
        let greenX = cos(330*CGFloat(M_PI)/180) * TRIANGULAR_SEPARATION_RADIUS
        let greenY = sin(330*CGFloat(M_PI)/180) * TRIANGULAR_SEPARATION_RADIUS
        self.greenNode.position = CGPoint(x: self.view.frame.size.width/2 + greenX ,y: self.view.frame.size.height/2 + greenY)
        scene.addChild(self.greenNode)
            
        skView.presentScene(scene)
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesEnded(touches, withEvent: event)
        
        let dist1 = self.distanceBetweenRects(self.redNode.frame, self.blueNode.frame)
        let dist2 = self.distanceBetweenRects(self.redNode.frame, self.greenNode.frame)
        let dist3 = self.distanceBetweenRects(self.blueNode.frame, self.greenNode.frame)

        if dist1 <= ACCEPTABLE_DISTANCE && dist2 <= ACCEPTABLE_DISTANCE && dist3 <= ACCEPTABLE_DISTANCE {
            let p = self.midPointBetweenRects([self.redNode.frame, self.blueNode.frame,self.greenNode.frame])
            let move = SKAction.moveTo(p, duration: 0.2)
            let win = SKAction.customActionWithDuration(0.0, actionBlock: { (n, t) -> Void in
                self.challengeWon()
            })
            move.timingMode = SKActionTimingMode.EaseInEaseOut
            
            self.redNode.runAction(move)
            self.blueNode.runAction(move)
            self.greenNode.runAction(SKAction.sequence([move,win])) //TODO: not the most elegant solution...
            
        }
        else {
            if !self.mixNodes(self.blueNode, node2: self.redNode, tolerance: ACCEPTABLE_DISTANCE){
                if !self.mixNodes(self.redNode, node2: self.greenNode, tolerance: ACCEPTABLE_DISTANCE){
                    self.mixNodes(self.greenNode, node2: self.blueNode, tolerance: ACCEPTABLE_DISTANCE)
                }

            }
        }
        
        
    }
    
    override func challengeWon() {
        self.transitionToStory()
    }
    
    
    
    
}