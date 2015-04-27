//
//  CustomSegue.swift
//  AdrianRubio
//
//  Created by Adrián Rubio on 4/23/15.
//  Copyright (c) 2015 Ment. All rights reserved.
//

import Foundation
import UIKit

class CustomSegue: UIStoryboardSegue {
    
    override func perform() {
        if let n = self.sourceViewController.navigationController {
            let dest = self.destinationViewController as! UIViewController
            
            // Add the destination view as a subview, temporarily
            dest.view.alpha = 0
            n!.view.addSubview(dest.view)
            
            UIView.animateWithDuration(0.6, animations: { () -> Void in
                dest.view.alpha = 1
                }, completion: { (finished:Bool) -> Void in
                dest.view.removeFromSuperview()
                n?.pushViewController(dest, animated: false)
            })
  
        }
    }
}