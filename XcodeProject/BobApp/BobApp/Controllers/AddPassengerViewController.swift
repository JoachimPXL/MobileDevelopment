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
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func addPassengerButtonPressed(_ sender: Any) {
            let firstName = first_name.text!
            let lastName = last_name.text!
            let phoneNumber = self.phoneNumber.text!
            let others = self.others.text!
        
        if PassengersDatabase.instance.addPassenger(vFirst_name: firstName, vLast_name: lastName, vOthers: others, vPhoneNumber: phoneNumber, vVehicleId: Int64(self.vehicleId)) != -1{
            self.performSegue(withIdentifier: "AddedPassengerSegueToBobs", sender: nil)
            
        } else {
            let alertController = UIAlertController(title: "Foutmelding", message:
                "Er ging iets mis bij het toevoegen van een passagier.", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Annuleer", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @objc
    func hideKeyboard() {
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "AddedPassengerSegueToBobs") {
            if let navigationViewController = segue.destination as? UINavigationController {
                let _ = navigationViewController.topViewController as! VehicleTableViewController;
            }
        }
    }
    
}
