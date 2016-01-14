//
//  WebViewController.swift
//  FoodPin
//
//  Created by Yohannes Wijaya on 1/10/16.
//  Copyright © 2016 Yohannes Wijaya. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    
    // MARK: - IBOutlet Properties
    
    @IBOutlet var webView: UIWebView!
    
    // MARK: - UIViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let validUrl = NSURL(string: "http://appcoda.com/contact/") else { return }
        let urlRequest = NSURLRequest(URL: validUrl)
        self.webView.loadRequest(urlRequest)
    }
}
