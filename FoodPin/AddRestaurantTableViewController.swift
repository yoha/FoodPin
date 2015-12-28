//
//  AddRestaurantTableViewController.swift
//  FoodPin
//
//  Created by Yohannes Wijaya on 12/26/15.
//  Copyright © 2015 Yohannes Wijaya. All rights reserved.
//

import UIKit

class AddRestaurantTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - IBOutlet Methods
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var restaurantNameTextField: UITextField!
    @IBOutlet var restaurantTypeTextField: UITextField!
    @IBOutlet var restaurantLocationTextField: UITextField!
    @IBOutlet var yesButton: UIButton!
    @IBOutlet var noButton: UIButton!
    
    // MARK: - IBAction Methods
    
    @IBAction func saveButtonDidTouch(sender: UIBarButtonItem) {
        guard self.restaurantNameTextField.text?.characters.count > 0 &&
            self.restaurantTypeTextField.text?.characters.count > 0 &&
            self.restaurantLocationTextField.text?.characters.count > 0 else {
                let alertController = UIAlertController(title: "Oops", message: "We can't proceed because one of the fields is blank. Please note that all fields are required", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            
                self.presentViewController(alertController, animated: true, completion: nil)
                return
        }
        
        print("Restaurant name: \(self.restaurantNameTextField.text!)")
        print("Restaurant type: \(self.restaurantTypeTextField.text!)")
        print("Restaurant location: \(self.restaurantLocationTextField.text!)")
        
        yesButton.alpha == 1.0 ? print("User has been here before") : print("User has not been here before")
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
//    @IBAction func yesButtonDidTouch(sender: UIButton) {
//        self.yesButton.alpha = 1.0
//        self.yesButton.backgroundColor = UIColor.redColor()
//        self.noButton.backgroundColor = UIColor.blackColor()
//        self.noButton.alpha = 0.1
//    }
    
    
//    @IBAction func noButtonDidTouch(sender: UIButton) {
//        self.noButton.alpha = 1.0
//        self.noButton.backgroundColor = UIColor.redColor()
//        self.yesButton.backgroundColor = UIColor.blackColor()
//        self.yesButton.alpha = 0.1
//    }
    
    @IBAction func toggleBeenHereButtonDidSelect(sender: UIButton) {
        if sender.titleLabel?.text == "YES" {
            self.yesButton.alpha = 1.0
            self.yesButton.backgroundColor = UIColor.redColor()
            self.noButton.backgroundColor = UIColor.blackColor()
            self.noButton.alpha = 0.1
        }
        else if sender.titleLabel?.text == "NO" {
            self.noButton.alpha = 1.0
            self.noButton.backgroundColor = UIColor.redColor()
            self.yesButton.backgroundColor = UIColor.blackColor()
            self.yesButton.alpha = 0.1
        }
    }
    
    // MARK: - UIViewController Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        self.imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.imageView.contentMode = UIViewContentMode.ScaleAspectFill
        self.imageView.clipsToBounds = true
        
        // Set up the leading, trailing, top, and bottom constraints of the image view programatically so that it fills up the cell's space. 
        let leadingConstraint = NSLayoutConstraint(item: self.imageView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self.imageView.superview, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0)
        leadingConstraint.active = true
        
        let trailingConstraint = NSLayoutConstraint(item: self.imageView, attribute: .Trailing, relatedBy: .Equal, toItem: self.imageView.superview, attribute: .Trailing, multiplier: 1, constant: 0)
        trailingConstraint.active = true
        
        let topConstraint = NSLayoutConstraint(item: self.imageView, attribute: .Top, relatedBy: .Equal, toItem: self.imageView.superview, attribute: .Top, multiplier: 1, constant: 0)
        topConstraint.active = true
        
        let bottomConstraint = NSLayoutConstraint(item: self.imageView, attribute: .Bottom, relatedBy: .Equal, toItem: self.imageView.superview, attribute: .Bottom, multiplier: 1, constant: 0)
        bottomConstraint.active = true
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - UITableViewDelegate Methods
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Make sure that only the first row that can trigger the image picker
        guard indexPath.row == 0 else { return }
        guard UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) else { return }
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        self.presentViewController(imagePicker, animated: true, completion: nil)
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    // MARK: - Table view data source

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
