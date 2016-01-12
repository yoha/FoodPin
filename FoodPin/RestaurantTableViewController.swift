//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Yohannes Wijaya on 12/2/15.
//  Copyright © 2015 Yohannes Wijaya. All rights reserved.
//

import UIKit
import CoreData

class RestaurantTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating {
    
    // MARK: - Stored Properties
    
    var restaurants = [RestaurantModel]()
    
    var fetchResultController: NSFetchedResultsController!
    
    var searchController: UISearchController!
    var searchResults: [RestaurantModel] = []
    
    // MARK: - IBAction Properties
    
    @IBAction func dismissNewEntry(segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func helpButtonDidTouch(sender: UIBarButtonItem) {
        guard let pageViewcontroller = self.storyboard?.instantiateViewControllerWithIdentifier("WalkthroughPageViewController") as? WalkthroughPageViewController else { return }
        self.presentViewController(pageViewcontroller, animated: true, completion: nil)
    }
    
    // MARK: - Local Methods
    
    func filterContentForSearchText(parameter: String) {
        self.searchResults = self.restaurants.filter({ (restaurant) -> Bool in
            let matchingName = restaurant.name.rangeOfString(parameter, options: NSStringCompareOptions.CaseInsensitiveSearch)
            let matchingLocation = restaurant.location.rangeOfString(parameter, options: .CaseInsensitiveSearch)
            return matchingName != nil || matchingLocation != nil
        })
    }
    
    // MARK: - NSFetchedResultsControllerDelegate Methods
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case NSFetchedResultsChangeType.Insert:
            if let freshIndexPath = newIndexPath {
                self.tableView.insertRowsAtIndexPaths([freshIndexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            }
        case .Delete:
            if let depreciatedIndexPath = indexPath {
                self.tableView.deleteRowsAtIndexPaths([depreciatedIndexPath], withRowAnimation: .Fade)
            }
        case .Update:
            if let changedIndexPath = indexPath {
                self.tableView.reloadRowsAtIndexPaths([changedIndexPath], withRowAnimation: .Fade)
            }
        default:
            self.tableView.reloadData()
        }
        self.restaurants = controller.fetchedObjects as? [RestaurantModel] ?? []
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
    }
    
    // MARK: - UISearchResultsUpdating Protocol Method
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        guard let searchText = self.searchController.searchBar.text else { return }
        self.filterContentForSearchText(searchText)
        self.tableView.reloadData()
    }
    
    // MARK: - UIViewController Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
            
        self.tableView.estimatedRowHeight = 36
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.tableView.tableHeaderView = self.searchController.searchBar
        
        // Fetch data from persistent storage using Core Data option 1: [more efficient way; only load and display the change]
        let fetchRequest = NSFetchRequest(entityName: "RestaurantModel")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        guard let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext else { return }
        self.fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        self.fetchResultController.delegate = self
        
        do {
            try self.fetchResultController.performFetch()
            guard let validFetchedObjects = self.fetchResultController.fetchedObjects as? [RestaurantModel] else { return }
            self.restaurants = validFetchedObjects
        }
        catch {
            print(error)
        }
        
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        if NSUserDefaults.standardUserDefaults().boolForKey("userHasViewedWalkthrough") {
            return
        }
        else {
            guard let pageViewcontroller = self.storyboard?.instantiateViewControllerWithIdentifier("WalkthroughPageViewController") as? WalkthroughPageViewController else { return }
            self.presentViewController(pageViewcontroller, animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.hidesBarsOnSwipe = true
        
        /*** Fetch data from persistent storage using Core Data option 0: [less efficient way since all restaurants are reloaded & redisplayed every time]
        
        guard let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext else { return }
        let fetchRequest = NSFetchRequest(entityName: "RestaurantModel")
        do {
            self.restaurants = try managedObjectContext.executeFetchRequest(fetchRequest) as! [RestaurantModel]
            self.tableView.reloadData()
        }
        catch {
            print(error)
            return
        }
        
        ***/
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showRestaurantDetail" {
            guard let indexPath = self.tableView.indexPathForSelectedRow else { return }
            let destinationViewController = segue.destinationViewController as! RestaurantDetailViewController
            destinationViewController.restaurant = self.searchController.active ? self.searchResults[indexPath.row] : self.restaurants[indexPath.row]
            destinationViewController.hidesBottomBarWhenPushed = true
        }
    }
    
    // MARK: - UITableViewDelegate    Methods
    
    /***
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        optionMenu.addAction(cancelAction)
        
        let callAction = UIAlertAction(title: "Call 123-000-\(indexPath.row)", style: .Default) { [unowned self] (action: UIAlertAction) -> Void in
            let alertMessage = UIAlertController(title: "Service Unavailable", message: "Sorry, the call feature is not available yet. Please retry later.", preferredStyle: .Alert)
            alertMessage.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alertMessage, animated: true, completion: nil)
        }
        optionMenu.addAction(callAction)
        
        if self.restaurantsVisited[indexPath.row] {
            let hasNotVisitedBeforeAction = UIAlertAction(title: "I've not been here", style: .Default, handler: { (action: UIAlertAction) -> Void in
                guard let cell = self.tableView.cellForRowAtIndexPath(indexPath) else { return }
                cell.accessoryType = UITableViewCellAccessoryType.None
                self.restaurants[indexPath.row].isVisited = false
                self.restaurantsVisited[indexPath.row] = false
            })
            optionMenu.addAction(hasNotVisitedBeforeAction)
        }
        else {
            let hasVisitedBeforeAction = UIAlertAction(title: "I've been here", style: .Default) { [unowned self] (action: UIAlertAction) -> Void in
                guard let cell = self.tableView.cellForRowAtIndexPath(indexPath) else { return }
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                self.restaurants[indexPAth.row].isVisited = true
            }
            optionMenu.addAction(hasVisitedBeforeAction)
        }
        
        self.presentViewController(optionMenu, animated: true, completion: nil)
        
        self.tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    ***/
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        // Social Sharing Button
        let shareAction = UITableViewRowAction(style: .Default, title: NSLocalizedString("Share", comment: "share label for restaurant entry")) { (tableViewRowAction, indexPath) -> Void in
            let defaultText = NSLocalizedString("Just checking in at ", comment: "prepended text to shared location") + self.restaurants[indexPath.row].name
            guard let validImageData = self.restaurants[indexPath.row].image else { return }
            guard let imageToShare = UIImage(data: validImageData) else { return }
            let activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
            self.presentViewController(activityController, animated: true, completion: nil)
        }
        
        // Delete data in db and in table view using core data
        let deleteAction = UITableViewRowAction(style: .Default, title: NSLocalizedString("Delete", comment: "delete label for restaurant entry")) { (tableViewRowAction, indexPath) -> Void in
            guard let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext else { return }
            guard let restaurantToDelete = self.fetchResultController.objectAtIndexPath(indexPath) as? RestaurantModel else { return }
            managedObjectContext.deleteObject(restaurantToDelete)
            
            do {
                try managedObjectContext.save()
            }
            catch {
                print(error)
            }
        }
        
        shareAction.backgroundColor = UIColor(red: 28.0/255.0, green: 165.0/255.0, blue: 253.0/255.0, alpha: 1.0)
        
        return [deleteAction, shareAction]
    }

    // MARK: - UITableViewDataSource Methods

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchController.active ? self.searchResults.count : self.restaurants.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "RestaurantTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RestaurantTableViewCell

        let eachRestaurant = self.searchController.active ? self.searchResults[indexPath.row] : self.restaurants[indexPath.row]
        
        // Configure the cell...
        guard let validImageData = eachRestaurant.image else { return cell }
        cell.thumbnailImageView.image = UIImage(data: validImageData)
        cell.nameLabel.text = eachRestaurant.name
        cell.locationLabel.text = eachRestaurant.location
        cell.typeLabel.text = eachRestaurant.type
        guard let isIndeedVisited = eachRestaurant.isVisited?.boolValue else { return cell }
        cell.accessoryType = isIndeedVisited ? .Checkmark : .None

        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return self.searchController.active ? false : true
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

}
