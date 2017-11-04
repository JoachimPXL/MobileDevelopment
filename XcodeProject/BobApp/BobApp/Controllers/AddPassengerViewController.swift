//
//  AddPassengerViewController.swift
//  BobApp
//
//  Created by Joachim Zeelmaekers on 03/11/2017.
//  Copyright © 2017 Joachim Zeelmaekers. All rights reserved.
//

import UIKit

class AddPassengerViewController: UIViewController {
    var vehicleId : Int = -1
    
    override func viewDidLoad() {
        //When someone taps in the app while typing (not in keyboard), the keyboard gets cancelled
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    //Keyboard management
    
    @objc
    func hideKeyboard() {
        view.endEditing(true)
    }
}
