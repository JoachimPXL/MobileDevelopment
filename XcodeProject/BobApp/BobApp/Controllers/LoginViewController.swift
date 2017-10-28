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
import KeychainSwift

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    @IBOutlet weak var loginButton: FBSDKLoginButton!
    var fbLoginSuccess = false
    @IBOutlet weak var signInLabel: UILabel!
    private let keychain = KeychainSwift()
    
    //MARK: override methods.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //When someone taps in the app while typing (not in keyboard), the keyboard gets cancelled
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)

        if(FBSDKAccessToken.current() != nil) {
            signInLabel.text = ""
        } else {
            signInLabel.text = "Sign in to use the BobApp"
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
                    self.keychain.set(FBSDKAccessToken.current().tokenString, forKey: "accessToken")
                    self.keychain.set(FBSDKAccessToken.current().userID, forKey: "userId")
                    signInLabel.text = ""
                } else {
                    fbLoginSuccess = false
                    self.keychain.delete("accessToken")
                    self.keychain.delete("userId")
                    self.keychain.clear()
                    signInLabel.text = "Sign in to use the BobApp"
                }
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        fbLoginSuccess = false
        self.keychain.delete("accessToken")
        self.keychain.delete("userId")
        self.keychain.clear()
        signInLabel.text = "Sign in to use the BobApp"
       exit(1)
    }
    
    override func prepare(for segue: UIStoryboardSegue!, sender: Any?) {
        if (segue.identifier == "loginWithFbIdentifier") {
            if let navigationViewController = segue.destination as? UINavigationController {
                let pulsatorViewController = navigationViewController.topViewController as! PulsatorViewController;
                pulsatorViewController.keychain = self.keychain
                
            }
           
        }
    }
    func navigateToNextPage() {
        self.performSegue(withIdentifier: "loginWithFbIdentifier", sender: nil)
    }
    
    @objc
    func hideKeyboard() {
        view.endEditing(true)
    }
}
