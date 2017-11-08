//
//  AddVehicleViewController.swift
//  BobApp
//
//  Created by Joachim Zeelmaekers on 29/10/2017.
//  Copyright © 2017 Joachim Zeelmaekers. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class AddVehicleViewController: UIViewController {
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var meetupLocationTextField: UITextField!
    @IBOutlet weak var departureToEventTextField: UITextField!
    @IBOutlet weak var departureAtEventTextfield: UITextField!
    @IBOutlet weak var descriptionCarTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var dateOfBirthPicker: UIDatePicker!
    @IBOutlet weak var capacity: UITextField!
    
    @IBAction func addVehicleButton(_ sender: Any) {
        
        if let id = VehiclesDatabase.instance.addVehicle (
            vfirst_name: firstnameTextField.text!,
            vlast_name: lastnameTextField.text!,
            vdateOfBirth: dateOfBirthPicker.date,
            vmeetupLocation: meetupLocationTextField.text!,
            vdepartureToEvent: departureToEventTextField.text!,
            vdepartureAtEvent: departureAtEventTextfield.text!,
            vdescription: descriptionCarTextField.text!,
            vphoneNumber: phoneNumberTextField.text!,
            vcapacity: Int(capacity.text!)!) {
            
            self.performSegue(withIdentifier: "AddedCarSegueToBobs", sender: nil)
        } else {
            let alertController = UIAlertController(title: "Something went wrong", message:
                "Probeer alles in te vullen en probeer het opnieuw.", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.destructive,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        //When someone taps in the app while typing (not in keyboard), the keyboard gets cancelled
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc
    func hideKeyboard() {
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "AddedCarSegueToBobs") {
            if let navigationViewController = segue.destination as? UINavigationController {
                let vehicleViewController = navigationViewController.topViewController as! VehicleTableViewController;
            }
        }
    }
    
}
