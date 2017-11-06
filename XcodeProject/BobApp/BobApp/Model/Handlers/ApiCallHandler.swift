//
//  ApiCallHandler.swift
//  BobApp
//
//  Created by Joachim Zeelmaekers on 06/11/2017.
//  Copyright © 2017 Joachim Zeelmaekers. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import CoreLocation

class ApiCallHandler {
    
    class func getEventsFromApi(radiusInMeters: Int, time: String, latitude: Double, longitude: Double, accessToken: String, completion: @escaping () -> ()) {
        
        let url = "http://0.0.0.0:3000/events?&lat=\(latitude)&lng=\(longitude)&distance=\(radiusInMeters)&sort=venue&accessToken=\(accessToken)"
        Alamofire.request(url).validate().responseJSON { response in
            var mappedEvents: [Event] = []
            if let jsonObj = response.result.value {
                let json = JSON(jsonObj)
                for (key, event) in json["events"] {
                    // get coordinates from event and your current to calculate distance.
                    let coordinate₀ = CLLocation(latitude: event["place"]["location"]["latitude"].double!, longitude: event["place"]["location"]["longitude"].double!)
                    let coordinate₁ = CLLocation(latitude: latitude, longitude: longitude)
                    // distance result in meters
                    let distanceInMeters = coordinate₀.distance(from: coordinate₁)
                    // properties from event only those who we need
                    let title = event["name"].string
                    let attending = event["stats"]["attending"].int
                    let startdate = event["startTime"].string
                    let enddate = event["endTime"].string
                    let organisator = event["venue"]["name"].string
                    let description = event["description"].string
                    let lat = event["place"]["location"]["latitude"].double
                    let long = event["place"]["location"]["longitude"].double
                    //TODO let image =
                    let id = event["id"].string
                    let link = "https://www.facebook.com/events/" + id!
                    var e : Event?
                    if(enddate != nil && startdate != nil && organisator != nil && description != nil && title != nil) {
                        e = Event(name: title!, attending: attending!, afstand: distanceInMeters, startdate: startdate!, enddate: enddate!, organisator: organisator!, description: description!, lat: lat!, long: long!, link: link)
                        print("created")
                    }
                    
                    if(e != nil) {
                        mappedEvents.append(e!)
                        print(mappedEvents.count)
                    }
                }
                //return mappedEvents
            }
            //return mappedEvents
            completion()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let _:CLLocationCoordinate2D = manager.location!.coordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
    
    enum MyError: Error{
        case ApiCallFailedError
    }
    
}
