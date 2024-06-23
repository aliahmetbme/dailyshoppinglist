# <!--@START_MENU_TOKEN@-->``Symbol``<!--@END_MENU_TOKEN@-->

<!--@START_MENU_TOKEN@-->Summary<!--@END_MENU_TOKEN@-->

## Overview

Elbette, işte Swift ile Core Data kullanımı hakkında temel konuları ve örnek kodları içeren bir Markdown dosyası:

---

# Swift ile Core Data Temelleri

Bu rehberde, Swift dilinde Core Data kullanarak temel veri işlemlerini nasıl yapacağınızı öğreneceksiniz. Core Data, iOS uygulamalarında veri yönetimi için güçlü bir araçtır.

## İçindekiler

1. [Proje Ayarları](#proje-ayarları)
2. [Core Data Model Oluşturma](#core-data-model-oluşturma)
3. [NSManagedObject Alt Sınıfı Oluşturma](#nsmanagedobject-alt-sınıfı-oluşturma)
4. [Veri Ekleme](#veri-ekleme)
5. [Veri Okuma](#veri-okuma)
6. [Veri Güncelleme](#veri-güncelleme)
7. [Veri Silme](#veri-silme)

## Proje Ayarları

Yeni bir Xcode projesi oluşturun ve "Use Core Data" seçeneğini işaretleyin.

![Use Core Data](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CoreDataUtilityTutorial/Art/core_data_check_box.png)

## Core Data Model Oluşturma

1. **Data Model Dosyası Ekleme**: Xcode projenizde `.xcdatamodeld` uzantılı bir dosya bulunmalıdır. Bu dosyayı açın.

2. **Varlık (Entity) Ekleme**: Sol alt köşedeki `Add Entity` butonuna tıklayarak yeni bir varlık ekleyin. Bu varlığa `Shopping` adını verin.

3. **Özellikler (Attributes) Ekleme**:
    - `name`: String
    - `amount`: Double
    - `cost`: Double
    - `id`: UUID
    - `image`: Binary Data
    - `productmeasuretype`: String

## NSManagedObject Alt Sınıfı Oluşturma

1. **NSManagedObject Alt Sınıfı Oluşturma**: Core Data model dosyanız seçiliyken `Editor > Create NSManagedObject Subclass...` menüsüne gidin ve `Shopping` varlığı için sınıflar oluşturun.

2. **Oluşturulan Dosyalar**: Xcode, `Shopping+CoreDataClass.swift` ve `Shopping+CoreDataProperties.swift` adında iki dosya oluşturacaktır.

### Shopping+CoreDataClass.swift

```swift
import Foundation
import CoreData

@objc(Shopping)
public class Shopping: NSManagedObject {

}
```

### Shopping+CoreDataProperties.swift

```swift
import Foundation
import CoreData

extension Shopping {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Shopping> {
        return NSFetchRequest<Shopping>(entityName: "Shopping")
    }

    @NSManaged public var amount: Double
    @NSManaged public var cost: Double
    @NSManaged public var id: UUID?
    @NSManaged public var image: Data?
    @NSManaged public var name: String?
    @NSManaged public var productmeasuretype: String?
}
```

## Veri Ekleme

```swift
let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

let newShoppingItem = Shopping(context: context)
newShoppingItem.name = "Elma"
newShoppingItem.amount = 1.5
newShoppingItem.cost = 3.0
newShoppingItem.id = UUID()
newShoppingItem.productmeasuretype = "Kilogram"
newShoppingItem.image = UIImage(named: "elma")?.jpegData(compressionQuality: 1.0)

do {
    try context.save()
    print("Veri kaydedildi")
} catch {
    print("Kaydetme hatası: \(error)")
}
```

## Veri Okuma

```swift
let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
let fetchRequest: NSFetchRequest<Shopping> = Shopping.fetchRequest()

do {
    let items = try context.fetch(fetchRequest)
    for item in items {
        print("Name: \(item.name ?? "No name")")
        print("Amount: \(item.amount)")
        print("Cost: \(item.cost)")
        print("Measure Type: \(item.productmeasuretype ?? "No measure type")")
    }
} catch {
    print("Fetch hatası: \(error)")
}
```

## Veri Güncelleme

```swift
let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
let fetchRequest: NSFetchRequest<Shopping> = Shopping.fetchRequest()

do {
    let items = try context.fetch(fetchRequest)
    if let firstItem = items.first {
        firstItem.name = "Updated Name"
        try context.save()
        print("Veri güncellendi")
    }
} catch {
    print("Güncelleme hatası: \(error)")
}
```

## Veri Silme

```swift
let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
let fetchRequest: NSFetchRequest<Shopping> = Shopping.fetchRequest()

do {
    let items = try context.fetch(fetchRequest)
    if let firstItem = items.first {
        context.delete(firstItem)
        try context.save()
        print("Veri silindi")
    }
} catch {
    print("Silme hatası: \(error)")
}
```

---

Bu rehber, Swift ile Core Data kullanarak temel veri işlemlerini nasıl gerçekleştireceğinizi gösterir. Daha karmaşık senaryolar için, ilişkiler (relationships), sorgular (queries) ve performans optimizasyonları gibi ileri seviye konuları incelemeniz önerilir.

## Topics

### Veri Kaydetme
```swift

    @IBAction func saveItem(_ sender: Any) {
        do {
            
            let appdelegate =  UIApplication.shared.delegate as! AppDelegate
            let context = appdelegate.persistentContainer.viewContext
            
            let shopping = NSEntityDescription.insertNewObject(forEntityName: "Shopping", into: context)
            
            shopping.setValue(productName.text!, forKey: "name")
            
            if let cost = Double(self.cost.text!) {
                shopping.setValue(cost, forKey: "cost")
            }
            
            if let amount = Double(self.amount.text!) {
                shopping.setValue(amount, forKey: "amount")
            }
            
            // universal uniqe id
            shopping.setValue(UUID(), forKey: "id")
            
            // resmi binary dataya çevirdi
            let data = productimage.image?.jpegData(compressionQuality: 0.5)
            // resim data olarak kaydedilir
            
            shopping.setValue(data, forKey: "image")
            
            switch measureOption {
            case .piece:
                shopping.setValue("Piece", forKey: "productmeasuretype")
            case .kilogram:
                shopping.setValue("Kilogram", forKey: "productmeasuretype")
            case .liter:
                shopping.setValue("Liter", forKey: "productmeasuretype")
            default:
                break
            }
            try context.save()
            
            NotificationCenter.default.post(name: NSNotification.Name("productRegistirated"), object: nil)
            self.navigationController?.popViewController(animated: true)
            
        } catch {
            print("hata var")
        }
        
    }
```
### Veri çekme

```swift
    
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


```
### Filtering 

```swift
import UIKit

if let uuidString = secilenUrunUUID?.uuidString {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Shopping")
    
    // belli bir id'e sahip olanları çekiyor burda
    fetchRequest.predicate = NSPredicte(format: "id = %@", uuidString)
    fetchRequest.returnsObjectsAsFaults = false
    
    do {
        let responses = try context.fetch(fetchRequest)
        
        if responses.count > 0 {
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
        } catch {
            print("error")
        }   
    
    }

}
```
### Veri Silme

```swift
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
    
