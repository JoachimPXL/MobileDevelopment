//
//  DetailViewController.swift
//  BobApp
//
//  Created by Joachim Zeelmaekers on 24/10/2017.
//  Copyright © 2017 Joachim Zeelmaekers. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class DetailViewController: UIViewController  {
    var selectedEvent: Event?
    
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventDescription: UITextView!
    @IBOutlet weak var attenders: UILabel!
    @IBOutlet weak var organisator: UILabel!
    @IBOutlet weak var startEvent: UILabel!
    @IBOutlet weak var endEvent: UILabel!
    
    @IBAction func openLocationOfEvent(_ sender: Any) {
    
            let regionDistance:CLLocationDistance = 10000
            let coordinates = CLLocationCoordinate2DMake((selectedEvent?.lat)!, (selectedEvent?.long)!)
            let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
            let options = [
                MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
                MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
            ]
            let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = "Start"
            mapItem.openInMaps(launchOptions: options)
        }
    
    @IBAction func openEventLinkViaFbApp(_ sender: Any) {
        //facebookapp openen indien deze geïnstalleerd is en anders browser naar event. //WERKT enkel in safari-browser, niet in APP.
        //        let fbURLWeb: NSURL = NSURL(string: "https://www.facebook.com/degroeneletters/")!
        print(selectedEvent?.link)
        let fbURLID: NSURL = NSURL(string: (selectedEvent?.link)!)!
        
        if(UIApplication.shared.canOpenURL(fbURLID as URL)){
            UIApplication.shared.open(fbURLID as URL, options: [:], completionHandler: nil)
        } else {
            // FB is not installed, open in safari
            //            UIApplication.shared.open(fbURLWeb as URL, options: [:], completionHandler: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        eventTitle.text = selectedEvent?.name
        attenders.text = "\(String(describing: selectedEvent?.attending))"
        organisator.text = selectedEvent?.organisator
        startEvent.text = selectedEvent?.startdate
        endEvent.text = selectedEvent?.enddate
        eventDescription.text = selectedEvent?.description
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc
    func hideKeyboard() {
        view.endEditing(true)
    }
}
