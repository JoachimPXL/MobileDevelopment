//
//  Vehicle.swift
//  BobApp
//
//  Created by Joachim Zeelmaekers on 25/10/2017.
//  Copyright © 2017 Joachim Zeelmaekers. All rights reserved.
//

import UIKit

class Vehicle {
    //MARK: Properties
    var id: Int64
    var first_name: String
    var last_name: String
    var dateOfBirth: Date
    var meetupLocation: String
    var departureToEvent: String
    var departureAtEvent: String
    var description: String
    var phoneNumber: String
    var capacity: Int
    
    //MARK: Initialization
    
    init(id: Int64, first_name: String, last_name: String, dateOfBirth: Date, meetupLocation: String,
         departureToEvent: String, departureAtEvent: String, description: String, phoneNumber: String, capacity: Int) {
        self.id = id
        self.first_name = first_name
        self.last_name = last_name
        self.dateOfBirth = dateOfBirth
        self.meetupLocation = meetupLocation
        self.departureToEvent = departureToEvent
        self.departureAtEvent = departureAtEvent
        self.description = description
        self.phoneNumber = phoneNumber
        self.capacity = capacity
    }
    
}
