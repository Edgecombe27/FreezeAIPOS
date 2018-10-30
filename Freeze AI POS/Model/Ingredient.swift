//
//  Ingredient.swift
//  Freeze AI POS
//
//  Created by Spencer Geoffrey Edgecombe on 2018-10-30.
//  Copyright © 2018 Spencer Geoffrey Edgecombe. All rights reserved.
//

import Foundation
import SwiftyJSON

class Ingredient {
    let id : Int
    let title : String
    let price : Float
    var error : JSON?
    
    init (_ data : JSON) throws {
        self.error = nil
        if let id : Int = data[Keys.Ingredient.id].int { self.id = id }
        else {
            self.id = 0
            self.error = data[Keys.Ingredient.id]
        }
        
        if let title : String = data[Keys.Ingredient.title].string { self.title = title }
        else {
            self.title = ""
            self.error = data[Keys.Ingredient.title]
        }
        
        if let price : Float = data[Keys.Ingredient.price].float { self.price = price }
        else {
            self.price = 0.0
            self.error = data[Keys.Ingredient.title]
        }
        
        if self.error != nil {
            throw JSONFailure.readFailure(json: self.error!)
        }
        
    }
    
}
