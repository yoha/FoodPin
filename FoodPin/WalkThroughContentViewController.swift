//
//  WalkThroughContentViewController.swift
//  FoodPin
//
//  Created by Yohannes Wijaya on 1/6/16.
//  Copyright © 2016 Yohannes Wijaya. All rights reserved.
//

import UIKit

class WalkThroughContentViewController: UIViewController {
    
    // MARK: - IBOutlet Properties
    
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    
    // MARK: - Stored Properties
    
    var currentPageIndex = 0, heading = "", imageFile = "", content = ""
    
    // MARK: - UIViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.headingLabel.text = self.heading
        self.contentImageView.image = UIImage(named: self.imageFile)
        self.contentLabel.text = self.content
    }
}
