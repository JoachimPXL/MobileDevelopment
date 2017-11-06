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
    var afstand: Double
        var link : String
        var attending : Int
        var description : String
        var startdate : String
        var enddate : String
        var organisator: String
        var lat : Double
        var long: Double
    //
    
    init(name: String, attending: Int, afstand:Double, startdate:String, enddate:String, organisator:String, description:String, lat:Double, long:Double,link:String) {
        self.name = name;
        self.attending = attending;
        self.afstand = afstand;
        self.startdate = startdate;
        self.enddate = enddate;
        self.organisator = organisator;
        self.description = description;
        self.long = long;
        self.lat = lat;
        self.link = link;
    }
    
    
}
