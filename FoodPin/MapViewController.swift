//
//  MapViewController.swift
//  FoodPin
//
//  Created by Yohannes Wijaya on 12/23/15.
//  Copyright © 2015 Yohannes Wijaya. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    // MARK: - IBOutlet Properties
    
    @IBOutlet var mapview: MKMapView!
    
    // MARK: - Stored Properties
    
    var restaurant: RestaurantModel!
    
    // MARK: - UIViewController Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapview.delegate = self

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
        
        // Display traffic, compass, & scale info
        self.mapview.showsTraffic = true
        self.mapview.showsCompass = true
        self.mapview.showsScale = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - MKMapView Delegate Methods
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let pinIdentifier = "MyPin"
        
        // We want the placemark's annotation object not user's current location's annotation object
        if annotation.isKindOfClass(MKUserLocation) {
            return nil
        }
        
        // Reuse the annotation if possible
        var annotationView = self.mapview.dequeueReusableAnnotationViewWithIdentifier(pinIdentifier) as? MKPinAnnotationView
        
        // Otherwise make a new one
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: pinIdentifier)
            annotationView?.canShowCallout = true
        }
        
        let leftIconView = UIImageView(frame: CGRectMake(0.0, 0.0, 53.0, 53.0))
        guard let validImageData = self.restaurant.image else { return nil }
        leftIconView.image = UIImage(data: validImageData)
        annotationView?.leftCalloutAccessoryView = leftIconView
        
        // Change the pin color
        annotationView?.pinTintColor = UIColor.blackColor()

        return annotationView
    }
}
