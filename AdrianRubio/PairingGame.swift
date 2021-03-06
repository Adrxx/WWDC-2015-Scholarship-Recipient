//
//  PairingGame.swift
//  AdrianRubio
//
//  Created by Adrián Rubio on 4/25/15.
//  Copyright (c) 2015 Ment. All rights reserved.
//

import Foundation
import UIKit

extension Array
{
    /** Randomizes the order of an array's elements. */
    mutating func shuffle()
    {
        for _ in 0..<10
        {
            sortInPlace { (_,_) in arc4random() < arc4random() }
        }
    }
}


class PairingGame: GameViewController {
    
    
    let bgColor = UIColor.darkGrayColor()

    let clueColor = UIColor.whiteColor()
    let nodeSize:CGFloat = 25
    
    let pairCount = 3
    let xSeparation:CGFloat = 40
    let ySeparation:CGFloat = 50
    
    var nodes = [ARPairingNode]()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.nodes.shuffle()
        for n in self.nodes {
            n.reset()
            self.view.addSubview(n)
        }
        
        let offset = (self.ySeparation * CGFloat(self.nodes.count-1))/2

        for i in 0..<self.nodes.count {
            
            var side:CGFloat = 1
            if i % 2 == 0 {
                side = -1
            }
            
            self.nodes[i].center = CGPoint(x: self.view.center.x+self.xSeparation*side, y: self.view.center.y+CGFloat(i)*self.ySeparation - offset)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = self.bgColor
        
        let clue = self.generateClue("Pair",color:self.clueColor)
        
        clue.center = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height - clue.frame.size.height/2)
        self.view.addSubview(clue)
        
        
        for i in 0..<self.pairCount {
            
            let tapper1 = UITapGestureRecognizer(target: self, action: "nodeTapped:")
            let n1 = ARPairingNode(radius: self.nodeSize, center: CGPointZero,pairId:i)
            n1.addGestureRecognizer(tapper1)
            self.nodes.append(n1)
            self.view.addSubview(n1)
            
            let tapper2 = UITapGestureRecognizer(target: self, action: "nodeTapped:")
            let n2 = ARPairingNode(radius: self.nodeSize, center: CGPointZero,pairId:i)
            n2.addGestureRecognizer(tapper2)
            self.nodes.append(n2)
            self.view.addSubview(n2)
            
        }
        
        
        self.nodes.shuffle()

        let offset = (self.ySeparation * CGFloat(self.nodes.count-1))/2
        
        for i in 0..<self.nodes.count {
            
            var side:CGFloat = 1
            if i % 2 == 0 {
                side = -1
            }
            
            self.nodes[i].center = CGPoint(x: self.view.center.x+self.xSeparation*side, y: self.view.center.y+CGFloat(i)*self.ySeparation - offset)
        }
        
        
        
    }
    
    func nodeTapped(sender:UITapGestureRecognizer)
    {
        
        let n = sender.view as! ARPairingNode
        n.reveal()
        
        for i in self.nodes
        {
            if i.revealed && i != n
            {
                if i.pairId == n.pairId{
                    i.fadeOut()
                    if let index = self.nodes.indexOf(i)
                    {
                        self.nodes.removeAtIndex(index)
                    }
                    
                    n.fadeOut()
                    if let index = self.nodes.indexOf(n)
                    {
                        self.nodes.removeAtIndex(index)
                    }
                    
                    if self.nodes.isEmpty
                    {
                        delay(0.5, closure: { () -> () in
                            self.challengeWon()
                        })
                        
                    }
  
                }
                else{
                    self.view.userInteractionEnabled = false
                    delay(0.8, closure: { () -> () in
                        i.unreveal()
                        n.unreveal()
                        self.view.userInteractionEnabled = true

                    })
                }
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let d = segue.destinationViewController as! StoryViewController
        d.endingColor =  UIColor(red:0.29, green:0.26, blue:0.41, alpha:1.0)
        
    }
}