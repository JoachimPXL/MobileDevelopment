//
//  User.swift
//  BobApp
//
//  Created by Joachim Zeelmaekers on 19/10/2017.
//  Copyright © 2017 Joachim Zeelmaekers. All rights reserved.
//

import UIKit

class User {
    
    //Properties
    var email:String
    var vehicles:[Vehicle]
    
    init?(email: String) {
        guard !email.isEmpty else {
            return nil
        }
        self.email = email
        self.vehicles = []
        
    }
    
    func addVehicle(vehicle:Vehicle) {
        self.vehicles.append(vehicle)
    }
    
}

