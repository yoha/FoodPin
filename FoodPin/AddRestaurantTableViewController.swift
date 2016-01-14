//
//  AddRestaurantTableViewController.swift
//  FoodPin
//
//  Created by Yohannes Wijaya on 12/26/15.
//  Copyright © 2015 Yohannes Wijaya. All rights reserved.
//

import UIKit
import CoreData

class AddRestaurantTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    // MARK: - Stored Properties
    
    var restaurant: RestaurantModel!
    var isThisRestaurantVisited: Bool!
    
    // MARK: - IBOutlet Methods
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var restaurantNameTextField: UITextField!
    @IBOutlet var restaurantTypeTextField: UITextField!
    @IBOutlet var restaurantLocationTextField: UITextField!
    @IBOutlet var restaurantPhoneNumberTextField: UITextField!
    @IBOutlet var yesButton: UIButton!
    @IBOutlet var noButton: UIButton!
    
    // MARK: - IBAction Methods
    
    @IBAction func saveButtonDidTouch(sender: UIBarButtonItem) {
        guard self.restaurantNameTextField.text?.characters.count > 0 &&
            self.restaurantTypeTextField.text?.characters.count > 0 &&
            self.restaurantLocationTextField.text?.characters.count > 0 &&
            self.restaurantPhoneNumberTextField.text?.characters.count > 0 else {
                let alertController = UIAlertController(title: "Oops", message: NSLocalizedString("We can't proceed because one of the fields is blank. Please note that all fields are required", comment: "alert about empty field"), preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "response to alert about empty field"), style: .Default, handler: nil))
            
                self.presentViewController(alertController, animated: true, completion: nil)
                return
        }
        
        // Save data to persistent storage using Core Data
        guard let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext else { return }
        self.restaurant = NSEntityDescription.insertNewObjectForEntityForName("RestaurantModel", inManagedObjectContext: managedObjectContext) as! RestaurantModel
        self.restaurant.name = self.restaurantNameTextField.text!
        self.restaurant.type = self.restaurantTypeTextField.text!
        self.restaurant.location = self.restaurantLocationTextField.text!
        self.restaurant.phoneNumber = self.restaurantPhoneNumberTextField.text!
        if let validRestaurantImage = self.imageView.image {
            self.restaurant.image = UIImagePNGRepresentation(validRestaurantImage)
        }
        self.restaurant.isVisited = self.isThisRestaurantVisited
        do {
            try managedObjectContext.save()
        }
        catch {
            print(error)
            return
        }
        
        self.performSegueWithIdentifier("unwindToHomeScreen", sender: self)
    }
    
    @IBAction func toggleBeenHereButtonDidSelect(sender: UIButton) {
        if sender.titleLabel?.text == NSLocalizedString("YES", comment: "response to user been to the restaurant") {
            self.yesButton.alpha = 1.0
            self.yesButton.backgroundColor = UIColor.redColor()
            self.noButton.backgroundColor = UIColor.blackColor()
            self.noButton.alpha = 0.1
            self.isThisRestaurantVisited = true
        }
        else if sender.titleLabel?.text == NSLocalizedString("NO", comment: "response to user been to the restaurant") {
            self.noButton.alpha = 1.0
            self.noButton.backgroundColor = UIColor.redColor()
            self.yesButton.backgroundColor = UIColor.blackColor()
            self.yesButton.alpha = 0.1
            self.isThisRestaurantVisited = false
        }
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
    
    // MARK: - UITextFieldDelegate Methods
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        let spacingBetweenBarButtonItems = UIBarButtonItem(barButtonSystemItem: .FixedSpace, target: nil, action: nil)
        spacingBetweenBarButtonItems.width = 20.0

        let keyboardToolbar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: self.view.bounds.width, height: 44))
        keyboardToolbar.barStyle = .Default
        keyboardToolbar.setItems([
            UIBarButtonItem(title: "<", style: UIBarButtonItemStyle.Plain, target: self, action: "goToPreviousTextField"),
            spacingBetweenBarButtonItems,
            UIBarButtonItem(title: ">", style: .Plain, target: self, action: "goToNextTextField"),
            UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Done", style: .Plain, target: self, action: "resignKeyboard")
        ], animated: true)
        
        textField.inputAccessoryView = keyboardToolbar
        
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    // MARK: - UIViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.restaurantNameTextField.delegate = self
        self.restaurantTypeTextField.delegate = self
        self.restaurantLocationTextField.delegate = self
        self.restaurantPhoneNumberTextField.delegate = self
    }
    
    // MARK: - Helper Methods
    
    func goToNextTextField() {
        if self.restaurantNameTextField.isFirstResponder() {
            self.restaurantNameTextField.resignFirstResponder()
            self.restaurantTypeTextField.becomeFirstResponder()
        }
        else if self.restaurantTypeTextField.isFirstResponder() {
            self.restaurantTypeTextField.resignFirstResponder()
            self.restaurantLocationTextField.becomeFirstResponder()
        }
        else if self.restaurantLocationTextField.isFirstResponder() {
            self.restaurantLocationTextField.resignFirstResponder()
            self.restaurantPhoneNumberTextField.becomeFirstResponder()
        }
        else if self.restaurantPhoneNumberTextField.isFirstResponder() {
            return
        }
    }
    
    func goToPreviousTextField() {
        if self.restaurantPhoneNumberTextField.isFirstResponder() {
           self.restaurantPhoneNumberTextField.resignFirstResponder()
            self.restaurantLocationTextField.becomeFirstResponder()
        }
        else if self.restaurantLocationTextField.isFirstResponder() {
            self.restaurantLocationTextField.resignFirstResponder()
            self.restaurantTypeTextField.becomeFirstResponder()
        }
        else if self.restaurantTypeTextField.isFirstResponder() {
            self.restaurantTypeTextField.resignFirstResponder()
            self.restaurantNameTextField.becomeFirstResponder()
        }
        else if self.restaurantNameTextField.isFirstResponder() {
            return
        }
    }
    
    func resignKeyboard() {
        self.view.endEditing(true)
    }
}
