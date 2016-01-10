//
//  AboutTableViewController.swift
//  FoodPin
//
//  Created by Yohannes Wijaya on 1/10/16.
//  Copyright © 2016 Yohannes Wijaya. All rights reserved.
//

import UIKit

class AboutTableViewController: UITableViewController {
    
    // MARK: - Stored Properties
    
    let sectionTitles = ["Leave Feedback", "Follow US"]
    let sectionContent = [["Rate us on App Store", "Tell us your feedback"], ["Twitter", "Facebook", "Pinterest"]]
    let links = ["https://twitter.com/appcodamobile", "https://facebook.com/appcodamobile", "https://pinterest.com/appcoda/"]

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
    
    // MARK: - UIViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
    }

}
