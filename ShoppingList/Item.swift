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
    var id:UUID
        
    init(name: String, cost: Double, piece: Int, image: UIImage, id:UUID) {
        self.name = name
        self.cost = cost
        self.piece = piece
        self.image = image
        self.id = id
    }
    
    init(name: String, cost: Double, kilogram: Double, image: UIImage, id:UUID) {
        self.name = name
        self.cost = cost
        self.kilogram = kilogram
        self.image = image
        self.id = id
    }
    
    init(name: String, cost: Double, volume: Double, image: UIImage, id:UUID) {
        self.name = name
        self.cost = cost
        self.volume = volume
        self.image = image
        self.id = id
    }
}
