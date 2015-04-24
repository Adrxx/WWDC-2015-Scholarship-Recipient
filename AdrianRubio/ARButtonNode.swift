//
//  ARButtonNode.swift
//  AdrianRubio
//
//  Created by Adrián Rubio on 4/23/15.
//  Copyright (c) 2015 Ment. All rights reserved.
//

import Foundation
import SpriteKit


class ARButtonNode: SKShapeNode {
    
    // let as

    
    enum nodeState
    {
        case Off
        case On
        case Neutral
    }
    
    weak var gameViewController:GameViewController?
    var state:nodeState = .Neutral{
        didSet{
            switch(self.state){
            case .Neutral:
                self.setToNeutral()
            case .On:
                self.setToOn()
            case .Off:
                self.setToOff()
            default:
                print("No such state.")
            }
        }
    }
    
    override init()
    {
        super.init()
        self.fillColor = UIColor.blackColor()
        self.strokeColor = UIColor.blackColor()
    }


    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setToNeutral()
    {
        //self.fillColor = UIColor
    }
    
    func setToOn()
    {
        
    }
    
    func setToOff()
    {
        
    }
    
}