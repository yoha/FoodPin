//
//  AboutTableViewController.swift
//  FoodPin
//
//  Created by Yohannes Wijaya on 1/10/16.
//  Copyright © 2016 Yohannes Wijaya. All rights reserved.
//

import UIKit
import SafariServices

class AboutTableViewController: UITableViewController {
    
    // MARK: - Stored Properties
    
    let sectionTitles = [NSLocalizedString("Leave Feedback", comment: "section title 0"), NSLocalizedString("Follow Us", comment: "section title 1")]
    let sectionContent = [[NSLocalizedString("Rate us on the App Store", comment: "section content 0"), NSLocalizedString("Tell us your feedback", comment: "section content 1")], [NSLocalizedString("Twitter", comment: "social media 0"), NSLocalizedString("Facebook", comment: "social media 1"), NSLocalizedString("Pinterest", comment: "social media 2")]]
    let links = ["https://twitter.com/appcodamobile", "https://facebook.com/appcodamobile", "https://pinterest.com/appcoda/"]
    let rateAppUrl = "http://apple.com/itunes/charts/paid-apps/"

    // MARK: - UITableViewDataSource Methods

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let firstSectionRowCount = self.sectionContent.first?.count else { return 0 }
        guard let secondSectionRowCount = self.sectionContent.last?.count else { return 0 }
        return section == 0 ? firstSectionRowCount : secondSectionRowCount
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AboutTableViewCell", forIndexPath: indexPath)
        
        guard let validTextLabel: String = self.sectionContent[indexPath.section][indexPath.row] else { return cell }
        cell.textLabel?.text = validTextLabel
        
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sectionTitles[section]
    }
    
    // MARK: - UITableViewDelegate Methods
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if case 0 = indexPath.section {
            switch indexPath.row {
            case 0:
                guard let validRateAppUrl = NSURL(string: self.rateAppUrl) else { break }
                UIApplication.sharedApplication().openURL(validRateAppUrl)
            case 1:
                self.performSegueWithIdentifier("webViewSegue", sender: self)
            default:
                break
            }
        }
        else if case 1 = indexPath.section {
            guard let validSocialLink = NSURL(string: self.links[indexPath.row]) else { return }
            let safariController = SFSafariViewController(URL: validSocialLink)
            self.presentViewController(safariController, animated: true, completion: nil)
        }
        
        self.tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    // MARK: - UIViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
    }

}
