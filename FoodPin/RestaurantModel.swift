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
    var phone = ""
    var image = ""
    var isVisited = false
    
    init (name: String, type: String, location: String, phone: String, image: String, isVisited: Bool = false) {
        self.name = name
        self.type = type
        self.location = location
        self.phone = phone
        self.image = image
        self.isVisited = isVisited
    }
}
