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

    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Opt out of safe area if needed.
        view.keyboardLayoutGuide.usesSafeArea = false
        
        // Constrain your button to the keyboardLayoutGuide's top Anchor the way you would do natively :)
        button.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor).isActive = true
    }
}
