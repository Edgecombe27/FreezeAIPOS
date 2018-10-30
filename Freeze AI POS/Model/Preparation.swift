//
//  Preparation.swift
//  Freeze AI POS
//
//  Created by Spencer Geoffrey Edgecombe on 2018-10-30.
//  Copyright © 2018 Spencer Geoffrey Edgecombe. All rights reserved.
//

import Foundation
import SwiftyJSON

class Preparation {
    let id : Int
    let title : String
    var error : JSON?
    
    init (_ data : JSON) throws {
        self.error = nil
        if let id : Int = data[Keys.Preparation.id].int { self.id = id }
        else {
            self.id = 0
            self.error = data[Keys.Preparation.id]
        }
        
        if let title : String = data[Keys.Preparation.title].string { self.title = title }
        else {
            self.title = ""
            self.error = data[Keys.Preparation.title]
        }
        
        if self.error != nil {
            throw JSONFailure.readFailure(json: self.error!)
        }
        
    }
    
}
