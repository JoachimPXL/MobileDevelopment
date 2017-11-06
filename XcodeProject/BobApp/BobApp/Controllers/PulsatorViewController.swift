//
//  PulsatorViewController.swift
//  BobApp
//
//  Created by Joachim Zeelmaekers on 09/10/2017.
//  Copyright © 2017 Joachim Zeelmaekers. All rights reserved.
//

import Foundation
import Pulsator
import CoreLocation
import KeychainSwift
import Alamofire
import SwiftyJSON
import PromiseKit

class PulsatorViewController: UIViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    var keychain = KeychainSwift()
    
    @IBOutlet weak var radiusTextField: UITextField!
    @IBOutlet weak var afternoonOrEvening: UISegmentedControl!
    @IBOutlet weak var radiusSlider: UISlider!
    var mappedEvents: [Event] = []
    
    @IBAction func radiusValueChanged(_ sender: Any) {
        radiusSlider.setValue(Float(lroundf(radiusSlider.value)), animated: true)
        radiusTextField.text = "\(radiusSlider.value) KM"
    }

    @IBAction func scanRadius(_ sender: Any) {
        
        
        
    }
    
    enum MyError: Error{
        case ApiCallFailedError
    }
    
    func  getEventsFromApi() throws -> MyError {
        print("test")
        let longitude:Double! = getLongitude()
        let latitude:Double! = getLatitude()
        let radiusInMeters: Int! = Int(radiusSlider.value * 1000)
        let time:String! = afternoonOrEvening.titleForSegment(at: afternoonOrEvening.selectedSegmentIndex)
        let accessToken:String! = keychain.get("accessToken")!
        
        if(longitude != nil && latitude != nil && radiusInMeters != 0 && time != nil && accessToken != nil) {
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
                            let organisator = event["vanue"]["name"].string
                            let description = event["description"].string
                            let lat = event["place"]["location"]["latitude"].double
                            let long = event["place"]["location"]["longitude"].double
                           //TODO let image =
                            let id = event["id"].string
                            let link = "https://www.facebook.com/events/\(id)";
                            let e = Event(name: title!, attending: attending!,afstand: distanceInMeters, startdate: startdate!, enddate: enddate!, organisator: organisator!, description: description!, lat: lat!, long: long!, link: link)
                            self.mappedEvents.append(e)
                        }
                        
                        print("array length: ")
                        print(self.mappedEvents.count)
                    }
                }
            }
            
        } else {
            throw MyError.ApiCallFailedError
        }
        return MyError.ApiCallFailedError
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ScanEventsSegue") {
            if let eventTableViewController = segue.destination as? EventTableViewController {
                print("tapped")
                self.mappedEvents.append(Event(name: "Testevent", attending: 90, afstand: 90.10))
                eventTableViewController.mappedEvents2 = mappedEvents
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //When someone taps in the app while typing (not in keyboard), the keyboard gets cancelled
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    override func viewDidAppear(_ animated:Bool) {
        super.viewDidAppear(false)
        let pulsator = Pulsator()
        pulsator.position = CGPoint(x: 175, y: 223)
        pulsator.numPulse = 2
        pulsator.radius = 240
        pulsator.backgroundColor = UIColor(red:1, green:0, blue: 0, alpha:1).cgColor
        pulsator.animationDuration = 3
        pulsator.pulseInterval = 1
        
        view.layer.addSublayer(pulsator)
        pulsator.start()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getLongitude() -> Double! {
        let locValue = locationManager.location?.coordinate
        //print("locations = \(locValue?.latitude) \(locValue?.longitude)")
        return locValue?.longitude
    }
    
    func getLatitude() -> Double! {
        let locValue = locationManager.location?.coordinate
        //        print("locations = \(locValue?.latitude) \(locValue?.longitude)")
        return locValue?.latitude
    }
    
    @objc
    func hideKeyboard() {
        view.endEditing(true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let _:CLLocationCoordinate2D = manager.location!.coordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
    
}
