//
//  NavigationController.swift
//  AdrianRubio
//
//  Created by Adrián Rubio on 4/23/15.
//  Copyright (c) 2015 Ment. All rights reserved.
//

import Foundation
import UIKit

class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let t = UITapGestureRecognizer(target: self, action:"resetApp")
        t.numberOfTapsRequired = 2
        t.numberOfTouchesRequired = 2
        self.view.addGestureRecognizer(t)
    }
    
    func resetApp()
    {
        print("daasd")
        self.popToRootViewControllerAnimated(true)
    }
    
}