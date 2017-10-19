//
//  LoginViewController.swift
//  BobApp
//
//  Created by Joachim Zeelmaekers on 17/10/2017.
//  Copyright © 2017 Joachim Zeelmaekers. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    @IBOutlet weak var loginButton: FBSDKLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(FBSDKAccessToken.current() == nil) {
            
        } else {
            loginButton.delegate = self
            loginButton.readPermissions = ["public_profile", "email", "user_friends"]
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error:Error) {
        
        if(error != nil) {
            //process error
            print(error.localizedDescription)
            return
        }
        else if result.isCancelled {
            //handle cancellations
        }
        else {
            if let userToken = result.token
            {
                //Get user access token
                let token:FBSDKAccessToken = result.token
                
                print("Token = \(FBSDKAccessToken.current().tokenString)")
                print("User ID = \(FBSDKAccessToken.current().userID)")
                
                
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Logout")
    }
    
    func returnUserData()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.start(completionHandler: { (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error)")
            }
            else
            {
                print("fetched user: \(result)")
               
                //let userName : NSString = result.valueForKey("name") as! NSString
                //print("User Name is: \(userName)")
                //let userEmail : NSString = result.valueForKey("email") as! NSString
                //print("User Email is: \(userEmail)")
            }
        })
    }
    
}
