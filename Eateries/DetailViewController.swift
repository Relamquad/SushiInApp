//
//  DetailViewController.swift
//  Eateries
//
//  Created by Konstantin Kalivod on 5/14/19.
//  Copyright © 2019 Kostya Kalivod. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{

    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var addToCartButton: UIButton!
    
    var imageName = ""
    var titleName = ""
    var titleDescription = ""
    var titlePrice = ""
    var counts = ["1","2","3","4","5","6","7","8","9","10+"]
    
    var picker = UIPickerView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.dataSource = self
        textField.inputView = picker
        
        detailImage.image = UIImage(named: imageName)
        titleLabel.text = titleName
        descriptionLabel.text = titleDescription
        priceLabel.text = "Price: \(titlePrice)"
        
        addToCartButton.layer.cornerRadius = 5
        addToCartButton.clipsToBounds = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addToCartPress(_ sender: Any) {
        self.present(Alert.cartAlert(), animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return counts.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return counts[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField.text = counts[row]
        self.view.endEditing(false)
    }
    func makePhoneCall(phoneNumber: String) {
        
        if let phoneURL = NSURL(string: ("tel://" + phoneNumber)) {
            
            let alert = UIAlertController(title: ("Call " + phoneNumber + "?"), message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Call", style: .default, handler: { (action) in
                UIApplication.shared.open(phoneURL as! URL, options: [:], completionHandler: nil)
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
