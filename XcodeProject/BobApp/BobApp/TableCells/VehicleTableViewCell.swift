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
    @IBOutlet weak var vehicleNameLabel: UILabel!
    
    @IBAction func chooseBob(_ sender: Any) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //vehicleNameLabel.text = "Test"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
