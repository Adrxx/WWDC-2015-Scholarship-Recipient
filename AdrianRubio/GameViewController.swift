//
//  GameViewController.swift
//  AdrianRubio
//
//  Created by Adrián Rubio on 4/17/15.
//  Copyright (c) 2015 Ment. All rights reserved.
//

import UIKit
import SceneKit

class GameViewController: UIViewController {
    
    var baseBackgroundColor = UIColor.blackColor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let scnView = self.view as! SCNView
        //scnView.scene = PolygonBackground()
        //scnView.backgroundColor = UIColor.blackColor()

    }
    
    //Subclasses must override
    func challengeWon()
    {
        assert(false, "Please override me.")
    }
    
    func transitionToStory()
    {
        self.performSegueWithIdentifier("toStory", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}
