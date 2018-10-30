//
//  Keys.swift
//  Freeze AI POS
//
//  Created by Spencer Geoffrey Edgecombe on 2018-10-26.
//  Copyright © 2018 Spencer Geoffrey Edgecombe. All rights reserved.
//

import Foundation

class Keys {
    
    class MenuItem {
        static let id : String = "id"
        static let title : String = "title"
        static let price : String = "price"
        static let ingredients : String = "ingredients"
        static let preparations : String = "preparations"
        static let classifications : String = "classifications"
    }
    
    class Classification {
        static let id : String = "id"
        static let title : String = "title"
        static let ingredients : String = "ingredients"
        static let preparations : String = "preparations"
    }
    
    class Ingredient {
        static let id : String = "id"
        static let title : String = "title"
        static let price : String = "price"
    }
    
    class Preparation {
        static let id : String = "id"
        static let title : String = "title"
    }
    
    class Menu {
        static let ingredients : String = "ingredients"
        static let preparations : String = "preparations"
        static let classifications : String = "classifications"
        static let menuItems : String = "menu_items"
    }
    
    class Promotion {
        static let id : String = "id"
        static let title : String = "title"
        static let discounts : String = "discounts"
        static let value : String = "value"
        static let type : String = "type"
        static let percentage : Float = 0
        static let amount : Float = 1
    }
    
}
