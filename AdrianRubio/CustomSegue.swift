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
            n?.pushViewController(dest, animated: false)
        }
    }
}