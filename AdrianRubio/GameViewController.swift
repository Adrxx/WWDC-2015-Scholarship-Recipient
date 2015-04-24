//
//  GameViewController.swift
//  AdrianRubio
//
//  Created by Adrián Rubio on 4/17/15.
//  Copyright (c) 2015 Ment. All rights reserved.
//

import UIKit
import SceneKit


extension GameViewController
{
    func generateClue(text: String,color: UIColor) -> UILabel
    {
        let font = UIFont(name: "Perfograma", size: 35)
        let lab = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 180))
        lab.font = font
        lab.alpha = 0.0
        lab.textColor = color
        lab.textAlignment = NSTextAlignment.Center
        lab.text = text

        return lab
    }
}

class GameViewController: UIViewController {
        
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
