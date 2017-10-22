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

class PulsatorViewController: UIViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var radiusTextField: UITextField!
    @IBOutlet weak var afternoonOrEvening: UISegmentedControl!
    @IBOutlet weak var radiusSlider: UISlider!
    
    @IBAction func radiusValueChanged(_ sender: Any) {
       radiusSlider.setValue(Float(lroundf(radiusSlider.value)), animated: true)
        radiusTextField.text = "\(radiusSlider.value) KM"
    }
    
    @IBAction func scanRadius(_ sender: Any) {
        //get current location
        getLongitudeAndLatitude()
        let radiusInMeters = radiusSlider.value / 1000
        let time = afternoonOrEvening.titleForSegment(at: afternoonOrEvening.selectedSegmentIndex)
        //TODO: API Call om evenementen op te halen en mee te sturen en dan naar volgende scherm.
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //When someone taps in the app while typing (not in keyboard), the keyboard gets cancelled
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        //self.locationManager.requestAlwaysAuthorization()
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
            pulsator.position = CGPoint(x: 200, y: 200)
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
    
    func getLongitudeAndLatitude() {
        let locValue = locationManager.location?.coordinate
        
        print("locations = \(locValue?.latitude) \(locValue?.longitude)")
    }
    
    @objc
    func hideKeyboard() {
        view.endEditing(true)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
    
}
