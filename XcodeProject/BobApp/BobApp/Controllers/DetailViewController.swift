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
import SDWebImage

class DetailViewController: UIViewController  {
    var selectedEvent: Event?
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventDescription: UITextView!
    @IBOutlet weak var attenders: UILabel!
    @IBOutlet weak var organisator: UILabel!
    @IBOutlet weak var startEvent: UILabel!
    @IBOutlet weak var endEvent: UILabel!
    @IBOutlet weak var bannerEvent: UIImageView!
    
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
        let fbURLID: NSURL = NSURL(string: (selectedEvent?.link)!)!
        
        if(UIApplication.shared.canOpenURL(fbURLID as URL)){
            UIApplication.shared.open(fbURLID as URL, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func unwindToDetail(segue: UIStoryboardSegue) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //GoBackToEventsSegue
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        eventTitle.text = selectedEvent?.name
        attenders.text = "aanwezigen: \(selectedEvent?.attending ?? 0)"
        organisator.text = selectedEvent?.organisator
        startEvent.text = selectedEvent?.startdate
        endEvent.text = selectedEvent?.enddate
        eventDescription.text = selectedEvent?.eventDescription
        bannerEvent.sd_setImage(with: URL(string: (selectedEvent?.bannerPicture)!), placeholderImage: UIImage(named: ""))
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
