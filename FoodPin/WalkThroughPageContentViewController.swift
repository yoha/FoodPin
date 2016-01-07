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
    }
}
