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
        
        UIView.animateWithDuration(5.0, delay: 0.0, options: [], animations: { () -> Void in
            lab.alpha = 0.6
            }, completion: nil)
        
        return lab
    }
    
    
    //Guilty
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
}

class GameViewController: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Subclasses can override
    func challengeWon()
    {
        self.transitionToStory()
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
