//
//  ProductViewCell.swift
//  ShoppingList
//
//  Created by Ali ahmet Erdoğdu on 22.06.2024.
//

import UIKit

class ProductViewCell: UITableViewCell {
        
    @IBOutlet var productImage: UIImageView!
    @IBOutlet var productName: UILabel!
    @IBOutlet var costandAmount: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
