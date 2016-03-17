//
//  PolygonBackground.swift
//  AdrianRubio
//
//  Created by Adrián Rubio on 4/19/15.
//  Copyright (c) 2015 Ment. All rights reserved.
//

import Foundation
import SceneKit

class PolygonBackground: SCNScene {
    
    override init() {
        super.init()
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        self.rootNode.addChildNode(cameraNode)
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 15)
        let ps = SCNParticleSystem(named: "Background.scnp", inDirectory: "")
        self.rootNode.addParticleSystem(ps!)
        //let color = UIColor(red: 0.212, green: 0.002, blue: 0.010, alpha: 1)
        ps!.particleColor = UIColor.redColor()
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}