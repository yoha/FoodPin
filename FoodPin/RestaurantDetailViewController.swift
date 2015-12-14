//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by Yohannes Wijaya on 12/12/15.
//  Copyright © 2015 Yohannes Wijaya. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController {
    
    // MARK: - IBOutlet Properties
    
    @IBOutlet var restaurantImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    
    // MARK: - Stored Properties
    
    var restaurant: RestaurantModel!
    
    // MARK: - UIViewController Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.restaurantImageView.image = UIImage(named: self.restaurant.image)
//        self.nameLabel.text = self.restaurant.name
//        self.typeLabel.text = self.restaurant.type
//        self.locationLabel.text = self.restaurant.location
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
