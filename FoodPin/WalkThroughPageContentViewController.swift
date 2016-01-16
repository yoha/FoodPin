//
//  WalkThroughContentViewController.swift
//  FoodPin
//
//  Created by Yohannes Wijaya on 1/6/16.
//  Copyright © 2016 Yohannes Wijaya. All rights reserved.
//

import UIKit

class WalkThroughPageContentViewController: UIViewController {
    
    // MARK: - IBOutlet Properties
    
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var indicatorPageControl: UIPageControl!
    @IBOutlet weak var forwardButton: UIButton!
    
    // MARK: - IBAction Properties
    
    @IBAction func forwardButtonDidTouch(sender: UIButton) {
        if sender.titleLabel?.text == NSLocalizedString("Done", comment: "navigation button on the bottom right") {
            self.dismissViewControllerAnimated(true, completion: nil)
            
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "userHasViewedWalkthrough")
            
            // Add quick actions (3D Touch)
            
            guard self.traitCollection.forceTouchCapability == UIForceTouchCapability.Available else { return }
            guard let bundleID = NSBundle.mainBundle().bundleIdentifier else { return }

            var applicationIconType: UIApplicationShortcutIconType?
            if #available(iOS 9.1, *) {
                applicationIconType = UIApplicationShortcutIconType.Favorite
            } else {
                applicationIconType = nil
            }
            let quickApplicationShortcut0 = UIApplicationShortcutItem(type: "\(bundleID).ShowFavorites", localizedTitle: "Show Favorites", localizedSubtitle: nil, icon: UIApplicationShortcutIcon(type: applicationIconType!), userInfo: nil)
            let quickApplicationShortcut1 = UIApplicationShortcutItem(type: "\(bundleID).ShowDiscoveries", localizedTitle: "Discover Restaurants", localizedSubtitle: nil, icon: UIApplicationShortcutIcon(type: .Search), userInfo: nil)
            let quickApplicationShortcut2 = UIApplicationShortcutItem(type: "\(bundleID).CreateNew", localizedTitle: "˙New Restaurant", localizedSubtitle: nil, icon: UIApplicationShortcutIcon(type: .Add), userInfo: nil)
            UIApplication.sharedApplication().shortcutItems  = [quickApplicationShortcut0, quickApplicationShortcut1, quickApplicationShortcut2]
        }
        else if case 0...1 = self.currentPageIndex {
            guard let pageViewController = self.parentViewController as? WalkthroughPageViewController else { return }
            pageViewController.goToTheNextPageContentViewController(self.currentPageIndex)
        }
    }
    
    // MARK: - Stored Properties
    
    var currentPageIndex = 0, heading = "", imageFile = "", content = ""
    
    // MARK: - UIViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.headingLabel.text = self.heading
        self.contentImageView.image = UIImage(named: self.imageFile)
        self.contentLabel.text = self.content
        
        self.indicatorPageControl.currentPage = self.currentPageIndex
        
        self.view.backgroundColor = UIColor(red: 242.0/255.0, green: 116.0/255.0, blue: 119.0/255.0, alpha: 1.0)
        self.headingLabel.textColor = UIColor.whiteColor()
        self.contentLabel.textColor = UIColor.whiteColor()
        
        self.forwardButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        if case 2 = self.currentPageIndex {
            self.forwardButton.setTitle(NSLocalizedString("Done", comment: "navigation button on the bottom right"), forState: .Normal)
        }
        else {
            self.forwardButton.setTitle(NSLocalizedString("Next", comment: "navigation button on the bottom right"), forState: .Normal)
        }
    }
}
