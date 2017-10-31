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

class PulsatorViewController: UIViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    var keychain = KeychainSwift()
    
    @IBOutlet weak var radiusTextField: UITextField!
    @IBOutlet weak var afternoonOrEvening: UISegmentedControl!
    @IBOutlet weak var radiusSlider: UISlider!
    
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
        let longitude = getLongitude()
        let latitude = getLatitude()
        let radiusInMeters = radiusSlider.value * 1000
        let time = afternoonOrEvening.titleForSegment(at: afternoonOrEvening.selectedSegmentIndex)
        let accessToken = keychain.get("accessToken")
        
        //TODO: API Call om evenementen op te halen en mee te sturen en dan naar volgende scherm. VOOR ANDRES
        if(longitude != nil && latitude != nil && radiusInMeters != 0 && time != nil && accessToken != nil) {
            let url = "http://0.0.0.0:3000/events?lat=\(latitude)lng=\(longitude)&distance=\(radiusInMeters)&sort=venue&accesToken=\(accessToken)"
           

            HTTPHandler.getJson(urlString: url, completionHandler: parseDataIntoEvents)
            let alertController = UIAlertController(title: "Events", message:
                "We located 0 events", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Checkout events", style: UIAlertActionStyle.destructive,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        } else {
            throw MyError.ApiCallFailedError
        }
        return MyError.ApiCallFailedError
    }
    
    func parseDataIntoEvents(data : Data?) -> Void{
        
        if let data = data {
           let object = JSONParser.parse(data: data)
            if let object = object {
                
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
    
    func getLongitude() -> Any! {
        let locValue = locationManager.location?.coordinate
        //print("locations = \(locValue?.latitude) \(locValue?.longitude)")
        return locValue?.longitude
    }
    
    func getLatitude() -> Any! {
        let locValue = locationManager.location?.coordinate
        //print("locations = \(locValue?.latitude) \(locValue?.longitude)")
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
