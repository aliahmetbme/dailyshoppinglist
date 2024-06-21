//
//  ViewController.swift
//  ShoppingList
//
//  Created by Ali ahmet Erdoğdu on 16.06.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var AddButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        AddButton.makeButtonCircular()

    }
}


/*
extension ViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
 */
extension UIButton {
    func makeButtonCircular () {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true

    }

}
