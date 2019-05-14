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
    var SushiNames = ["BARCELONA BOAT SET","GAUDI DRAGON SET","SENBONSAKURA SET"]
    var SushiImages = ["1","2","3"]
    var SushiType = ["Sushi set","Sushi set","Sushi set"]
    var SushiDescription = ["40 pieces (recomended for 4 persons)\nAre you group of people and you don't decide what you want to try out?  We have a solution for you! \nOur incredible and unbeliveble boat of sushi that offers you 40 different sushi pieces.\nAre you ready for that?",
                                 "30 pieces \nMagnificent Sushi dish in form of Gaudi's mythical dragon.\nHave you seen something similar before? We don't think so!",
                                 "20 pieces\nBasic set of sushi with 5 diffent packs of traditional sushi:\n- 4 pieces of Makis with salmon\n- 4 pieces of Makis with aguacate\n- 4 pieces of Makis with crab\n- 4 pieces of Futomaki\n- 4 pieces of Nigiris with salmon"]
    var SushiPrice = ["59.95€","49.95€","34.95€"]
    
    var PacksNames = ["Visit an amazing viewpoint of Tibidabo","Guided Tour inside of the Gothic Quarter","Your couple and you in the middle of the sea"]
    var PacksImages = ["4","5","6"]
    var PacksType = ["Trip+Sushi pack","Trip+Sushi pack","Trip+Sushi pack"]
    var PacksDescription = ["Can you imagine a better plan than visiting the legendary viewpoint of Tibidabo and have a romantic sushi-dinner with you couple? ",
                            "An incredible afternoon with a private guide who will show you the secrets of the Gothic Quarter with an incredible Sushi dinner",
                            "Magnificent dinner with your couple in the meadle of the sea. Its your opportunity to impress him/her."]
    var PacksPrice = ["80€","70€","150€"]
    
    
    
    var SushiIsVisited = [Bool](repeatElement(false, count: 3))
    var PacksIsVisited = [Bool](repeatElement(false, count: 3))
    override func viewDidLoad() {
        super.viewDidLoad()

 
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0{
            return SushiNames.count
        }
        return PacksNames.count
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "SUSHI SETS"
        }
        return "Trip+Sushi pack"
    }
    // MARK: - Table view cellForRowAt
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IdCell", for: indexPath) as! EateriesTableViewCell
        if indexPath.section == 0{
        cell.thumbnailImageView.image = UIImage(named: SushiImages[indexPath.row])
        cell.thumbnailImageView.layer.cornerRadius = 32.5
        cell.thumbnailImageView.clipsToBounds = true
        cell.nameLabel.text = SushiNames[indexPath.row]
        cell.typeLabel.text = SushiType[indexPath.row]
        cell.accessoryType = self.SushiIsVisited[indexPath.row] ? .checkmark : .none
        // Configure the cell...
            return cell
            
        }
        cell.thumbnailImageView.image = UIImage(named: PacksImages[indexPath.row])
        cell.thumbnailImageView.layer.cornerRadius = 32.5
        cell.thumbnailImageView.clipsToBounds = true
        cell.nameLabel.text = PacksNames[indexPath.row]
        cell.typeLabel.text = PacksType[indexPath.row]
        cell.accessoryType = self.PacksIsVisited[indexPath.row] ? .checkmark : .none
        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Hide selecting cell
        tableView.deselectRow(at: indexPath, animated: true)
    }


    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let share = UITableViewRowAction(style: .default, title: "Share") { (action, indexPath) in
            if indexPath.section == 0{
            let defaultText = "Now I'm eating " + self.SushiNames[indexPath.row]
            if let image = UIImage(named: self.SushiImages[indexPath.row]){
                let activityController = UIActivityViewController(activityItems: [defaultText, image], applicationActivities: nil)
                self.present(activityController, animated: true, completion: nil)
                }
            }
            if indexPath.section == 1{
                let defaultText = "Now I'm in " + self.PacksNames[indexPath.row]
                if let image = UIImage(named: self.PacksImages[indexPath.row]){
                    let activityController = UIActivityViewController(activityItems: [defaultText, image], applicationActivities: nil)
                    self.present(activityController, animated: true, completion: nil)
                }
            }
        }
        let buy = UITableViewRowAction(style: .default, title: "Buy") { (action, indexPath) in
            
            self.present(Alert.cartAlert(), animated: true, completion: nil)
            
        }
        share.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        
        let more = UITableViewRowAction(style: .default, title: "More") { (action, indexPath) in
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
            if indexPath.section == 0{
                let isVisibleTitle = self.SushiIsVisited[indexPath.row] ? "I didn't take it" : "I took it"
                let isVisited = UIAlertAction(title: isVisibleTitle, style: .default) { (action) in
                    let cell = tableView.cellForRow(at: indexPath)
                    self.SushiIsVisited[indexPath.row] = !self.SushiIsVisited[indexPath.row]
                    //Setting checkmark
                    cell?.accessoryType = self.SushiIsVisited[indexPath.row] ? .checkmark : .none
                }
                ac.addAction(isVisited)
            }
            if indexPath.section == 1{
                let isVisibleTitle = self.PacksIsVisited[indexPath.row] ? "I was not here" : "I was here"
                let isVisited = UIAlertAction(title: isVisibleTitle, style: .default) { (action) in
                    let cell = tableView.cellForRow(at: indexPath)
                    self.PacksIsVisited[indexPath.row] = !self.PacksIsVisited[indexPath.row]
                    //Setting checkmark
                    cell?.accessoryType = self.PacksIsVisited[indexPath.row] ? .checkmark : .none
                }
                ac.addAction(isVisited)
                
            }
            //AddAction to First alert Controller and present
            ac.addAction(call)
            ac.addAction(cancel)
            self.present(ac, animated: true, completion: nil)
            
        }
        more.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        return[buy, share, more]
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            if let indexPath = tableView.indexPathForSelectedRow{
                let dvc = segue.destination as! DetailViewController
                if indexPath.section == 0 {
                dvc.imageName = self.SushiImages[indexPath.row]
                dvc.titleName = self.SushiNames[indexPath.row]
                dvc.titleDescription = self.SushiDescription[indexPath.row]
                dvc.titlePrice = self.SushiPrice[indexPath.row]
                }
                if indexPath.section == 1 {
                dvc.imageName = self.PacksImages[indexPath.row]
                dvc.titleName = self.PacksNames[indexPath.row]
                dvc.titleDescription = self.PacksDescription[indexPath.row]
                dvc.titlePrice = self.PacksPrice[indexPath.row]
                }
            }
            
        }
    }

}
