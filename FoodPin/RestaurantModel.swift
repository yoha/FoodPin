//
//  RestaurantModel.swift
//  FoodPin
//
//  Created by Yohannes Wijaya on 12/9/15.
//  Copyright © 2015 Yohannes Wijaya. All rights reserved.
//

import Foundation

class RestaurantModel {
    
    var name = ""
    var type = ""
    var location = ""
    var phoneNumber = ""
    var image = ""
    var isVisited = false
    var rating = ""
    
    init (name: String, type: String, location: String, phoneNumber: String, image: String, isVisited: Bool = false) {
        self.name = name
        self.type = type
        self.location = location
        self.phoneNumber = phoneNumber
        self.image = image
        self.isVisited = isVisited
        self.rating = "rating"
    }
}
