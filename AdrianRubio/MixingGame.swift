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

let SHAPES_RADIUS:CGFloat = 30.0
let TRIANGULAR_SEPARATION_RADIUS:CGFloat = 50.0

class MixingGame: GameViewController {
    
    let blueNode = SKShapeNode(circleOfRadius: SHAPES_RADIUS)
    let redNode = SKShapeNode(circleOfRadius: SHAPES_RADIUS)
    let greenNode = SKShapeNode(circleOfRadius: SHAPES_RADIUS)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let skView = self.view as! SKView
        let scene = SKScene(size: self.view.frame.size)
        scene.backgroundColor = UIColor.blackColor()
        
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
}