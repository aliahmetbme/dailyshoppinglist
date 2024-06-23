//
//  Extensions.swift
//  ShoppingList
//
//  Created by Ali ahmet Erdoğdu on 22.06.2024.
//

import Foundation
import UIKit

extension UIButton {
    func makeButtonCircular () {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true

    }

}

extension UIImageView {
    func makeImageCurcular () {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.deactivate(self.constraints)
            
        // Yeni kısıtlamaları ekle
        let widthConstraint = self.widthAnchor.constraint(equalToConstant: 100)
        let heightConstraint = self.heightAnchor.constraint(equalToConstant: 150)
        NSLayoutConstraint.activate([widthConstraint, heightConstraint])
                
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }

    func addMarginImage() {
        
        // AutoLayout Kullanarak
        self.superview!.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 10, right: 30)
        self.contentMode = .scaleToFill
       
    }

}
