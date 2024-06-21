//
//  ViewController.swift
//  ShoppingList
//
//  Created by Ali ahmet Erdoğdu on 16.06.2024.
//

import UIKit
import CoreData


class ViewController: UIViewController {

    @IBOutlet var listTable: UITableView!
    @IBOutlet var AddButton: UIButton!
    var productsArray: [Item] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        getProducts()
        AddButton.makeButtonCircular()
        
        listTable.dataSource = self
        listTable.delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
      //  NotificationCenter.default.addObserver(self, selector: #selector(getProducts), name: NSNotification.Name(rawValue: "productRegistirated"), object: nil)
    getProducts()
    }
    
    @IBAction func addProducts(_ sender: Any) {
       performSegue(withIdentifier: "toAddVc", sender: nil)
    }
    
    
    @objc func getProducts () {
        productsArray.removeAll(keepingCapacity: false)
        let appdelagete = UIApplication.shared.delegate as! AppDelegate
        let context = appdelagete.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Shopping")
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let responses =  try context.fetch(fetchRequest)
            for response in responses as! [NSManagedObject] {
               let name  = response.value(forKey: "name") as? String
               let cost = response.value(forKey: "cost") as? Double
               let productmeasuretype = response.value(forKey: "productmeasuretype") as? productMeasureType
               let image = response.value(forKey:"image") as? Data
               let amount = response.value(forKey: "amount") as? Double
               let id = response.value(forKey: "id") as? UUID
            
                switch productmeasuretype {
                case .kilogram:
                    let product = Item(name: name!, cost: cost!, kilogram: amount!, image: UIImage(data: image!)!, id: id!)
                    productsArray.append(product)
                case .piece:
                    let product = Item(name: name!, cost: cost!, piece: Int(amount ?? 0), image: UIImage(data: image!)!, id: id!)
                    productsArray.append(product)
                case .liter:
                    let product = Item(name: name!, cost: cost!, kilogram: amount!, image: UIImage(data: image!)!, id: id!)
                    productsArray.append(product)
                case .none:
                    let product = Item(name: name!, cost: cost!, kilogram: amount!, image: UIImage(data: image!)!, id: id!)
                    productsArray.append(product)
                }
            }
            
            listTable.reloadData()
        } catch {
            print ("Error")
        }
    }
}


extension ViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        productsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let products = productsArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! ProductViewCell
        
        cell.productName.text = products.name
        cell.costandAmount.text = "\(products.cost)"
        cell.productImage.image = products.image
        return cell
    }
}

extension UIButton {
    func makeButtonCircular () {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true

    }

}
