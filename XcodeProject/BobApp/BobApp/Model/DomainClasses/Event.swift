//
//  Event.swift
//  BobApp
//
//  Created by Joachim Zeelmaekers on 03/11/2017.
//  Copyright © 2017 Joachim Zeelmaekers. All rights reserved.
//

import Foundation

class Event: NSObject {
    
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
    
    required convenience init?(coder decoder: NSCoder) {
        guard let name = decoder.decodeObject(forKey: "name") as? String,
            let attending = decoder.decodeObject(forKey: "attending") as? Int,
            let afstand = decoder.decodeObject(forKey: "afstand") as? Double,
            let startDate = decoder.decodeObject(forKey: "startdate") as? String,
            let endDate = decoder.decodeObject(forKey: "enddate") as? String,
            let organisator = decoder.decodeObject(forKey: "organisator") as? String,
            let eventDescription = decoder.decodeObject(forKey: "eventDescription") as? String,
            let latitude = decoder.decodeObject(forKey: "latitude") as? Double,
            let longitude = decoder.decodeObject(forKey: "longitude") as? Double,
            let link = decoder.decodeObject(forKey: "link") as? String,
            let profilePicture = decoder.decodeObject(forKey: "profilePicture") as? String,
            let bannerPicture = decoder.decodeObject(forKey: "bannerPicture") as? String
            else { return nil }
        
        self.init(
            name: name,
            attending: attending,
            afstand: afstand,
            startdate: startDate,
            enddate: endDate,
            organisator: organisator,
            description: eventDescription,
            lat: latitude,
            long: longitude,
            link: link,
            profilePicture:profilePicture,
            bannerPicture: bannerPicture
        )
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encode(self.name, forKey: "name")
        coder.encode(Int(self.attending), forKey: "attending")
        coder.encode(Double(self.afstand) ,forKey: "afstand")
        coder.encode(self.startdate, forKey: "startdate")
        coder.encode(self.enddate, forKey: "enddate")
        coder.encode(self.organisator, forKey: "organisator")
        coder.encode(self.eventDescription, forKey: "eventDescription")
        coder.encode(self.lat, forKey: "latitude")
        coder.encode(self.long, forKey: "longitude")
        coder.encode(self.link, forKey: "link")
        coder.encode(self.profilePicture, forKey: "profilePicture")
        coder.encode(self.bannerPicture, forKey: "bannerPicture")
    }
}
