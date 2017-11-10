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
import KeychainSwift

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    @IBOutlet weak var loginButton: FBSDKLoginButton!
    @IBOutlet weak var signInLabel: UILabel!
    private let keychain = KeychainSwift()
    var fbLoginSuccess = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        if(FBSDKAccessToken.current() != nil) {
            navigateToNextPage()
        } else {
            signInLabel.text = "Meld je aan met Facebook"
            loginButton.readPermissions = ["public_profile", "email", "user_friends"]
        }
        loginButton.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (FBSDKAccessToken.current() != nil && fbLoginSuccess == true)
        {
            navigateToNextPage()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "loginWithFbIdentifier") {
            if let navigationViewController = segue.destination as? UINavigationController {
                let pulsatorViewController = navigationViewController.topViewController as! PulsatorViewController;
                pulsatorViewController.keychain = self.keychain
            }
        }
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error:Error) {
        if result.isCancelled {
            let alertController = UIAlertController(title: "Foutmelding", message:
                "Je hebt je aanmelding via Facebook geannuleerd. Gelieve het opnieuw te proberen om gebruik te maken van de BobApp.", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Ga door", style: UIAlertActionStyle.destructive,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
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
                    signInLabel.text = "Meld je aan met Facebook"
                }
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        fbLoginSuccess = false
        self.keychain.delete("accessToken")
        self.keychain.delete("userId")
        self.keychain.clear()
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
        signInLabel.text = "Meld je aan met Facebook"
    }
    
    func navigateToNextPage() {
        self.performSegue(withIdentifier: "loginWithFbIdentifier", sender: nil)
    }
    
    @objc
    func hideKeyboard() {
        view.endEditing(true)
    }
}
