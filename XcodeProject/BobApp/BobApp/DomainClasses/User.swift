//
//  User.swift
//  BobApp
//
//  Created by Joachim Zeelmaekers on 19/10/2017.
//  Copyright © 2017 Joachim Zeelmaekers. All rights reserved.
//

import UIKit

class User {
    
    //Properties
    var email:String
    var password:String
    
    init?(email: String, password: String) {
        
        guard !email.isEmpty else {
            return nil
        }
        
        guard !password.isEmpty else {
            return nil
        }
        
        self.email = email
        self.password = password
        
    }
    
}

