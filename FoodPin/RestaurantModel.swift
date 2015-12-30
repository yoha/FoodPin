//
//  RestaurantModel.swift
//  FoodPin
//
//  Created by Yohannes Wijaya on 12/9/15.
//  Copyright © 2015 Yohannes Wijaya. All rights reserved.
//

import Foundation
import CoreData

class RestaurantModel: NSManagedObject {
    
    @NSManaged var name: String
    @NSManaged var type: String
    @NSManaged var location: String
    @NSManaged var phoneNumber: String?
    @NSManaged var image: NSData?
    @NSManaged var isVisited: NSNumber?
    @NSManaged var rating: String?
    
//    init (name: String, type: String, location: String, phoneNumber: String, image: NSData, isVisited: Bool = false) {
//        
//        self.name = name
//        self.type = type
//        self.location = location
//        self.phoneNumber = phoneNumber
//        self.image = image
//        self.isVisited = isVisited
//        self.rating = "rating"
//    }
}
