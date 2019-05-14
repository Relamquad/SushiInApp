//
//  DetailViewController.swift
//  Eateries
//
//  Created by Konstantin Kalivod on 5/14/19.
//  Copyright © 2019 Kostya Kalivod. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailImage.image = UIImage(named: imageName)
        titleLabel.text = titleName
        descriptionLabel.text = titleDescription
        priceLabel.text = "Price: \(titlePrice)"
        
        addToCartButton.layer.cornerRadius = 5
        addToCartButton.clipsToBounds = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addToCartPress(_ sender: Any) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
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
