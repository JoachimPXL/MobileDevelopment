//
//  EventUITableViewCell.swift
//  BobApp
//
//  Created by Andres Belgy on 01/11/2017.
//  Copyright © 2017 Joachim Zeelmaekers. All rights reserved.
//

import UIKit

class EventUITableViewCell: UITableViewCell {
    @IBOutlet weak var eventNam: UILabel!
    @IBOutlet weak var organisator: UILabel!
    @IBOutlet weak var attenders: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
