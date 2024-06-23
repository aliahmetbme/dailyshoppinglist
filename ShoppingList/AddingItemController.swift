//
//  AddingItemController.swift
//  ShoppingList
//
//  Created by Ali ahmet Erdoğdu on 21.06.2024.
//

import UIKit
import CoreData

class AddingItemController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var navigation: UINavigationItem!
    @IBOutlet var amount: UITextField!
    @IBOutlet var cost: UITextField!
    @IBOutlet var productName: UITextField!
    @IBOutlet var optionpickerview: UIPickerView!
    @IBOutlet var productimage: UIImageView!
    
    var options: [productMeasureType] = [.piece,.kilogram,.liter]
    var measureOption = productMeasureType?(.piece)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        optionpickerview.delegate = self
        optionpickerview.dataSource = self
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigation.backButtonTitle = "Shopping List"
        navigation.backBarButtonItem?.title = "Shopping List"
        
        
        productimage.isUserInteractionEnabled = true
        let productimageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(takeImage))
        productimage.addGestureRecognizer(productimageGestureRecognizer)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)

    }
        
    @objc func takeImage (){

        let picker = UIImagePickerController()
        let alertController = UIAlertController(title: "Select Image Source", message: "", preferredStyle: .alert)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
            
            picker.delegate = self
            picker.sourceType = .camera
            picker.allowsEditing = true
            self.present(picker, animated: true, completion: nil)

        }
        
        let gallarylAction = UIAlertAction(title: "Gallary", style: .cancel) { _ in
            
            picker.delegate = self
            picker.sourceType = .photoLibrary
            picker.allowsEditing = true
            self.present(picker, animated: true, completion: nil)

        }

        alertController.addAction(cameraAction)
        alertController.addAction(gallarylAction)

        present(alertController, animated: true, completion: nil)
                
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        productimage.image = info[.editedImage] as? UIImage
        self.dismiss(animated: true)
    }
   
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
        @objc func keyboardWillShow(_ notification: Notification) {
            guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
            let keyboardHeight = keyboardFrame.height / (self.view.frame.size.height * 0.01)
                    
            UIView.animate(withDuration: 0.1) {
                self.view.transform = CGAffineTransform(translationX: 0, y: -keyboardHeight)
                self.navigationController?.navigationBar.isHidden = true
            }
        }

        @objc func keyboardWillHide(_ notification: Notification) {
            UIView.animate(withDuration: 0.1) {
                self.view.transform = .identity
                self.navigationController?.navigationBar.isHidden = false
            }
        }
        
        @objc func dismissKeyboard() {
            view.endEditing(true)
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            view.endEditing(true)
        }
    
    override func viewDidDisappear(_ animated: Bool) {
        view.endEditing(true)

    }
    
}

extension AddingItemController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    // UIPickerViewDataSource Metodları
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }
    
    // UIPickerViewDelegate Metodları
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch options[row] {
        case .kilogram:
            return "Kilogram"
        case .liter:
            return "Liter"
        case .piece:
            return "Piece"

        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        measureOption = options[row]
        print("measure option : \(String(describing: measureOption))")
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var title = ""
        switch options[row] {
        case .kilogram:
            title = "Kilogram"
        case .liter:
            title =  "Liter"
        case .piece:
            title =  "Piece"

        }
        let color = UIColor.black // Örneğin sıradaki satıra göre renk değişimi
            
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: color,
                .font: UIFont.systemFont(ofSize: 18) // Opsiyonel olarak font ayarı yapabilirsiniz
            ]
            
        return NSAttributedString(string: title, attributes: attributes)
    }
}


