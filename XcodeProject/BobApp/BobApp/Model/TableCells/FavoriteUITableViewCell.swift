//
//  FavoriteUITableViewCell.swift
//  BobApp
//
//  Created by Joachim Zeelmaekers on 06/11/2017.
//  Copyright © 2017 Joachim Zeelmaekers. All rights reserved.
//

import UIKit

class FavoriteUITableViewCell: UITableViewCell {
    @IBOutlet weak var eventNam: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}