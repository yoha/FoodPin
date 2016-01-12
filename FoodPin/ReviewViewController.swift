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
    @IBOutlet var ratingStackView: UIStackView!
    
    // MARK: - IBAction Properties
    
    @IBAction func ratingSelected(sender: UIButton) {
        switch (sender.tag) {
        case 50:
            self.rating = "dislike"
        case 75:
            self.rating = "good"
        case 100:
            self.rating = "great"
        default:
            break
        }
        self.performSegueWithIdentifier("unwindToRestaurantDetailVC", sender: sender)
    }
    
    // MARK: - Stored Properties
    
    var rating: String?
    
    // MARK: - UIViewController Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        self.backgroundImageView.addSubview(blurEffectView)
        
        let scaleTransform = CGAffineTransformMakeScale(0.0, 0.0)
        let translateTransform = CGAffineTransformMakeTranslation(0, 500)
        self.ratingStackView.transform = CGAffineTransformConcat(scaleTransform, translateTransform)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        UIView.animateWithDuration(0.4, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: { [unowned self] () -> Void in
            self.ratingStackView.transform = CGAffineTransformIdentity
            }, completion: nil)
    }
}
