//
//  Classification.swift
//  Freeze AI POS
//
//  Created by Spencer Geoffrey Edgecombe on 2018-10-27.
//  Copyright © 2018 Spencer Geoffrey Edgecombe. All rights reserved.
//

import Foundation
import SwiftyJSON

class Classification {
    let id : Int
    let title : String
    let ingredients : [Int]
    let preparations : [Int]
    private var error : JSON?
    init(_ data : JSON) throws {
        error = nil
        if let id : Int = data[Keys.Classification.id].int { self.id = id }
        else {
            self.id = 0
            self.error = data[Keys.Classification.id]
        }
        
        if let title : String = data[Keys.Classification.title].string { self.title = title }
        else {
            self.title = ""
            self.error = data[Keys.Classification.title]
        }
        
        if let ingredients : [Int] = data[Keys.Classification.ingredients].arrayObject as? [Int] { self.ingredients = ingredients }
        else {
            self.ingredients = []
            self.error = data[Keys.Classification.ingredients]
        }
        
        if let preparations : [Int] = data[Keys.Classification.preparations].arrayObject as? [Int] { self.preparations = preparations }
        else {
            self.preparations = []
            self.error = data[Keys.Classification.preparations]
        }
        
        if self.error != nil {
            throw JSONFailure.readFailure(json: self.error!)
        }
    }
}
