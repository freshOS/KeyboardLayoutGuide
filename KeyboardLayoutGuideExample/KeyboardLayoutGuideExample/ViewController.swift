//
//  ViewController.swift
//  KeyboardLayoutGuideExample
//
//  Created by Sacha DSO on 14/11/2017.
//  Copyright © 2017 freshos. All rights reserved.
//

import UIKit
import KeyboardLayoutGuide

class ViewController: UIViewController {

    // Create a keyboard helper.
    let keyboard = Keyboard()
    
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize the layout guide in my view.
        keyboard.setUpLayoutGuide(inView: view)
        
        // Constrain your button to the keyboard top Anchor
        // the way you would do natively :)
        button.bottomAnchor.constraint(equalTo: keyboard.topAnchor, constant: -100).isActive = true
    }
}

