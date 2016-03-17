//
//  ARCatchingNode.swift
//  AdrianRubio
//
//  Created by Adrián Rubio on 4/23/15.
//  Copyright (c) 2015 Ment. All rights reserved.
//

import Foundation
import SpriteKit


class ARCatchingNode: SKShapeNode {
    
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
        let color = UIColor(red:0.98, green:0.67, blue:1.0, alpha:1.0)
        self.fillColor = color
        self.strokeColor = color
    }
    
    func setToOn()
    {
        let color = UIColor(red:0.64, green:1.0, blue:0.6, alpha:1.0)
        self.fillColor = color
        self.strokeColor = color

    }
    
    func setToOff()
    {
        let color = UIColor.redColor()
        self.fillColor = color
        self.strokeColor = color
    }
    
}