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
    var piece:Int?
    var volume:Double?
    var kilogram:Double?
    var image:UIImage
        
    init(name: String, cost: Double, piece: Int, image: UIImage) {
        self.name = name
        self.cost = cost
        self.piece = piece
        self.image = image
    }
    
    init(name: String, cost: Double, kilogram: Double, image: UIImage) {
        self.name = name
        self.cost = cost
        self.kilogram = kilogram
        self.image = image
    }
    
    init(name: String, cost: Double, volume: Double, image: UIImage) {
        self.name = name
        self.cost = cost
        self.volume = volume
        self.image = image
    }
}
