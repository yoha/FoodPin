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
    var image = ""
    var isVisited = false
    
    init (name: String, type: String, location: String, image: String, isVisited: Bool = false) {
        self.name = name
        self.type = type
        self.location = location
        self.image = image
        self.isVisited = isVisited
    }
}
