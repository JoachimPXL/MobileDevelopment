//
//  EventTableViewController.swift
//  BobApp
//
//  Created by Joachim Zeelmaekers on 28/10/2017.
//  Copyright © 2017 Joachim Zeelmaekers. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Alamofire
import PromiseKit
import SwiftyJSON
import CoreLocation

class EventTableViewController: UITableViewController {
    var mappedEvents: [Event] = []
    var longitude:Double! = 0
    var latitude:Double! = 0
    var radiusInMeters: Int! = 0
    var time:String! = ""
    var accessToken:String! = FBSDKAccessToken.current().tokenString
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getEventsFromApi()
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        if(mappedEvents.count == 1) {
            let alertController = UIAlertController(title: "Evenementen", message:
                "Er is \(mappedEvents.count) evenement gevonden.", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Ga door", style: UIAlertActionStyle.destructive,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "Evenementen", message:
                "Er zijn \(mappedEvents.count) evenementen gevonden.", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Ga door", style: UIAlertActionStyle.destructive,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mappedEvents.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ShowDetailOfEventSegue", sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "EventUITableCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? EventUITableViewCell  else {
            fatalError("The dequeued cell is not an instance of EventUITableCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let event = mappedEvents[indexPath.row]
        //VehiclesDatabase.instance.deleteVehicle(vid: 1)
        cell.eventNam.text = "\(event.name)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let favorite = UITableViewRowAction(style: .normal, title: "❤ \n Favoriet") { action, index in
            //toevoegen aan favorieten via NSFetchedResultController.
            tableView.reloadData()
        }
        return [favorite]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ShowDetailOfEventSegue") {
            if let navigationViewController = segue.destination as? UINavigationController {
                let vehicleViewController = navigationViewController.topViewController as! DetailViewController;
                //add event ID for vehicle details.
            }
        }
    }
    
    
    enum MyError: Error{
        case ApiCallFailedError
    }
    
    func getEventsFromApi() {
        //  let url = "http://0.0.0.0:3000/events?lat=\(latitude)lng=\(longitude)&distance=\(radiusInMeters)&sort=venue&accesToken=\(accessToken)"
        if let longitude = longitude, let latitude = latitude ,let radiusInMeters = radiusInMeters , let time = time , let accessToken = accessToken {
            var url = "http://0.0.0.0:3000/events?&lat=\(latitude)&lng=\(longitude)&distance=\(radiusInMeters)&sort=venue&accessToken=\(accessToken)"
            Alamofire.request(url).validate().responseJSON { response in
                debugPrint(response)
                if let jsonObj = response.result.value {
                    let json = JSON(jsonObj)
                    for (key, event) in json["events"] {
                        //                          get coordinates from event and your current to calculate distance.
                        let coordinate₀ = CLLocation(latitude: event["place"]["location"]["latitude"].double!, longitude: event["place"]["location"]["longitude"].double!)
                        let coordinate₁ = CLLocation(latitude: latitude, longitude: longitude)
                        //                          distance result in meters
                        let distanceInMeters = coordinate₀.distance(from: coordinate₁)
                        //                          properties from event only those who we need
                        let title = event["name"].string
                        let attending = event["stats"]["attending"].int
                        let startdate = event["startTime"].string
                        let enddate = event["endTime"].string
                        let orgianisator = event["vanue"]["name"].string
                        
                        let e = Event(name: title!, attending: attending!,afstand: distanceInMeters)
                        self.mappedEvents.append(e)
                    }
                }
            }
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let _:CLLocationCoordinate2D = manager.location!.coordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
}




