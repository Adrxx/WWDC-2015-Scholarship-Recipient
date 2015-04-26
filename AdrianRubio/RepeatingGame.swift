//
//  RepeatingGame.swift
//  AdrianRubio
//
//  Created by Adrián Rubio on 4/24/15.
//  Copyright (c) 2015 Ment. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

let SEPARATION_SIZE:CGFloat = 100

extension RepeatingGame {
    
    private func alignNodesInLine(items:[ARRepeatingNode],center: CGPoint,separation: CGFloat) {
        let offset = (separation * CGFloat(items.count-1))/2
        for i in enumerate(items) {
            
            i.element.center = CGPoint(x: center.x, y: center.y + separation * CGFloat(i.index) - offset)
        }
    }
    
    //Guilty
    private func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    private func generateSequence(nodeCount:Int,lenght:Int) -> [Int] {
        var seq = [Int]()
        for i in 0..<lenght
        {
            let r = Int( arc4random_uniform(CUnsignedInt(nodeCount)))
            seq.append(r)
        }
        return seq
    }
}

class RepeatingGame : GameViewController {
    
    let bgColor = UIColor(red:0.73, green:0.86, blue:0.85, alpha:1.0)
    let mistakeColor = UIColor(red:0.79, green:0.07, blue:0.0, alpha:1.0)
    
    let nodeCount = 4
    let nodeColors = [
        UIColor(red:0.9, green:0.69, blue:0.13, alpha:1.0),
        UIColor(red:0.28, green:0.53, blue:0.8, alpha:1.0),
        UIColor(red:0.9, green:0.19, blue:0.32, alpha:1.0),
        UIColor(red:0.27, green:0.7, blue:0.46, alpha:1.0)
    ]
    let NODE_RADIUS:CGFloat = 30
    let nodeSeparation:CGFloat = 100
    let delayBetweenFlashes:Double = 0.5
    let delayBeforePlaying: Double = 0.7
    let sequenceLenght = 6
    
    var sequence = [Int]()
    var sequenceCurrentLimit = 0
    var currentStep = 0
    
    var nodes:[ARRepeatingNode] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = self.bgColor
        // Four nodes in this level
        for i in 0..<nodeCount {
            let n = ARRepeatingNode(radius: NODE_RADIUS, center: CGPointZero,color: self.nodeColors[i])
            n.identifier = i
            n.gameController = self
            self.nodes.append(n)
            self.view.addSubview(n)
        }
        
        self.alignNodesInLine(self.nodes, center:self.view.center, separation: nodeSeparation)
        self.restartGame()
    }
    
    func restartGame()
    {
        self.currentStep = 0
        self.sequenceCurrentLimit = 0
        self.sequence = self.generateSequence(nodeCount, lenght: self.sequenceLenght)
        self.playSequence()
    }
    
    func playSequence()
    {
        self.view.userInteractionEnabled = false

        for i in enumerate(self.sequence)
        {
            if i.index <= self.sequenceCurrentLimit {
                delay(self.delayBeforePlaying + self.delayBetweenFlashes * Double(i.index), closure: { () -> () in
                    self.nodes[i.element].flash()
                })
            }
        }

        delay(self.delayBeforePlaying + self.delayBetweenFlashes*Double(self.sequenceCurrentLimit), closure: { () -> () in
            self.view.userInteractionEnabled = true
        })
        
    }
    
    func tappedNodeWithIdentifier(id:Int)
    {
        if id == self.sequence[self.currentStep] {
            if self.currentStep >= self.sequenceCurrentLimit {
                
                if self.sequenceCurrentLimit >= (self.sequence.count-1)
                {
                    self.challengeWon()
                }
                else
                {
                    self.currentStep = 0
                    self.sequenceCurrentLimit++
                    self.playSequence()
                }

            }
            else {
                self.currentStep++
            }

        }
        else {
            self.mistake()
            self.restartGame()
        
        }


    }
    
    func mistake()
    {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.view.backgroundColor = self.mistakeColor
            }) { (finished: Bool) -> Void in
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.view.backgroundColor = self.bgColor
                })
        }
    }
    
    override func challengeWon() {
        
        self.transitionToStory()
    }
    
}