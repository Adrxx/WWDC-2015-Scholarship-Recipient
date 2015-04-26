//
//  PairingGame.swift
//  AdrianRubio
//
//  Created by Adrián Rubio on 4/25/15.
//  Copyright (c) 2015 Ment. All rights reserved.
//

import Foundation
import UIKit

extension PairingGame {
    
    //Thanks Stack Overflow...
    func shuffle<C: MutableCollectionType where C.Index == Int>(var list: C) -> C {
        let c = count(list)
        for i in 0..<(c - 1) {
            let j = Int(arc4random_uniform(UInt32(c - i))) + i
            swap(&list[i], &list[j])
        }
        return list
    }
    
}

class PairingGame: GameViewController {
    
    let pairCount = 3
    let xSeparation:CGFloat = 40
    let ySeparation:CGFloat = 50

    var nodes = [ARPairingNode]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0..<self.pairCount {
            
            let n1 = ARPairingNode(radius: 20, center: CGPointZero)
            let n2 = ARPairingNode(radius: 20, center: CGPointZero)
            let pc = PairController(node1: n1, andNode2: n2,type:i)
            
            
            self.nodes.append(n1)
            self.view.addSubview(n1)
            
            self.nodes.append(n2)
            self.view.addSubview(n2)
            
            // self.pc!.gameController = self
            
        }
        
        //shuffle(self.nodes)
        
        let offset = (self.ySeparation * CGFloat(self.nodes.count-1))/2
        for i in 0..<self.nodes.count {
            
            var side:CGFloat = 1
            if i % 2 == 0 {
                side = -1
            }

            self.nodes[i].center = CGPoint(x: self.view.center.x+self.xSeparation*side, y: self.view.center.y+CGFloat(i)*self.ySeparation - offset)

            
        }
        
        
        
        
        
        
    }
}