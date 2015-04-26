//
//  ARInflatingNode.swift
//  AdrianRubio
//
//  Created by Adrián Rubio on 4/21/15.
//  Copyright (c) 2015 Ment. All rights reserved.
//

import Foundation
import UIKit

class ARInflatingNode: ARNode {
        //TODO: Shouldn't use UIView... should use UIDynamicItem
    class mapper: UIView {
        var target:ARInflatingNode?
        var goalValue:CGFloat = 1.0
        override var center:CGPoint {
            didSet
            {
                //Mapping the center.y property
                //TODO: Error prone: goal could be zero... not fixing due to time limit.
                var val = self.center.y/self.goalValue
                val = max(min(1.0, val),0.0)
                self.mapValue(val)
                //print("GOAL: \(self.goalValue) _ ")
                //println("Center: \(self.center.y)")
            }
        }
        
        //val will be a value between 0 an 1
        func mapValue(val: CGFloat)
        {
            if let t = target
            {
                //println("VALUE= \(val)")
                t.inflation = val * t.inflationGoal + t.baseInflation
            }
        }
    }
    weak var gameViewController:GameViewController? //So a node can send challengeWon()
    
    let baseInflation:CGFloat
    let inflationGoal:CGFloat
    private(set) var inflated = false
    
    var inflation:CGFloat {
        didSet
        {
            self.inflated = (self.inflation >= self.inflationGoal)
            
            if self.inflated
            {
                self.gameViewController?.challengeWon()
            }
            
            self.radius = self.inflation
        }
    }
    
    init(inflation: CGFloat, goal:CGFloat, center: CGPoint)
    {
        self.inflationGoal = goal
        self.inflation = inflation
        self.baseInflation = inflation
        super.init(radius: inflation, center: center)
    }

    required init(coder aDecoder: NSCoder) {
        self.baseInflation = 0
        self.inflationGoal = 0
        self.inflation = 0
        super.init(coder: aDecoder)
    }
    
}