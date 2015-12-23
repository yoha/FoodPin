//
//  MapViewController.swift
//  FoodPin
//
//  Created by Yohannes Wijaya on 12/23/15.
//  Copyright © 2015 Yohannes Wijaya. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    // MARK: - IBOutlet Properties
    
    @IBOutlet var mapview: MKMapView!
    
    // MARK: - Stored Properties
    
    var restaurant: RestaurantModel!
    
    // MARK: - UIViewController Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        // Convert address to coordinate and annotate it on the map
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(self.restaurant.location) { (placemarks, error) -> Void in
            guard error == nil else {
                print(error)
                return
            }
            
            // Validate placemark objects
            guard let validPlacemarks = placemarks else { return }
            
            // Get the first placemark object
            let validPlacemark = validPlacemarks.first!
            
            // Add annotation
            let annotation = MKPointAnnotation()
            annotation.title = self.restaurant.name
            annotation.subtitle = self.restaurant.type
            
            // Validate placemark's location
            guard let validLocation = validPlacemark.location else { return }
            annotation.coordinate = validLocation.coordinate
            
            // Display the annotation
            self.mapview.showAnnotations([annotation], animated: true)
            self.mapview.selectAnnotation(annotation, animated: true)
        }
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
