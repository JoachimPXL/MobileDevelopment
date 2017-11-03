//
//  VehicleTableViewCell.swift
//  BobApp
//
//  Created by Joachim Zeelmaekers on 25/10/2017.
//  Copyright © 2017 Joachim Zeelmaekers. All rights reserved.
//

import UIKit

class VehicleTableViewCell: UITableViewCell {
    //MARK: Properties
    
    @IBOutlet weak var bobFullName: UILabel!
    @IBOutlet weak var meetupLocation: UILabel!
    @IBOutlet weak var departureTimeToEvent: UILabel!
    @IBOutlet weak var departureTimeAtEvent: UILabel!
    @IBOutlet weak var carDescription: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
