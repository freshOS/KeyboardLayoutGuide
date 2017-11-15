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
    
    // Create a keyboard layout guide.
    let keyboardLayoutGuide = KeyboardLayoutGuide()

    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add the layout guide in the view.
        view.addLayoutGuide(keyboardLayoutGuide)
        
        // Constrain your button to the keyboardLayoutGuide's top Anchor
        // the way you would do natively :)
        button.bottomAnchor.constraint(equalTo: keyboardLayoutGuide.topAnchor).isActive = true
    }
}

