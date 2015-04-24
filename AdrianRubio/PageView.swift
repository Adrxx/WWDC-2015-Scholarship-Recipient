//
//  PageView.swift
//  AdrianRubio
//
//  Created by Adrián Rubio on 4/22/15.
//  Copyright (c) 2015 Ment. All rights reserved.
//

import Foundation
import UIKit

let LABEL_PROPORTION:CGFloat = 0.5 //This proportion is used to determine the label size in the frame... the rest (1 - labelProportion) is for the UIImage.
let IMAGE_RADIUS_PROPORTION:CGFloat = 1.3
let LABEL_WIDTH:CGFloat = 260

class PageView: UIView {
    
    var storyLabel:UILabel!
    var imageView:UIImageView!
    
    init(frame: CGRect, storyText: String, imageFileName:String) {
        super.init(frame: frame)
        
        let labelRect = CGRect(
            x: 0,
            y: 0,
            width: LABEL_WIDTH,
            height: self.frame.height * LABEL_PROPORTION)
        
        // self.storyLabel.center.x = self.center.x
        self.storyLabel = UILabel(frame: labelRect)
        self.storyLabel.center.x = self.center.x
        self.storyLabel.numberOfLines = 0
        self.storyLabel.textAlignment = NSTextAlignment.Center
        //Set label text to story page text
        self.storyLabel.text = storyText
        
        let font = UIFont(name: "Fira Sans", size: 23)
        self.storyLabel.font = font
        self.addSubview(self.storyLabel)
        
        let imageRect = CGRect(
            x: 0,
            y: labelRect.height,
            width: self.frame.width * IMAGE_RADIUS_PROPORTION,
            height: self.frame.width * IMAGE_RADIUS_PROPORTION)
        
        self.imageView = UIImageView(frame: imageRect)
        self.imageView.center.x = self.frame.width/2
        self.imageView.layer.cornerRadius = self.imageView.frame.width/2
        self.imageView.clipsToBounds = true;
        self.imageView.contentMode = UIViewContentMode.ScaleAspectFill
        
        let image = UIImage(named: imageFileName)
        self.imageView.image = image
        self.imageView.backgroundColor = UIColor.redColor()
        
        self.addSubview(self.imageView)
        
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateProgressValue(progress: CGFloat)
    {
        //some functions where tested for the effect...
        // function: y = -(x^2)+1
        //let val = min(1.0, max(0.0, -(progress*progress) + 1))
        
        // function: y = -(abs(sqrt(x)))+1
        //let val = min(1.0, max(0.0, -( abs(sqrt(progress)) ) + 1))
        
        // function: y = 0.5 (1 + ArcTan[\[Pi] (0.5 - Abs[x])])
        /*let val = min(1.0, max(0.0,
            0.5*(1 + atan(CGFloat(M_PI) * ( -abs(progress) + 0.5) ) )
            )) */
        
        let limitP = min(1.0, max(-1.0,progress))
        let val = ( cos(limitP * CGFloat(M_PI))+1 )*0.5
        
        let valAlpha = ( cos(1.5 * limitP * CGFloat(M_PI))+1 )*0.5
        
        self.storyLabel.alpha = valAlpha
        
        let maxImageRadius = self.frame.width * IMAGE_RADIUS_PROPORTION
        
        let radius = max(30, maxImageRadius*val)
        let lastCenter = self.imageView.center
        self.imageView.frame = CGRect(origin: self.imageView.frame.origin, size: CGSize(
            width: radius,
            height: radius))
        self.imageView.layer.cornerRadius = radius/2

        self.imageView.center = lastCenter
        
        
    }
    
}