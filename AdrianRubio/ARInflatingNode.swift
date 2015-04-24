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
    //TODO: Shouldn't use UIView...
    class mapper: UIView {
        var target:ARInflatingNode?
        var goalValue:CGFloat = 1.0
        override var center:CGPoint {
            didSet
            {
                //Mapping the center.y property
                //TODO: Error prone: initialValue could be zero... not fixing due to time limit.
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
            if let uTarget = target
            {
                //println("VALUE= \(val)")
                uTarget.inflation = val * uTarget.inflationGoal + uTarget.baseInflation
            }
        }
    }
    
    let baseInflation:CGFloat = 80.0
    var inflationGoal:CGFloat = 500.0
    private(set) var inflated = false
    var inflation:CGFloat = 100.0 {
        didSet
        {
            self.inflated = (self.inflation >= self.inflationGoal)
            
            if self.inflated
            {
                self.gameViewController?.challengeWon()
            }
            
            self.layer.cornerRadius = self.inflation/2
            self.frame = CGRect(origin: self.frame.origin, size: CGSize(
                width: self.inflation,
                height: self.inflation))
        }
    }
    
    init() {
        super.init(frame: CGRect(origin: CGPointZero, size: CGSize(width: self.inflation, height: inflation)))
        self.backgroundColor = UIColor.orangeColor()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}