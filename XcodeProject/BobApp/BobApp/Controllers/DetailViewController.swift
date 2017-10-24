//
//  DetailViewController.swift
//  BobApp
//
//  Created by Joachim Zeelmaekers on 24/10/2017.
//  Copyright © 2017 Joachim Zeelmaekers. All rights reserved.
//

import UIKit
//import FacebookLogin

class DetailViewController: UIViewController{
    
    @IBAction func openEventLinkViaFbApp(_ sender: Any) {
        //facebookapp openen indien deze geïnstalleerd is en anders browser naar event. //WERKT enkel in safari-browser, niet in APP.
        var fbURLWeb: NSURL = NSURL(string: "https://www.facebook.com/degroeneletters/")!
        var fbURLID: NSURL = NSURL(string: "fb://profile/1795876386")! //\(keychain.get("userId"))
        
        if(UIApplication.shared.canOpenURL(fbURLID as URL)){
            // FB installed
            UIApplication.shared.openURL(fbURLID as URL)
        } else {
            // FB is not installed, open in safari
            UIApplication.shared.openURL(fbURLWeb as URL)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
