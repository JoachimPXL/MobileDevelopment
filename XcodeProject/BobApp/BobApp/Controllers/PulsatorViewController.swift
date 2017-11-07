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
    var mappedEvents: [Event] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    }
    
    @IBAction func radiusValueChanged(_ sender: Any) {
        radiusSlider.setValue(Float(lroundf(radiusSlider.value)), animated: true)
        radiusTextField.text = "\(radiusSlider.value) KM"
    }

    @IBAction func scanRadius(_ sender: Any) {
        let longitude:Double! = getLongitude()
        let latitude:Double! = getLatitude()
        let radiusInMeters: Int! = Int(radiusSlider.value * 1000)
        let time:String! = afternoonOrEvening.titleForSegment(at: afternoonOrEvening.selectedSegmentIndex)
        let accessToken:String! = keychain.get("accessToken")!
        
        if(longitude != nil && latitude != nil && radiusInMeters != 0 && time != nil && accessToken != nil) {
        self.performSegue(withIdentifier: "ScanEventsSegue", sender: nil)
        } else {
            print("Alert")
        }
        
    }
    
    func getLongitude() -> Double! {
        let locValue = locationManager.location?.coordinate
        return locValue?.longitude
    }
    
    func getLatitude() -> Double! {
        let locValue = locationManager.location?.coordinate
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ScanEventsSegue") {
            
            if let navigationViewController = segue.destination as? UINavigationController{
                let eventTableViewController = navigationViewController.topViewController as! EventTableViewController;
                eventTableViewController.accessToken = keychain.get("accessToken")!
                eventTableViewController.latitude = getLatitude()
                eventTableViewController.longitude = getLongitude()
                eventTableViewController.radiusInMeters = Int(radiusSlider.value * 1000)
                eventTableViewController.time = afternoonOrEvening.titleForSegment(at: afternoonOrEvening.selectedSegmentIndex)
            }
        }
    }
    
}
