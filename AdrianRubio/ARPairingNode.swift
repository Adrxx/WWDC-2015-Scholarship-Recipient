//
//  ARPairingNode.swift
//  AdrianRubio
//
//  Created by Adrián Rubio on 4/25/15.
//  Copyright (c) 2015 Ment. All rights reserved.
//

import Foundation
import UIKit


class PairController {
    
    weak var gameController:PairingGame?
    
    weak var node1:ARPairingNode?
    weak var node2:ARPairingNode?
    
    var pairType:Int
    
    init(node1 n1: ARPairingNode, andNode2 n2:ARPairingNode, type: Int) {
        
        self.pairType = type
        
        self.node1 = n1
        self.node2 = n2

        let g1 = UITapGestureRecognizer(target: self, action: "tap1")
        let g2 = UITapGestureRecognizer(target: self, action: "tap2")
        
        self.node1!.addGestureRecognizer(g1)
        self.node2!.addGestureRecognizer(g2)
    }
    
    func tap1()
    {
        //self.node1.reveal()
    }
    
    func tap2()
    {
        //self.node2.reveal()

    }
    
}

class ARPairingNode: ARNode {
    
    override init(radius: CGFloat, center: CGPoint) {
        super.init(radius: radius, center: center)
        
        self.backgroundColor = UIColor.cyanColor()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func reveal()
    {
        
        var identity = CATransform3DIdentity;
        identity.m34 = 1.0 / -500;
        identity = CATransform3DRotate(identity, CGFloat(180 * M_PI / 180.0), CGFloat(0), CGFloat(1), CGFloat(0));
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.layer.transform = identity
            }) { (finished: Bool) -> Void in
                
        }
    }
    
    func hide()
    {
        var identity = CATransform3DIdentity;
        identity.m34 = 1.0 / -500;
        identity = CATransform3DRotate(identity, CGFloat(0 * M_PI / 180.0), CGFloat(0), CGFloat(1), CGFloat(0));
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.layer.transform = identity
            }) { (finished: Bool) -> Void in

        }
        
    }
    
}