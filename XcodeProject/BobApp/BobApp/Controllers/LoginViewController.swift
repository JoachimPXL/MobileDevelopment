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
    var fbLoginSuccess = false
    
    //MARK: override methods.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //When someone taps in the app while typing (not in keyboard), the keyboard gets cancelled
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)

        if(FBSDKAccessToken.current() != nil) {
            os_log("Token is not nil")
        } else {
            loginButton.readPermissions = ["public_profile", "email", "user_friends"]
            loginButton.delegate = self
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (FBSDKAccessToken.current() != nil && fbLoginSuccess == true)
        {
            navigateToNextPage()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerEvent(_ sender: UIButton) {
        //let newUser = User(email: emailTextField.text, password: passwordTextField.text)
        navigateToNextPage()
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
                fbLoginSuccess = true
                if result.grantedPermissions.contains("email") {
                    print("Token = \(FBSDKAccessToken.current().tokenString)")
                    print("User ID = \(FBSDKAccessToken.current().userID)")
                } else {
                    //fbLoginSuccess = false
                }
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Logout")
    }
    
    func navigateToNextPage() {
        self.performSegue(withIdentifier: "loginWithFbIdentifier", sender: nil)
    }
    
    @objc
    func hideKeyboard() {
        view.endEditing(true)
    }
}
