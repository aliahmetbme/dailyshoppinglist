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
    @IBOutlet var cost: UILabel!
    @IBOutlet var amount: UILabel!
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Margin değerini belirleyin
        let margins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        contentView.frame = contentView.frame.inset(by: margins)

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //productImage.makeImageCurcular()
        
        // contentView çerçevesini yuvarlak yapın
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = UIColor.systemGray6
        
        // productImage'ı yuvarlak yapmak için
       productImage.makeImageCurcular()
        productImage.addMarginImage()

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
