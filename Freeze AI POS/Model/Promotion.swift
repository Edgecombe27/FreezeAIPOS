//
//  Promotion.swift
//  Freeze AI POS
//
//  Created by Spencer Geoffrey Edgecombe on 2018-10-30.
//  Copyright © 2018 Spencer Geoffrey Edgecombe. All rights reserved.
//

import Foundation
import SwiftyJSON

class Promotion {
    let id : Int
    let title : String
    let discounts : [Int : Discount]
    private var error : JSON?
    init(_ data : JSON) {
        self.error = nil
        if let id : Int = data[Keys.Promotion.id].int { self.id = id }
        else {
            self.id = 0
            self.error = data[Keys.Promotion.id]
        }
        
        if let title : String = data[Keys.Promotion.title].string { self.title = title }
        else {
            self.title = ""
            self.error = data[Keys.Promotion.title]
        }
        
        if let discountData : [Int : [String : Float]] = data[Keys.Promotion.discounts].object as? [Int : [String : Float]] {
            var discounts : [Int : Discount] = [:]
            for (classID, discount) in discountData {
                if let type = discount[Keys.Promotion.type], let value = discount[Keys.Promotion.value] {
                    switch  type {
                    case Keys.Promotion.percentage:
                        discounts[classID] = Discount.percentage(value: value)
                        break;
                    case Keys.Promotion.amount:
                        discounts[classID] = Discount.amount(value: value)
                        break;
                    default:
                        break;
                    }
                }
            }
            self.discounts = discounts
        } else {
            self.discounts = [:]
            self.error = data[Keys.Promotion.discounts]
        }
    }
}
