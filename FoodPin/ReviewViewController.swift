//
//  ReviewViewController.swift
//  FoodPin
//
//  Created by Yohannes Wijaya on 12/21/15.
//  Copyright © 2015 Yohannes Wijaya. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {
    
    // MARK: - IBOutlet Properties
    
    @IBOutlet var backgroundImageView: UIImageView!
    
    // MARK: - UIViewController Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        self.backgroundImageView.addSubview(blurEffectView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
