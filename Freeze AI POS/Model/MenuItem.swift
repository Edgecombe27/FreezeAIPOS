//
//  MenuItem.swift
//  Freeze AI POS
//
//  Created by Spencer Geoffrey Edgecombe on 2018-10-26.
//  Copyright © 2018 Spencer Geoffrey Edgecombe. All rights reserved.
//

import Foundation
import SwiftyJSON

class MenuItem {
    
    let id : Int
    let title : String
    private var price : Float
    private var ingredients : [Int : Int]
    private var preparations : [Int]
    let classifications : [Int]
    private var error : JSON?
    init (_ data : JSON) throws {
        self.error = nil
        if let id : Int = data[Keys.MenuItem.id].int { self.id = id }
        else {
            self.id = 0
            self.error = data[Keys.MenuItem.id]
        }
        
        if let title : String = data[Keys.MenuItem.title].string { self.title = title }
        else {
            self.title = ""
            self.error = data[Keys.MenuItem.title]
        }
        
        if let price : Float = data[Keys.MenuItem.price].float { self.price = price }
        else {
            self.price = 0.0
            self.error = data[Keys.MenuItem.title]
        }
        
        if let ingredients : [Int : Int] = data[Keys.MenuItem.ingredients].object as? [Int : Int] { self.ingredients = ingredients }
        else {
            self.ingredients = [:]
            self.error = data[Keys.MenuItem.ingredients]
        }
        
        if let preparations : [Int] = data[Keys.MenuItem.preparations].arrayObject as? [Int] { self.preparations = preparations }
        else {
            self.preparations = []
            self.error = data[Keys.MenuItem.preparations]
        }
        
        if let classifications : [Int] = data[Keys.MenuItem.classifications].arrayObject as? [Int] { self.classifications = classifications }
        else {
            self.classifications = []
            self.error = data[Keys.MenuItem.classifications]
        }
        
        if self.error != nil {
            throw JSONFailure.readFailure(json: self.error!)
        }
        
    }
    
    func addIngredient(ingredient: Ingredient, quantity: Int) {
        assert(quantity > 0)
        let id = ingredient.id
        let cost = ingredient.price * Float(quantity)
        if let curr : Int = ingredients[id] {
            ingredients[id] = curr + quantity
        } else {
            ingredients[id] = quantity
        }
        self.price += cost
    }
    
    func setIngredient(ingredient: Ingredient, to quantity : Int) {
        let id = ingredient.id
        let cost = ingredient.price
        if let currentQuantity = ingredients[id] {
            self.price -= Float(currentQuantity) * cost
        }
        self.price += cost * Float(quantity)
        ingredients[id] = quantity
    }
    
    func removeIngredient(ingredient: Ingredient) {
        let id = ingredient.id
        let cost = ingredient.price
        if let currentQuantity = ingredients[id] {
            self.price -= Float(currentQuantity) * cost
        }
        ingredients[id] = 0
    }
    
    func removeIngredient(ingredient: Ingredient, quantity : Int) {
        let id = ingredient.id
        let cost = ingredient.price * Float(quantity)
        if let currentQuantity = ingredients[id] {
            if currentQuantity - quantity < 0 {
                removeIngredient(ingredient: ingredient)
            } else {
                self.price -= Float(currentQuantity) * cost
                ingredients[id] = currentQuantity - quantity
            }
        }
    }
    
    func getIngredients() -> [Int : Int] { return ingredients }
        
    func addPreparation(with id : Int) { preparations.append(id) }
    
    func removePreparation(at index : Int) { preparations.remove(at: index) }
    
    func getPreparattions() -> [Int] { return preparations }
    
    func getPrice() -> Float { return price }
    
    func applyDiscount(_ discount : Discount) {
        switch discount {
        case .percentage(let value):
            price = price * (1-value)
            break;
        case .amount(let value):
            price = price - value
        }
    }
    
}

