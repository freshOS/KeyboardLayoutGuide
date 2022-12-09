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
    private var keyboardConstraint: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Constrain your button to the keyboardLayoutGuide's top Anchor the way you would do natively :)
        keyboardConstraint = button.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor)
        keyboardConstraint?.isActive = true
        
        // Opt out of safe area if needed.
//         button.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuideNoSafeArea.topAnchor).isActive = true
    }

    @IBAction func showFormSheet(_ sender: Any) {
        keyboardConstraint?.isActive = false
        let vc = FormViewController.make(delegate: self)
        present(vc, animated: true)
    }
}

extension ViewController: FormViewControllerDelegate {
    func formViewControllerWillDismiss() {
        keyboardConstraint?.isActive = true
    }
}
