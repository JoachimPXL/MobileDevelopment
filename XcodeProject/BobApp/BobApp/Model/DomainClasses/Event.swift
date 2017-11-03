//
//  Event.swift
//  BobApp
//
//  Created by Joachim Zeelmaekers on 03/11/2017.
//  Copyright © 2017 Joachim Zeelmaekers. All rights reserved.
//

import Foundation


class Event {
    
    var name : String
    var attending: Int
    var afstand: Double
    //    var link : String
    //    var attending : Int
    //    var description : String
    //    var endDate : String
    //    var beginDate : String
    //    var long: String
    //    var alt : String
    //
    
    init(name: String, attending: Int, afstand:Double) {
        self.name = name;
        self.attending = attending;
        self.afstand = afstand;
    }
    
    
}
