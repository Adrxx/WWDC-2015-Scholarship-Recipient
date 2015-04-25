//
//  ARRepeatingNode.swift
//  AdrianRubio
//
//  Created by Adrián Rubio on 4/24/15.
//  Copyright (c) 2015 Ment. All rights reserved.
//

import Foundation
import UIKit

class ARRepeatingNode: ARNode {
    
    let flashColor = UIColor.orangeColor()
    let normalColor = UIColor.redColor()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = normalColor
        
        let tapper = UITapGestureRecognizer(target: self, action: "flash")
        tapper.numberOfTapsRequired = 1
        tapper.numberOfTouchesRequired = 1
        
        self.addGestureRecognizer(tapper)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func flash()
    {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.backgroundColor = self.flashColor
            }) { (finished: Bool) -> Void in
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.backgroundColor = self.normalColor
            })
        }
    }
}