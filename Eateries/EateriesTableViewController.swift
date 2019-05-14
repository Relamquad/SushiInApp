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
    var restaurantDescription = ["40 pieces (recomended for 4 persons)\nAre you group of people and you don't decide what you want to try out?  We have a solution for you! \nOur incredible and unbeliveble boat of sushi that offers you 40 different sushi pieces.\nAre you ready for that?",
                                 "30 pieces \nMagnificent Sushi dish in form of Gaudi's mythical dragon.\nHave you seen something similar before? We don't think so!",
                                 "20 pieces\nBasic set of sushi with 5 diffent packs of traditional sushi:\n- 4 pieces of Makis with salmon\n- 4 pieces of Makis with aguacate\n- 4 pieces of Makis with crab\n- 4 pieces of Futomaki\n- 4 pieces of Nigiris with salmon",
                                 "Can you imagine a better plan than visiting the legendary viewpoint of Tibidabo and have a romantic sushi-dinner with you couple? ",
                                 "An incredible afternoon with a private guide who will show you the secrets of the Gothic Quarter with an incredible Sushi dinner",
                                 "Magnificent dinner with your couple in the meadle of the sea. Its your opportunity to impress him/her."]
    var restaurantPrice = ["59.95€","49.95€","34.95€","80€","70€","150€"]
    var restaurantIsVisited = [Bool](repeatElement(false, count: 6))
    override func viewDidLoad() {
        super.viewDidLoad()

 
    }
    

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


    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let share = UITableViewRowAction(style: .default, title: "Share") { (action, indexPath) in
            let defaultText = "Now I'm in" + self.restaurantNames[indexPath.row]
            if let image = UIImage(named: self.restaurantImages[indexPath.row]){
                let activityController = UIActivityViewController(activityItems: [defaultText, image], applicationActivities: nil)
                self.present(activityController, animated: true, completion: nil)
            }
        }
        let delete = UITableViewRowAction(style: .default, title: "Buy") { (action, indexPath) in
            
            self.present(Alert.cartAlert(), animated: true, completion: nil)
            
        }
        share.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        return[delete, share]
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            if let indexPath = tableView.indexPathForSelectedRow{
                let dvc = segue.destination as! DetailViewController
                dvc.imageName = self.restaurantImages[indexPath.row]
                dvc.titleName = self.restaurantNames[indexPath.row]
                dvc.titleDescription = self.restaurantDescription[indexPath.row]
                dvc.titlePrice = self.restaurantPrice[indexPath.row]
            }
            
        }
    }

}
