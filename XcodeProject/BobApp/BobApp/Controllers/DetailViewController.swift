//
//  DetailViewController.swift
//  BobApp
//
//  Created by Joachim Zeelmaekers on 24/10/2017.
//  Copyright © 2017 Joachim Zeelmaekers. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController  {
    
    @IBAction func openEventLinkViaFbApp(_ sender: Any) {
        //facebookapp openen indien deze geïnstalleerd is en anders browser naar event. //WERKT enkel in safari-browser, niet in APP.
        let fbURLWeb: NSURL = NSURL(string: "https://www.facebook.com/degroeneletters/")!
        let fbURLID: NSURL = NSURL(string: "fb://profile/1795876386")! //\(keychain.get("userId"))
        
        if(UIApplication.shared.canOpenURL(fbURLID as URL)){
            // FB installed
            UIApplication.shared.open(fbURLID as URL, options: [:], completionHandler: nil)
        } else {
            // FB is not installed, open in safari
            UIApplication.shared.open(fbURLWeb as URL, options: [:], completionHandler: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
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
