//
//  Item.swift
//  ShoppingList
//
//  Created by Ali ahmet Erdoğdu on 21.06.2024.
//

import Foundation
import UIKit

class Item {

    var name:String
    var cost:Double
    var amount:Double?
    var image:UIImage
    var id:UUID
    var measureType:productMeasureType
        
    
    init(name: String, cost: Double, amount:Double, image: UIImage, id:UUID , measureType:productMeasureType) {
        self.name = name
        self.cost = cost
        self.amount = amount
        self.image = image
        self.id = id
        self.measureType = measureType
    }
    
}
