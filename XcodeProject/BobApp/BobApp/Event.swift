//
//  Event.swift
//  BobApp
//
//  Created by Andres Belgy on 23/10/2017.
//  Copyright © 2017 Joachim Zeelmaekers. All rights reserved.
//

import UIKit

class Event {
    
    //MARK: Properties
    
    var name: String
    var photo: UIImage?
    var attenders: Int
    
    
    init(name: String, photo: UIImage?, attenders: Int) {
        self.name = name
        self.photo = photo
        self.attenders = attenders
    }
}
