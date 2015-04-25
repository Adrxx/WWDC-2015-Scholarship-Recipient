//
//  MatchingGame.swift
//  AdrianRubio
//
//  Created by Adrián Rubio on 4/24/15.
//  Copyright (c) 2015 Ment. All rights reserved.
//

import Foundation
import UIKit

extension MatchingGame {
    
    func alignNodesInLine(inout items:[ARMatchingNode],center: CGPoint,separation: CGFloat)
    {
        let offset = (separation * CGFloat(items.count-1))/2
        for i in 0..<items.count {
            let item = items[i]
            item.center = CGPoint(x: center.x, y: center.y + separation * CGFloat(i) - offset)
        }
    }
    
}


class MatchingGame: GameViewController {
    let nodeSeparation:CGFloat = 80.0
    var nodes:[ARMatchingNode] = []
    
    override func viewDidLoad() {
        
        for i in 0..<6 {
            let n = ARMatchingNode(radius: 20, center: CGPointZero)
            self.nodes.append(n)
            self.view.addSubview(n)
        }
        
        self.alignNodesInLine(&self.nodes, center:self.view.center, separation: nodeSeparation)
    }
    
    //Faster than attatching a delegate to every node... however not very elegant.
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {

        func allNodesValuesEqual(n: [ARMatchingNode]) -> Bool {
            for i in n
            {
                if (i.colorIndex != n[0].colorIndex) { return false }
            }
            return true
        }
        
        if allNodesValuesEqual(self.nodes) {
            self.challengeWon()
        }
        
    }
    
    override func challengeWon() {
        
        print("das")
        //self.transitionToStory()
    }
}