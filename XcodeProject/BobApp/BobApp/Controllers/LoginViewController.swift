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
import os.log

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    @IBOutlet weak var loginButton: FBSDKLoginButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func registerEvent(_ sender: UIButton) {
        //let newUser = User(email: emailTextField.text, password: passwordTextField.text)
        navigateToNextPage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //When someone taps in the app while typing (not in keyboard), the keyboard gets cancelled
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)

        if(FBSDKAccessToken.current() != nil) {
            os_log("Token is not nil")
            navigateToNextPage()
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
            if result.token != nil
            {
                //Get user access token
                let token:FBSDKAccessToken = result.token
                
                print("Token = \(FBSDKAccessToken.current().tokenString)")
                print("User ID = \(FBSDKAccessToken.current().userID)")
                navigateToNextPage()
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Logout")
    }
    
    func navigateToNextPage() {
        self.performSegue(withIdentifier: "loginWithFbIdentifier", sender: self)
    }
    
    @objc
    func hideKeyboard() {
        view.endEditing(true)
    }

    
}
