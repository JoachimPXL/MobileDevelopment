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


class PulsatorViewController: UIViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    var keychain = KeychainSwift()
    
    @IBOutlet weak var radiusTextField: UITextField!
    @IBOutlet weak var afternoonOrEvening: UISegmentedControl!
    @IBOutlet weak var radiusSlider: UISlider!
    var searchResults: [Event] = []
    
    @IBAction func radiusValueChanged(_ sender: Any) {
       radiusSlider.setValue(Float(lroundf(radiusSlider.value)), animated: true)
        radiusTextField.text = "\(radiusSlider.value) KM"
    }
    
    @IBAction func scanRadius(_ sender: Any) {
//            print(getLongitude())
//            print(getLatitude())
//            print(afternoonOrEvening.titleForSegment(at: afternoonOrEvening.selectedSegmentIndex))
//            print(radiusSlider.value * 1000)
//            print(keychain.get("accessToken"))
        
        do {
            try getEventsFromApi()
        } catch {
            let alertController = UIAlertController(title: "Something went wrong", message:
                "Please try again and make sure you fill in everything that is asked. Also make sure your location settings are configured the right way.", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    enum MyError: Error{
        case ApiCallFailedError
    }
    
    func getEventsFromApi() throws -> MyError {
        print("test")
        let longitude:Double! = getLongitude()
        let latitude:Double! = getLatitude()
        let radiusInMeters: Int! = Int(radiusSlider.value * 1000)
        let time:String! = afternoonOrEvening.titleForSegment(at: afternoonOrEvening.selectedSegmentIndex)
        let accessToken:String! = keychain.get("accessToken")!
        var mappedEvents: [Event] = []
        //TODO: API Call om evenementen op te halen en mee te sturen en dan naar volgende scherm. VOOR ANDRES
        if(longitude != nil && latitude != nil && radiusInMeters != 0 && time != nil && accessToken != nil) {
         //  let url = "http://0.0.0.0:3000/events?lat=\(latitude)lng=\(longitude)&distance=\(radiusInMeters)&sort=venue&accesToken=\(accessToken)"
            if let longitude = longitude, let latitude = latitude ,let radiusInMeters = radiusInMeters , let time = time , let accessToken = accessToken {
                var url = "http://0.0.0.0:3000/events?&lat=\(latitude)&lng=\(longitude)&distance=\(radiusInMeters)&sort=venue&accessToken=\(accessToken)"
                Alamofire.request(url).validate().responseJSON { response in
                    debugPrint(response)
                    if let jsonObj = response.result.value {
                        //print("JSON: \(jsonObj)")
                        let json = JSON(jsonObj)
                        for (key, event) in json["events"] {
                    
//                            get coordinates from event and your current to calculate distance.
                            let coordinate₀ = CLLocation(latitude: event["place"]["location"]["latitude"].double!, longitude: event["place"]["location"]["longitude"].double!)
                            let coordinate₁ = CLLocation(latitude: latitude, longitude: longitude)
//                            distance result in meters
                            let distanceInMeters = coordinate₀.distance(from: coordinate₁)
//                            properties from event only those who we need
                            let title = event["name"].string
                            let attending = event["stats"]["attending"].int
                            let startdate = event["startTime"].string
                            let enddate = event["endTime"].string
                            let orgianisator = event["vanue"]["name"].string
                            
                            let e = Event(name: title!, attending: attending!,afstand: distanceInMeters)
                            mappedEvents.append(e)
                        }
                    }
                }
            }
            
            
//       var url = "http://0.0.0.0:3000/events?lat=40.710803&lng=-73.964040&distance=100&sort=venue&accessToken=EAACEdEose0cBACIoZAaIdE4y57pF4Ym8U8RF4nIEMYC2UAnZANiek6DWGZCkqWFZCdnEMDCdF9hPraT6D7UvNZBPkeS9ur5qcHPPWkqGO5trVMqg6tR7ZAmG7ZAeOYIVyEE6XoiGK1viDTwhosZB4uozULThBqZA4Ghgu1tUBv4TEESG5HJG4KF2ZA8O5h7mo3alLD2XCQrtQqXAZDZD’"*/
           
            
//            HTTPHandler.getJson(urlString: url, completionHandler: parseDataIntoEvents)
            
            let alertController = UIAlertController(title: "Events", message:
                "We located 0 events", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Checkout events", style: UIAlertActionStyle.destructive,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        } else {
            throw MyError.ApiCallFailedError
        }
        return MyError.ApiCallFailedError
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
