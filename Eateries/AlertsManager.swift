//
//  AlertsManager.swift
//  Eateries
//
//  Created by Konstantin Kalivod on 5/14/19.
//  Copyright © 2019 Kostya Kalivod. All rights reserved.
//

import Foundation
import UIKit
class Alert{
    class func cartAlert() -> UIAlertController {
        
            let ac = UIAlertController(title: "Cart", message: "Sorry😢\n Your cart will appear soon, but for now you can make a call.", preferredStyle: .alert)
            //First alert controller action cancel
            let cancel = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            ac.addAction(cancel)
            
        return ac}
    
    }
    

