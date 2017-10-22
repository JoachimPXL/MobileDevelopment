//
//  PulsatorViewController.swift
//  BobApp
//
//  Created by Joachim Zeelmaekers on 09/10/2017.
//  Copyright © 2017 Joachim Zeelmaekers. All rights reserved.
//

import Foundation
import Pulsator

class PulsatorViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startPulsator()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startPulsator() {
        let pulsator = Pulsator()
        pulsator.position = CGPoint(x: 200, y: 200)
        pulsator.numPulse = 3
        pulsator.radius = 240
        pulsator.backgroundColor = UIColor(red:1, green:0, blue: 0, alpha:1).cgColor
        pulsator.animationDuration = 3
        pulsator.pulseInterval = 2
        
        view.layer.addSublayer(pulsator)
        pulsator.start()
    }
}
