//
//  Event.swift
//  BobApp
//
//  Created by Joachim Zeelmaekers on 03/11/2017.
//  Copyright © 2017 Joachim Zeelmaekers. All rights reserved.
//

import Foundation

class Event: NSObject, NSCoding {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.attending, forKey: "attending")
        aCoder.encode(self.afstand ,forKey: "afstand")
        aCoder.encode(self.startdate, forKey: "startdate")
        aCoder.encode(self.enddate, forKey: "enddate")
        aCoder.encode(self.organisator, forKey: "organisator")
        aCoder.encode(self.eventDescription, forKey: "eventDescription")
        aCoder.encode(self.lat, forKey: "latitude")
        aCoder.encode(self.long, forKey: "longitude")
        aCoder.encode(self.link, forKey: "link")
        aCoder.encode(self.profilePicture, forKey: "profilePicture")
        aCoder.encode(self.bannerPicture, forKey: "bannerPicture")
    }
    
    var name : String
    var afstand: Double
    var link : String
    var attending : Int
    var eventDescription : String
    var startdate : String
    var enddate : String
    var organisator: String
    var lat : Double
    var long: Double
    var profilePicture : String
    var bannerPicture : String
    
    init(name: String, attending: Int, afstand:Double, startdate:String, enddate:String, organisator:String, description:String, lat:Double, long:Double,link:String,
         profilePicture: String, bannerPicture: String) {
        self.name = name
        self.attending = attending
        self.afstand = afstand
        self.startdate = startdate
        self.enddate = enddate
        self.organisator = organisator
        self.eventDescription = description
        self.long = long
        self.lat = lat
        self.link = link
        self.profilePicture = profilePicture
        self.bannerPicture = bannerPicture
    }
    
    // MARK: NSCoding
    
    required init?(coder decoder: NSCoder) {
        name = decoder.decodeObject(forKey: "name") as! String
        attending = decoder.decodeInteger(forKey: "attending")
        afstand = decoder.decodeDouble(forKey: "afstand")
        startdate = decoder.decodeObject(forKey: "startdate") as! String
        enddate = decoder.decodeObject(forKey: "enddate") as! String
        organisator = decoder.decodeObject(forKey: "organisator") as! String
        eventDescription = decoder.decodeObject(forKey: "eventDescription") as! String
        lat = decoder.decodeDouble(forKey: "latitude")
        long = decoder.decodeDouble(forKey: "longitude")
        link = decoder.decodeObject(forKey: "link") as! String
        profilePicture = decoder.decodeObject(forKey: "profilePicture") as! String
        bannerPicture = decoder.decodeObject(forKey: "bannerPicture") as! String
        
    }
}
