//
//  EateriesTableViewController.swift
//  Eateries
//
//  Created by Konstantin Kalivod on 3/13/19.
//  Copyright © 2019 Kostya Kalivod. All rights reserved.
//

import UIKit

class EateriesTableViewController: UITableViewController {
  
    let phoneNumber = "+34651341565"
    var restaurantNames = ["BARCELONA BOAT SET","GAUDI DRAGON SET","SENBONSAKURA SET","Visit an amazing viewpoint of Tibidabo","Guided Tour inside of the Gothic Quarter","Your couple and you in the middle of the sea"]
    var restaurantImages = ["1","2","3","4","5","6"]
    var restaurantType = ["Sushi set","Sushi set","Sushi set","Trip+Sushi pack","Trip+Sushi pack","Trip+Sushi pack"]
    var restaurantIsVisited = [Bool](repeatElement(false, count: 6))
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return restaurantNames.count
    }

    // MARK: - Table view cellForRowAt
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IdCell", for: indexPath) as! EateriesTableViewCell
        cell.thumbnailImageView.image = UIImage(named: restaurantImages[indexPath.row])
        cell.thumbnailImageView.layer.cornerRadius = 32.5
        cell.thumbnailImageView.clipsToBounds = true
        cell.nameLabel.text = restaurantNames[indexPath.row]
        cell.typeLabel.text = restaurantType[indexPath.row]
        cell.accessoryType = self.restaurantIsVisited[indexPath.row] ? .checkmark : .none
        // Configure the cell...

        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //First alert controller
        let ac = UIAlertController(title: "Sushi-in", message: "You can buy it", preferredStyle: .actionSheet)
        //First alert controller action cancel
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        //First alert controller action call
        let call = UIAlertAction(title: "Call: +34 651 341 565", style: .default) {
            (action: UIAlertAction) -> Void in
            //Alert controller and action in Action call
            let phoneURL = NSURL(string: ("tel://" + self.phoneNumber))
            let ac = UIAlertController(title: ("Call " + self.phoneNumber + "?"), message: "Сall me if you want the best sushi in the world", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Call", style: .default, handler: { (action) in
                UIApplication.shared.open(phoneURL as! URL, options: [:], completionHandler: nil)
            }))
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(cancel)
            
            self.present(ac, animated: true, completion: nil)
            
        }
        //Checking isVisible restaurant with controller and action
        let isVisibleTitle = self.restaurantIsVisited[indexPath.row] ? "I was not here" : "I was here"
        let isVisited = UIAlertAction(title: isVisibleTitle, style: .default) { (action) in
            let cell = tableView.cellForRow(at: indexPath)
            self.restaurantIsVisited[indexPath.row] = !self.restaurantIsVisited[indexPath.row]
            //Setting checkmark
            cell?.accessoryType = self.restaurantIsVisited[indexPath.row] ? .checkmark : .none
        }
        //AddAction to First alert Controller and present
        ac.addAction(call)
        ac.addAction(isVisited)
        ac.addAction(cancel)
        present(ac, animated: true, completion: nil)
        //Hide selecting cell
        tableView.deselectRow(at: indexPath, animated: true)
    }

//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            self.restaurantNames.remove(at: indexPath.row)
//            self.restaurantImages.remove(at: indexPath.row)
//            self.restaurantIsVisited.remove(at: indexPath.row)
//
//
//        }
//       // self.tableView.reloadData()
//        tableView.deleteRows(at: [indexPath], with: .fade)
//    }
    
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let share = UITableViewRowAction(style: .default, title: "Share") { (action, indexPath) in
            let defaultText = "Now I'm in" + self.restaurantNames[indexPath.row]
            if let image = UIImage(named: self.restaurantImages[indexPath.row]){
                let activityController = UIActivityViewController(activityItems: [defaultText, image], applicationActivities: nil)
                self.present(activityController, animated: true, completion: nil)
            }
        }
        let delete = UITableViewRowAction(style: .default, title: "Buy") { (action, indexPath) in
            let ac = UIAlertController(title: "Cart", message: "Sorry😢\n Your cart will appear soon, but for now you can make a call.", preferredStyle: .alert)
            //First alert controller action cancel
            let cancel = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            ac.addAction(cancel)
            self.present(ac, animated: true, completion: nil)
        }
        share.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        return[delete, share]
    }
    
    func makePhoneCall(phoneNumber: String) {
        
        if let phoneURL = NSURL(string: ("tel://" + phoneNumber)) {
            
            let alert = UIAlertController(title: ("Call " + phoneNumber + "?"), message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Call", style: .default, handler: { (action) in
                UIApplication.shared.open(phoneURL as URL, options: [:], completionHandler: nil)
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
