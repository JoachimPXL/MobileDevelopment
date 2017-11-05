//
//  AddPassengerViewController.swift
//  BobApp
//
//  Created by Joachim Zeelmaekers on 03/11/2017.
//  Copyright © 2017 Joachim Zeelmaekers. All rights reserved.
//

import UIKit

class AddPassengerViewController: UIViewController {
    @IBOutlet weak var last_name: UITextField!
    @IBOutlet weak var first_name: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var others: UITextField!
    
    var vehicleId : Int = -1
    
    override func viewDidLoad() {
        //When someone taps in the app while typing (not in keyboard), the keyboard gets cancelled
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func addPassengerButtonPressed(_ sender: Any) {
            let firstName = first_name.text!
            let lastName = last_name.text!
            let phoneNumber = self.phoneNumber.text!
            let others = self.others.text!
            PassengersDatabase.instance.addPassenger(vFirst_name: firstName, vLast_name: lastName, vOthers: others, vPhoneNumber: phoneNumber, vVehicleId: Int64(self.vehicleId))
        
    }
    
    //Keyboard management
    
    @objc
    func hideKeyboard() {
        view.endEditing(true)
    }
    
}
