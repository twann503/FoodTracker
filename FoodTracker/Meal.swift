//
//  Meal.swift
//  FoodTracker
//
//  Created by Thuan on 3/7/18.
//  Copyright © 2018 Thuan. All rights reserved.
//

import UIKit
import os.log

struct PropertyKey {
    static let name = "name"
    static let photo = "photo"
    static let rating = "rating"
}

class Meal : NSObject, NSCoding {
    
    //MARK: Properties
    
    var name: String
    var photo: UIImage?
    var rating: Int
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    
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
    
    
    //MARK: NSCoding
    //Used for presistance storage of data after exiting app
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(rating, forKey: PropertyKey.rating)
        
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        //makes sure that the object meal must have a name to be loaded, otherwise fail
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        
        // Must call designated initializer.
        self.init(name: name, photo: photo, rating: rating)
        
    }
 
    
}
