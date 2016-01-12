//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by Yohannes Wijaya on 12/12/15.
//  Copyright © 2015 Yohannes Wijaya. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - IBOutlet Properties
    
    @IBOutlet var restaurantImageView: UIImageView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var ratingButton: UIButton!
    
    // MARK: - IBAction Properties
    
    @IBAction func dismissReview(segue: UIStoryboardSegue) {
        guard let validReviewViewController = segue.sourceViewController as? ReviewViewController else { return }
        guard let validRating = validReviewViewController.rating where validRating != "" else { return }
        self.restaurant.rating = validRating
        self.ratingButton.setImage(UIImage(named: validRating), forState: .Normal)
        
        guard let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext else { return }
        do {
            try managedObjectContext.save()
        }
        catch {
            print(error)
        }
    }
    
    // MARK: - Stored Properties
    
    var restaurant: RestaurantModel!
    
    // MARK: - UIViewController Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let validImageData = self.restaurant.image else { return }
        self.restaurantImageView.image = UIImage(data: validImageData)
        
        self.tableView.backgroundColor = UIColor(red: 0.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.2)
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        self.tableView.separatorColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.8)
        
        self.tableView.estimatedRowHeight = 36.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.hidesBarsOnSwipe = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        guard let validRating = self.restaurant.rating where validRating != "" else { return }
        self.ratingButton.setImage(UIImage(named: validRating), forState: UIControlState.Normal)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMap" {
            let destinationViewController = segue.destinationViewController as! MapViewController
            destinationViewController.restaurant = self.restaurant
        }
    }
    
    // MARK:- UITableViewDataSource Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RestaurantDetailTableViewCell", forIndexPath: indexPath) as! RestaurantDetailTableViewCell
        
        // configure the cell...
        switch indexPath.row {
        case 0:
            cell.fieldLabel.text = NSLocalizedString("Name", comment: "Name Field")
            cell.valueLabel.text = self.restaurant.name
        case 1:
            cell.fieldLabel.text = NSLocalizedString("Type", comment: "Type Field")
            cell.valueLabel.text = self.restaurant.type
        case 2:
            cell.fieldLabel.text = NSLocalizedString("Location", comment: "Location/Address Field")
            cell.valueLabel.text = self.restaurant.location
        case 3:
            cell.fieldLabel.text = NSLocalizedString("Phone", comment: "Phone Field")
            cell.valueLabel.text = self.restaurant.phoneNumber
        case 4:
            cell.fieldLabel.text = NSLocalizedString("Been here", comment: "Has user been here Field")
            guard let isIndeedVisited = self.restaurant.isVisited?.boolValue else { break }
            cell.valueLabel.text = isIndeedVisited ? NSLocalizedString("Yes", comment: "User has been here before") : NSLocalizedString("No", comment: "User has not been here before")
        default:
            cell.fieldLabel.text = ""
            cell.valueLabel.text = ""
        }
        cell.backgroundColor = UIColor.clearColor()
        
        return cell
    }
}
