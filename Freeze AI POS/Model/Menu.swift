//
//  Menu.swift
//  Freeze AI POS
//
//  Created by Spencer Geoffrey Edgecombe on 2018-10-27.
//  Copyright © 2018 Spencer Geoffrey Edgecombe. All rights reserved.
//

import Foundation
import SwiftyJSON

class Menu {
    
    let ingredients : [Ingredient]
    let menuItems : [MenuItem]
    let preparations : [Preparation]
    let classifications : [Classification]
    var error : JSON?
    init (_ data : JSON) throws {
        self.error = nil
        
        var ingredients : [Ingredient] = []
        if let arrData : [JSON] = data[Keys.Menu.ingredients].array {
            for ingredientData in arrData {
                do {
                    try ingredients.append(Ingredient(ingredientData))
                } catch JSONFailure.readFailure(let json) {
                    throw JSONFailure.readFailure(json: json)
                }            }
        } else {
            self.error = data[Keys.Menu.ingredients]
        }
        self.ingredients = ingredients
        
        var preparations : [Preparation] = []
        if let arrData : [JSON] = data[Keys.Menu.preparations].array {
            for preparationData in arrData {
                do {
                    try preparations.append(Preparation(preparationData))
                } catch JSONFailure.readFailure(let json) {
                    throw JSONFailure.readFailure(json: json)
                }
            }
        } else {
            self.error = data[Keys.Menu.preparations]
        }
        self.preparations = preparations
        
        var classifications : [Classification] = []
        if let arrData : [JSON] = data[Keys.Menu.classifications].array {
            for classificationData in arrData {
                do {
                    try classifications.append(Classification(classificationData))
                } catch JSONFailure.readFailure(let json) {
                    throw JSONFailure.readFailure(json: json)
                }
            }
        } else {
            self.error = data[Keys.Menu.classifications]
        }
        self.classifications = classifications
        
        var menuItems : [MenuItem] = []
        if let arrData : [JSON] = data[Keys.Menu.menuItems].array {
            for menuItemData in arrData {
                do {
                    try menuItems.append(MenuItem(menuItemData))
                } catch JSONFailure.readFailure(let json) {
                    throw JSONFailure.readFailure(json: json)
                }
            }
        } else {
            self.error = data[Keys.Menu.menuItems]
        }
        self.menuItems = menuItems
        
    }
    
    func fetchIngredient(for id : Int) -> Ingredient?{
        if id >= 0 && id < ingredients.count {
            return ingredients[id]
        } else {
            return nil
        }
    }
    
    func fetchPreparation(for id : Int) -> Preparation?{
        if id >= 0 && id < preparations.count {
            return preparations[id]
        } else {
            return nil
        }
    }
    
    func fetchClassification(for id : Int) -> Classification?{
        if id >= 0 && id < classifications.count {
            return classifications[id]
        } else {
            return nil
        }
    }
    
    func fetchIngredients(from menuItem: MenuItem) -> [Ingredient] {
        var result : [Ingredient] = []
        let map : [Int : Int] = menuItem.getIngredients()
        for (key, value) in map {
            for _ in 1...value {
                if let ingredient = fetchIngredient(for: key) {
                    result.append(ingredient)
                }
            }
        }
        return result
    }
    
    func fetchPreparations(from menuItem: MenuItem) -> [Preparation] {
        var result : [Preparation] = []
        let map : [Int] = menuItem.getPreparattions()
        for id in map {
            if let preparation = fetchPreparation(for: id) {
                result.append(preparation)
            }
        }
        return result
    }

    func fetchClassifications(from menuItem: MenuItem) -> [Classification] {
        var result : [Classification] = []
        let map : [Int] = menuItem.classifications
        for id in map {
            if let classification = fetchClassification(for: id) {
                result.append(classification)
            }
        }
        return result
    }
    
    func fetchIngredients(from classification: Classification) -> [Ingredient] {
        var result : [Ingredient] = []
        let map : [Int] = classification.ingredients
        for id in map {
            if let ingredient = fetchIngredient(for: id) {
                result.append(ingredient)
            }
        }
        return result
    }
    
    func fetchPreparations(from classification: Classification) -> [Preparation] {
        var result : [Preparation] = []
        let map : [Int] = classification.preparations
        for id in map {
            if let preparation = fetchPreparation(for: id) {
                result.append(preparation)
            }
        }
        return result
    }

}
