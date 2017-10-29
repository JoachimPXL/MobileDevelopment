//
//  AddVehicleViewController.swift
//  BobApp
//
//  Created by Joachim Zeelmaekers on 29/10/2017.
//  Copyright © 2017 Joachim Zeelmaekers. All rights reserved.
//

import UIKit

class AddVehicleViewController: UIViewController {
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var dateOfBirthTextField: UITextField!
    @IBOutlet weak var meetupLocationTextField: UITextField!
    @IBOutlet weak var departureToEventTextField: UITextField!
    @IBOutlet weak var departureAtEventTextfield: UITextField!
    @IBOutlet weak var descriptionCarTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    
    @IBAction func addVehicleButton(_ sender: Any) {
        if let id = VehiclesDatabase.instance.addVehicle(vname: firstnameTextField.text!) {
            
        }
    }
}
