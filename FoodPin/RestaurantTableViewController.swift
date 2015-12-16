//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Yohannes Wijaya on 12/2/15.
//  Copyright © 2015 Yohannes Wijaya. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    
    // MARK: - Stored Properties
    
//    let restaurantModel = RestaurantModel()
    
//    var restaurantsVisited = [Bool](count: 21, repeatedValue: false)
    
    var restaurants:[RestaurantModel] = [
        RestaurantModel(name: "Cafe Deadend", type: "Coffee & Tea Shop", location: "Hong Kong", phone: "123-456-7890", image: "cafedeadend.jpg"),
        RestaurantModel(name: "Homei", type: "Cafe", location: "Hong Kong", phone: "123-456-7890", image: "homei.jpg"),
        RestaurantModel(name: "Teakha", type: "Tea House", location: "Hong Kong", phone: "123-456-7890", image: "teakha.jpg"),
        RestaurantModel(name: "Cafe loisl", type: "Austrian / Causual Drink", location: "Hong Kong", phone: "123-456-7890", image: "cafeloisl.jpg"),
        RestaurantModel(name: "Petite Oyster", type: "French", location: "Hong Kong", phone: "123-456-7890", image: "petiteoyster.jpg"),
        RestaurantModel(name: "For Kee Restaurant", type: "Bakery", location: "Hong Kong", phone: "123-456-7890", image: "forkeerestaurant.jpg"),
        RestaurantModel(name: "Po's Atelier", type: "Bakery", location: "Hong Kong", phone: "123-456-7890", image: "posatelier.jpg"),
        RestaurantModel(name: "Bourke Street Backery", type: "Chocolate", location: "Sydney", phone: "123-456-7890", image: "bourkestreetbakery.jpg"),
        RestaurantModel(name: "Haigh's Chocolate", type: "Cafe", location: "Sydney", phone: "123-456-7890", image: "haighschocolate.jpg"),
        RestaurantModel(name: "Palomino Espresso", type: "American / Seafood", location: "Sydney", phone: "123-456-7890", image: "palominoespresso.jpg"),
        RestaurantModel(name: "Upstate", type: "American", location: "New York", phone: "123-456-7890", image: "upstate.jpg"),
        RestaurantModel(name: "Traif", type: "American", location: "New York", phone: "123-456-7890", image: "traif.jpg"),
        RestaurantModel(name: "Graham Avenue Meats", type: "Breakfast & Brunch", location: "New York", phone: "123-456-7890", image: "grahamavenuemeats.jpg"),
        RestaurantModel(name: "Waffle & Wolf", type: "Coffee & Tea", location: "New York", phone: "123-456-7890", image: "wafflewolf.jpg"),
        RestaurantModel(name: "Five Leaves", type: "Coffee & Tea", location: "New York", phone: "123-456-7890", image: "fiveleaves.jpg"),
        RestaurantModel(name: "Cafe Lore", type: "Latin American", location: "New York", phone: "123-456-7890", image: "cafelore.jpg"),
        RestaurantModel(name: "Confessional", type: "Spanish", location: "New York", phone: "123-456-7890", image: "confessional.jpg"),
        RestaurantModel(name: "Barrafina", type: "Spanish", location: "London", phone: "123-456-7890", image: "barrafina.jpg"),
        RestaurantModel(name: "Donostia", type: "Spanish", location: "London", phone: "123-456-7890", image: "donostia.jpg"),
        RestaurantModel(name: "Royal Oak", type: "British", location: "London", phone: "123-456-7890", image: "royaloak.jpg"),
        RestaurantModel(name: "Thai Cafe", type: "Thai", location: "London", phone: "123-456-7890", image: "thaicafe.jpg")
    ]
    
    // MARK: - UIViewController Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.hidesBarsOnSwipe = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showRestaurantDetail" {
            guard let indexPath = self.tableView.indexPathForSelectedRow else { return }
            let destinationViewController = segue.destinationViewController as! RestaurantDetailViewController
            destinationViewController.restaurant = self.restaurants[indexPath.row]
        }
    }
    
    // MARK: - Table View Delegate Methods
    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: UIAlertControllerStyle.ActionSheet)
//        
//        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
//        optionMenu.addAction(cancelAction)
//        
//        let callAction = UIAlertAction(title: "Call 123-000-\(indexPath.row)", style: .Default) { [unowned self] (action: UIAlertAction) -> Void in
//            let alertMessage = UIAlertController(title: "Service Unavailable", message: "Sorry, the call feature is not available yet. Please retry later.", preferredStyle: .Alert)
//            alertMessage.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
//            self.presentViewController(alertMessage, animated: true, completion: nil)
//        }
//        optionMenu.addAction(callAction)
//        
//        if self.restaurantsVisited[indexPath.row] {
//            let hasNotVisitedBeforeAction = UIAlertAction(title: "I've not been here", style: .Default, handler: { (action: UIAlertAction) -> Void in
//                guard let cell = self.tableView.cellForRowAtIndexPath(indexPath) else { return }
//                cell.accessoryType = UITableViewCellAccessoryType.None
//                self.restaurants[indexPath.row].isVisited = false
//                self.restaurantsVisited[indexPath.row] = false
//            })
//            optionMenu.addAction(hasNotVisitedBeforeAction)
//        }
//        else {
//            let hasVisitedBeforeAction = UIAlertAction(title: "I've been here", style: .Default) { [unowned self] (action: UIAlertAction) -> Void in
//                guard let cell = self.tableView.cellForRowAtIndexPath(indexPath) else { return }
//                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
//                self.restaurants[indexPAth.row].isVisited = true
//            }
//            optionMenu.addAction(hasVisitedBeforeAction)
//        }
//        
//        self.presentViewController(optionMenu, animated: true, completion: nil)
//        
//        self.tableView.deselectRowAtIndexPath(indexPath, animated: false)
//    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        // Social Sharing Button
        let shareAction = UITableViewRowAction(style: .Default, title: "Share") { (action, indexPath) -> Void in
            let defaultText = "Just checking in at " + self.restaurants[indexPath.row].name
            guard let imageToShare = UIImage(named: self.restaurants[indexPath.row].image) else { return }
            let activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
            self.presentViewController(activityController, animated: true, completion: nil)
        }
        
        // Delete Button
        let deleteAction = UITableViewRowAction(style: .Default, title: "Delete") { (action, indexPath) -> Void in
            // Delete the row from the data source
            self.restaurants.removeAtIndex(indexPath.row)
    
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
        
        shareAction.backgroundColor = UIColor(red: 28.0/255.0, green: 165.0/255.0, blue: 253.0/255.0, alpha: 1.0)
        
        return [deleteAction, shareAction]
    }

    // MARK: - Table View Data Source Methods

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.restaurants.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RestaurantTableViewCell

        // Configure the cell...
        cell.thumbnailImageView.image = UIImage(named: self.restaurants[indexPath.row].image)
        cell.nameLabel.text = self.restaurants[indexPath.row].name
        cell.locationLabel.text = self.restaurants[indexPath.row].location
        cell.typeLabel.text = self.restaurants[indexPath.row].type
            
        cell.accessoryType = self.restaurants[indexPath.row].isVisited ? .Checkmark : .None

        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            self.restaurants.removeAtIndex(indexPath.row)
        }
        self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
