//
//  EateriesTableViewCell.swift
//  Eateries
//
//  Created by Konstantin Kalivod on 3/24/19.
//  Copyright © 2019 Kostya Kalivod. All rights reserved.
//

import UIKit

class EateriesTableViewCell: UITableViewCell {
    // MARK: IBOutlets
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
