//
//  Passenger.swift
//  BobApp
//
//  Created by Joachim Zeelmaekers on 04/11/2017.
//  Copyright © 2017 Joachim Zeelmaekers. All rights reserved.
//

import Foundation

class Passenger {
    var id:Int64
    var first_name:String
    var last_name:String
    var phoneNumber:String
    var others:String
    var vehicleId:Int64
    
    init(id: Int64, first_name: String, last_name: String, phoneNumber: String, others: String, vehicleId:Int64) {
        self.id = id
        self.first_name = first_name
        self.last_name = last_name
        self.phoneNumber = phoneNumber
        self.others = others
        self.vehicleId = vehicleId
    }
}
