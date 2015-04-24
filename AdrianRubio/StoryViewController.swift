//
//  StoryViewController.swift
//  AdrianRubio
//
//  Created by Adrián Rubio on 4/22/15.
//  Copyright (c) 2015 Ment. All rights reserved.
//

import Foundation
import UIKit

class Story {
    
    struct Page
    {
        var storyText:String
        var imageFileName:String
    }
    
    var pages = [Page]()
    
    init(fileName: String)
    {
        if let path = NSBundle.mainBundle().pathForResource(fileName, ofType: "plist"){
            let arr = NSArray(contentsOfFile: path)!
            for i in 0..<arr.count {
                let dict = arr.objectAtIndex(i) as! NSDictionary
                let story = dict.objectForKey("story") as! String
                let imageFile = dict.objectForKey("imageFile") as! String
                
                let p = Page(storyText: story, imageFileName: imageFile)
                self.pages.append(p)
            }
            
        }
        else {
            print("Story: No such path.")
        }
    }
    
    
}

/*
    StoryViewControllers need a plist file to get their data...
    for convenience, the name of each plist is set for every StoryViewController 
    in the storyboard as a runntime attribute.
*/
class StoryViewController: UIViewController, UIScrollViewDelegate {
    
    var storyFile:String! //SET AT RUNTIME IN STORYBOARD
    var story:Story?{
        didSet
        {
            self.generateStory()
        }
    }
    var pageViews = [PageView]()
    
    override func viewDidLoad() {
        self.story = Story(fileName: self.storyFile)
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let progress = scrollView.contentOffset.y/scrollView.frame.size.height
        
        for i in 0..<self.pageViews.count
        {
            let p = self.pageViews[i]
            p.updateProgressValue(progress - CGFloat(i))
        }
        
        if progress > (CGFloat(self.pageViews.count) - 0.8)
        {
            self.view.backgroundColor = UIColor.redColor()
            
            self.toNextGame()
        }
    }
    
    func generateStory() {
        
        if let s = self.story
        {
            let scrollView = self.view as! UIScrollView
            scrollView.contentSize = CGSize(width: scrollView.frame.width, height: scrollView.frame.height * CGFloat(s.pages.count) )
            scrollView.pagingEnabled = true
            scrollView.delegate = self
            scrollView.showsVerticalScrollIndicator = false
            
            for i in 0..<s.pages.count
            {
                let p = s.pages[i]
                
                let pageRect = CGRect(
                    x: 0,
                    y: CGFloat(i) * scrollView.frame.height,
                    width: scrollView.frame.width,
                    height: scrollView.frame.height)
                
                let pageView = PageView(frame: pageRect, storyText: p.storyText, imageFileName: p.imageFileName)
                
                self.pageViews.append(pageView)
                scrollView.addSubview(pageView)
            }
            
            
        }

    }
    
    func toNextGame()
    {
        self.performSegueWithIdentifier("toNextGame", sender: self)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
}