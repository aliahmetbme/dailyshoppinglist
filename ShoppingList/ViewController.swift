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
        overrideUserInterfaceStyle = .light
        getProducts()
        navigationController?.setNavigationBarHidden(true, animated: false)

        AddButton.makeButtonCircular()
        listTable.dataSource = self
        listTable.delegate = self

    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let cell = listTable.dequeueReusableCell(withIdentifier: "productCell") as! ProductViewCell

        // Margin değerini belirleyin
        let margins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        // contentView çerçevesini marginlere göre ayarlayın
        cell.frame = cell.frame.inset(by: margins)
    
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
      //  NotificationCenter.default.addObserver(self, selector: #selector(getProducts), name: NSNotification.Name(rawValue: "productRegistirated"), object: nil)
    getProducts()
        navigationController?.setNavigationBarHidden(true, animated: false)

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
               let productmeasuretype = response.value(forKey: "productmeasuretype") as? String
               let image = response.value(forKey:"image") as? Data
               let amount = response.value(forKey: "amount") as? Double
               let id = response.value(forKey: "id") as? UUID
                            
        
                switch productmeasuretype {
                    case "Kilogram":
                        let product = Item(name: name!, cost: cost!, amount: amount!, image: UIImage(data: image!)!, id: id!, measureType: .kilogram)
                        productsArray.append(product)
                    case "Piece":
                        let product = Item(name: name!, cost: cost!, amount: amount!, image: UIImage(data: image!)!, id: id!, measureType: .piece)
                        productsArray.append(product)
                    case "Liter":
                        let product = Item(name: name!, cost: cost!, amount: amount!, image: UIImage(data: image!)!, id: id!, measureType: .liter)
                        productsArray.append(product)
                    default:
                        break
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
        var unit = ""

        cell.cost.text = "\(products.cost) TL"
        
        switch products.measureType {
        case .kilogram:
            unit = " Kg"
        case .liter:
            unit = " Lt"
        case .piece:
            unit = " piece"
        }
        
        if let amount = products.amount {
            if (unit == " piece") {
                cell.amount.text = "\(Int(amount)) \(unit)"
            } else {
                cell.amount.text = "\((amount)) \(unit)"
            }
        }

        cell.productName.text = products.name
        
        cell.productImage.image = products.image
        
        let margins = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        
        // contentView çerçevesini marginlere göre ayarlayın
        cell.frame = cell.frame.inset(by: margins)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, layoutMarginsForRowAt indexPath: IndexPath) -> UIEdgeInsets {
        
           return UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
       }
    
    // Sağ çekme işlemi
        func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
                let appdelegate =  UIApplication.shared.delegate as! AppDelegate
                let context = appdelegate.persistentContainer.viewContext
                
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Shopping")
                let uuidString = self.productsArray[indexPath.row].id
                
                fetchRequest.predicate = NSPredicate(format: "id = %@", uuidString as CVarArg)
                fetchRequest.returnsObjectsAsFaults = false
                
                do {
                    //let responses = try context.fetch(fetchRequest)
                    let response = try context.fetch(fetchRequest)
                    if let item = response.first as? NSManagedObject {
                        context.delete(item)
                        self.productsArray.remove(at: indexPath.row)
                        self.listTable.reloadData()
                    }
                    try context.save()
                    
                 /*   for response in responses as! [NSManagedObject] {
                        if let id = response.value(forKey: "id") as? UUID {
                            if id == self.productsArray[indexPath.row].id {
                                context.delete(response)
                                self.productsArray.remove(at: indexPath.row)
                                self.listTable.reloadData()
                                try context.save()
                            }
                        }
                    }*/
                } catch {
                    print("Hata")
                }
            }
            deleteAction.backgroundColor = .red
            
            let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
            configuration.performsFirstActionWithFullSwipe = false
            return configuration
        }
    
    /*
        // Sola çekme işlemi
        func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let favoriteAction = UIContextualAction(style: .normal, title: "Favorite") { (action, view, completionHandler) in
                // Favori işlemi burada yapılır
                
            }
            favoriteAction.backgroundColor = .orange
            
            let configuration = UISwipeActionsConfiguration(actions: [favoriteAction])
            configuration.performsFirstActionWithFullSwipe = false
            return configuration
        }*/
}

