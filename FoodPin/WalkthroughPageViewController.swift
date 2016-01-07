//
//  WalkthroughPageViewController.swift
//  FoodPin
//
//  Created by Yohannes Wijaya on 1/6/16.
//  Copyright © 2016 Yohannes Wijaya. All rights reserved.
//

import UIKit

class WalkthroughPageViewController: UIPageViewController, UIPageViewControllerDataSource {

    // MARK: - Stored Properties
    
    let pageHeadings = ["Personalize", "Locate", "Discover"]
    let pageImages = ["foodpin-intro-1", "foodpin-intro-2", "foodpin-intro-3"]
    let pageContent = [
        "Pin your favorite restaurants and create your own food guide",
        "Search and locate your favorite restaurant on the map",
        "Find restaurants pinned by your friends and other foodies around the world"
    ]
    
    // MARK: - UIPageViewControllerDataSource Methods
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        guard var pageIndex = (viewController as? WalkThroughPageContentViewController)?.currentPageIndex else { return nil }
        --pageIndex
        return self.createPageContentViewControllerOnDemandAtIndex(pageIndex)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        guard var pageIndex = (viewController as? WalkThroughPageContentViewController)?.currentPageIndex else { return nil }
        ++pageIndex
        return self.createPageContentViewControllerOnDemandAtIndex(pageIndex)
    }
    
    /*** Call these two methods if you want to have default page indicator & remove UIPageControl object from IB
     
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.pageHeadings.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        if let pageContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("WalkthroughPageContentViewController") as? WalkThroughPageContentViewController {
            return pageContentViewController.currentPageIndex
        }
        else { return 0 }
    }
    ***/
    
    // MARK: - UIViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        
        guard let startingPageContentViewController = self.createPageContentViewControllerOnDemandAtIndex(0) else { return }
        self.setViewControllers([startingPageContentViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
    }

    // MARK: - Local Methods
    
    func createPageContentViewControllerOnDemandAtIndex(index: Int) -> WalkThroughPageContentViewController? {
        guard index >= 0 && index < self.pageHeadings.count else { return nil }
        if let pageContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("WalkthroughPageContentViewController") as? WalkThroughPageContentViewController {
            pageContentViewController.heading = self.pageHeadings[index]
            pageContentViewController.imageFile = self.pageImages[index]
            pageContentViewController.content = self.pageContent[index]
            pageContentViewController.currentPageIndex = index
            
            return pageContentViewController
        }
        else { return nil }
    }
    
    func goToTheNextPageContentViewController(index: Int) {
        guard let nextPageContentViewController = self.createPageContentViewControllerOnDemandAtIndex(index + 1) else { return }
        self.setViewControllers([nextPageContentViewController], direction: .Forward, animated: true, completion: nil)
    }
}
