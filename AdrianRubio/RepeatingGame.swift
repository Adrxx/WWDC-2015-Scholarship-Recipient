//
//  RepeatingGame.swift
//  AdrianRubio
//
//  Created by Adrián Rubio on 4/24/15.
//  Copyright (c) 2015 Ment. All rights reserved.
//

import Foundation
import UIKit

/*
    Mixing SKView with UIView elements feels kind of wierd...
    but i'm gonna risk it
*/

let SEPARATION_SIZE:CGFloat = 100

class RepeatingGame : GameViewController {
    
    let NODE_RADIUS:CGFloat = 20
    
    let sequence = [0,3,2,3,1]
    
    var n1:ARRepeatingNode!
    var n2:ARRepeatingNode!
    var n3:ARRepeatingNode!
    var n4:ARRepeatingNode!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.n1 = ARRepeatingNode(radius: NODE_RADIUS, center: CGPoint(x: CGRectGetMidX(self.view.frame), y: CGRectGetMidY(self.view.frame) - SEPARATION_SIZE*1.5 ))
        self.view.addSubview(self.n1)

        self.n2 = ARRepeatingNode(radius: NODE_RADIUS, center: CGPoint(x: CGRectGetMidX(self.view.frame), y: CGRectGetMidY(self.view.frame) - SEPARATION_SIZE/2 ))
        self.view.addSubview(self.n2)

        
        self.n3 = ARRepeatingNode(radius: NODE_RADIUS, center: CGPoint(x: CGRectGetMidX(self.view.frame), y: CGRectGetMidY(self.view.frame) + SEPARATION_SIZE/2 ))
        self.view.addSubview(self.n3)

        self.n4 = ARRepeatingNode(radius: NODE_RADIUS, center: CGPoint(x: CGRectGetMidX(self.view.frame), y: CGRectGetMidY(self.view.frame) + SEPARATION_SIZE*1.5 ))
        self.view.addSubview(self.n4)
        
        
    }
    
    override func challengeWon() {
        
        self.transitionToStory()
    }
    
}