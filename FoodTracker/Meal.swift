//
//  Meal.swift
//  FoodTracker
//
//  Created by Thuan on 3/7/18.
//  Copyright © 2018 Thuan. All rights reserved.
//

import UIKit

class Meal {
    
    var name: String
    var photo: UIImage?
    var rating: Int
    
    //class initilizer , ? means its failable
    init?(name:String, photo:UIImage?, rating:Int) {
        
        //name cannot be empty
        guard !name.isEmpty else {
            return nil
        }
        
        //check if rating between 0 - 5
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        
        self.name = name
        self.photo = photo
        self.rating = rating
    }
    
    
}
